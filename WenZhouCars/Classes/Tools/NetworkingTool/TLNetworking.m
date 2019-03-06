#import "TLNetworking.h"
#import "TLProgressHUD.h"
#import "TLAlert.h"
#import "HttpLogger.h"
#import "SVProgressHUD.h"
#import "BaseViewController.h"
@interface TLNetworking()
@property (nonatomic, strong) BaseViewController *baseVC;
@end
@implementation TLNetworking
- (BaseViewController *)baseVC {
    if (!_baseVC) {
    }
    return _baseVC;
}
+ (AFHTTPSessionManager *)HTTPSessionManager
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    manager.requestSerializer.timeoutInterval = 15.0;
    AFJSONResponseSerializer *response = [AFJSONResponseSerializer serializer];
    response.removesKeysWithNullValues = YES;
    manager.responseSerializer = response;
    NSSet *set = manager.responseSerializer.acceptableContentTypes;
    set = [set setByAddingObject:@"text/plain"];
    set = [set setByAddingObject:@"text/html"];
    manager.responseSerializer.acceptableContentTypes = set;
    return manager;
}
- (instancetype)init{
    if(self = [super init]){
       _manager = [[self class] HTTPSessionManager];
        _isShowMsg = YES;
        self.parameters = [NSMutableDictionary dictionary];
    }
    return self;
}
- (NSURLSessionDataTask *)postWithSuccess:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    if(self.showView){
        [TLProgressHUD show];
    }
    if (self.isShowMsg) {
    }
    if(self.code && self.code.length > 0){
        if (![_isShow isEqualToString:@"100"]) {
        }
    }
    NSData *data = [NSJSONSerialization dataWithJSONObject:self.parameters options:NSJSONWritingPrettyPrinted error:nil];
    self.parameters = [NSMutableDictionary dictionaryWithCapacity:2];
    self.parameters[@"companyCode"] = @"CD-CWZCD000020";
    self.parameters[@"systemCode"] = @"CD-CWZCD000020";
    self.parameters[@"json"] = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
    self.parameters[@"code"] = self.code;
    NSLog(@"%@",self.parameters);
    return [self.manager POST:APPURL parameters:self.parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
      [HttpLogger logDebugInfoWithResponse:task.response apiName:self.code resposeString:responseObject request:task.originalRequest error:nil];
      [HttpLogger logJSONStringWithResponseObject:responseObject];
      if(self.showView){
          [TLProgressHUD dismiss];
      }
      if([responseObject[@"errorCode"] isEqual:@"0"]){ 
          if(success) {
              dispatch_async(dispatch_get_main_queue(), ^{
                  if (self.baseVC) {
                      if ([self.baseVC isKindOfClass:[BaseViewController class]]) {
                      }
                  }
              });
              success(responseObject);
          }
      } else {
          if (failure) {
              failure(nil);
          }
          if ([responseObject[@"errorCode"] isEqual:@"4"]) {
              [TLAlert alertWithTitle:@"提示" message:@"为了您的账户安全,请重新登录" confirmAction:^{
              }];
              return;
          }
          if(self.isShowMsg) { 
              [TLAlert alertWithInfo:responseObject[@"errorInfo"]];
          }
      }
   } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       if(self.showView) {
           [TLProgressHUD dismiss];
       }
       if (self.isShowMsg) {
           [TLAlert alertWithInfo:@"网络异常"];
       }
       if(failure) {
           dispatch_async(dispatch_get_main_queue(), ^{
               if (self.baseVC) {
               }
           });
           failure(error);
       }
   }];
}
- (void)hundleSuccess:(id)responseObj {
    if([responseObj[@"success"] isEqual:@1]){
    }
}
+ (NSURLSessionDataTask *)POST:(NSString *)URLString
                    parameters:(NSDictionary *)parameters
                       success:(void (^)(id responseObject))success
                       failure: (void (^)(NSError *error))failure{
    AFHTTPSessionManager *manager = [self HTTPSessionManager];
    return [manager POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(failure){
            failure(error);
        }
    }];
}
+ (NSURLSessionDataTask *)POST:(NSString *)URLString
                       parameters:(NSDictionary *)parameters
                          success:(void (^)(id responseObject))success
                      abnormality:(void (^)(NSString *msg))abnormality
                          failure:(void (^)(NSError * _Nullable  error))failure;
{
    AFHTTPSessionManager *manager = [self HTTPSessionManager];
    return [manager POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(failure){
            failure(error);
        }
    }];
}
+ (NSURLSessionDataTask *)GET:(NSString *)URLString
                      parameters:(NSDictionary *)parameters
                         success:(void (^)(NSString *msg,id data))success
                     abnormality:(void (^)())abnormality
                         failure:(void (^)(NSError *error))failure;
{
    AFHTTPSessionManager *manager = [self HTTPSessionManager];
    return [manager GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(@"",responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}
@end
