#import <Foundation/Foundation.h>
extern const int kQNRequestCancelled;
extern const int kQNNetworkError;
extern const int kQNInvalidArgument;
extern const int kQNZeroDataSize;
extern const int kQNInvalidToken;
extern const int kQNFileError;
@interface QNResponseInfo : NSObject
@property (readonly) int statusCode;
@property (nonatomic, copy, readonly) NSString *reqId;
@property (nonatomic, copy, readonly) NSString *xlog;
@property (nonatomic, copy, readonly) NSString *xvia;
@property (nonatomic, copy, readonly) NSError *error;
@property (nonatomic, copy, readonly) NSString *host;
@property (nonatomic, readonly) double duration;
@property (nonatomic, readonly) NSString *serverIp;
@property (nonatomic, readonly) NSString *id;
@property (readonly) UInt64 timeStamp;
@property (nonatomic, readonly, getter=isCancelled) BOOL canceled;
@property (nonatomic, readonly, getter=isOK) BOOL ok;
@property (nonatomic, readonly, getter=isConnectionBroken) BOOL broken;
@property (nonatomic, readonly) BOOL couldRetry;
@property (nonatomic, readonly) BOOL needSwitchServer;
@property (nonatomic, readonly, getter=isNotQiniu) BOOL notQiniu;
+ (instancetype)cancel;
+ (instancetype)responseInfoWithInvalidArgument:(NSString *)desc;
+ (instancetype)responseInfoWithInvalidToken:(NSString *)desc;
+ (instancetype)responseInfoWithNetError:(NSError *)error
                                    host:(NSString *)host
                                duration:(double)duration;
+ (instancetype)responseInfoWithFileError:(NSError *)error;
+ (instancetype)responseInfoOfZeroData:(NSString *)path;
- (instancetype)init:(int)status
           withReqId:(NSString *)reqId
            withXLog:(NSString *)xlog
            withXVia:(NSString *)xvia
            withHost:(NSString *)host
              withIp:(NSString *)ip
        withDuration:(double)duration
            withBody:(NSData *)body;
@end
