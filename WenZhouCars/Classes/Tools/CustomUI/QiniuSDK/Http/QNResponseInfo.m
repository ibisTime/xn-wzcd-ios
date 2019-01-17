#import "QNResponseInfo.h"
#import "QNUserAgent.h"
#import "QNVersion.h"
const int kQNZeroDataSize = -6;
const int kQNInvalidToken = -5;
const int kQNFileError = -4;
const int kQNInvalidArgument = -3;
const int kQNRequestCancelled = -2;
const int kQNNetworkError = -1;
static QNResponseInfo *cancelledInfo = nil;
static NSString *domain = @"qiniu.com";
@implementation QNResponseInfo
+ (instancetype)cancel {
    return [[QNResponseInfo alloc] initWithCancelled];
}
+ (instancetype)responseInfoWithInvalidArgument:(NSString *)text {
    return [[QNResponseInfo alloc] initWithStatus:kQNInvalidArgument errorDescription:text];
}
+ (instancetype)responseInfoWithInvalidToken:(NSString *)text {
    return [[QNResponseInfo alloc] initWithStatus:kQNInvalidToken errorDescription:text];
}
+ (instancetype)responseInfoWithNetError:(NSError *)error host:(NSString *)host duration:(double)duration {
    int code = kQNNetworkError;
    if (error != nil) {
        code = (int)error.code;
    }
    return [[QNResponseInfo alloc] initWithStatus:code error:error host:host duration:duration];
}
+ (instancetype)responseInfoWithFileError:(NSError *)error {
    return [[QNResponseInfo alloc] initWithStatus:kQNFileError error:error];
}
+ (instancetype)responseInfoOfZeroData:(NSString *)path {
    NSString *desc;
    if (path == nil) {
        desc = @"data size is 0";
    } else {
        desc = [[NSString alloc] initWithFormat:@"file %@ size is 0", path];
    }
    return [[QNResponseInfo alloc] initWithStatus:kQNZeroDataSize errorDescription:desc];
}
- (instancetype)initWithCancelled {
    return [self initWithStatus:kQNRequestCancelled errorDescription:@"cancelled by user"];
}
- (instancetype)initWithStatus:(int)status
                         error:(NSError *)error {
    return [self initWithStatus:status error:error host:nil duration:0];
}
- (instancetype)initWithStatus:(int)status
                         error:(NSError *)error
                          host:(NSString *)host
                      duration:(double)duration {
    if (self = [super init]) {
        _statusCode = status;
        _error = error;
        _host = host;
        _duration = duration;
        _id = [QNUserAgent sharedInstance].id;
        _timeStamp = [[NSDate date] timeIntervalSince1970];
    }
    return self;
}
- (instancetype)initWithStatus:(int)status
              errorDescription:(NSString *)text {
    NSError *error = [[NSError alloc] initWithDomain:domain code:status userInfo:@{ @"error" : text }];
    return [self initWithStatus:status error:error];
}
- (instancetype)init:(int)status
           withReqId:(NSString *)reqId
            withXLog:(NSString *)xlog
            withXVia:(NSString *)xvia
            withHost:(NSString *)host
              withIp:(NSString *)ip
        withDuration:(double)duration
            withBody:(NSData *)body {
    if (self = [super init]) {
        _statusCode = status;
        _reqId = reqId;
        _xlog = xlog;
        _xvia = xvia;
        _host = host;
        _duration = duration;
        _serverIp = ip;
        _id = [QNUserAgent sharedInstance].id;
        _timeStamp = [[NSDate date] timeIntervalSince1970];
        if (status != 200) {
            if (body == nil) {
                _error = [[NSError alloc] initWithDomain:domain code:_statusCode userInfo:nil];
            } else {
                NSError *tmp;
                NSDictionary *uInfo = [NSJSONSerialization JSONObjectWithData:body options:NSJSONReadingMutableLeaves error:&tmp];
                if (tmp != nil) {
                    NSString *str = [[NSString alloc] initWithData:body encoding:NSUTF8StringEncoding];
                    if (str == nil) {
                        str = @"";
                    }
                    uInfo = @{ @"error" : str };
                }
                _error = [[NSError alloc] initWithDomain:domain code:_statusCode userInfo:uInfo];
            }
        } else if (body == nil || body.length == 0) {
            NSDictionary *uInfo = @{ @"error" : @"no response json" };
            _error = [[NSError alloc] initWithDomain:domain code:_statusCode userInfo:uInfo];
        }
    }
    return self;
}
- (NSString *)description {
    return [NSString stringWithFormat:@"<%@= id: %@, ver: %@, status: %d, requestId: %@, xlog: %@, xvia: %@, host: %@ ip: %@ duration: %f s time: %llu error: %@>", NSStringFromClass([self class]), _id, kQiniuVersion, _statusCode, _reqId, _xlog, _xvia, _host, _serverIp, _duration, _timeStamp, _error];
}
- (BOOL)isCancelled {
    return _statusCode == kQNRequestCancelled || _statusCode == -999;
}
- (BOOL)isNotQiniu {
    return (_statusCode >= 200 && _statusCode < 500) && _reqId == nil;
}
- (BOOL)isOK {
    return _statusCode == 200 && _error == nil && _reqId != nil;
}
- (BOOL)isConnectionBroken {
    return _statusCode == kQNNetworkError || (_statusCode < -1000 && _statusCode != -1003);
}
- (BOOL)needSwitchServer {
    return _statusCode == kQNNetworkError || (_statusCode < -1000 && _statusCode != -1003) || (_statusCode / 100 == 5 && _statusCode != 579);
}
- (BOOL)couldRetry {
    return (_statusCode >= 500 && _statusCode < 600 && _statusCode != 579) || _statusCode == kQNNetworkError || _statusCode == 996 || _statusCode == 406 || (_statusCode == 200 && _error != nil) || _statusCode < -1000 || self.isNotQiniu;
}
@end
