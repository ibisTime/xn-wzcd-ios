#import <Foundation/Foundation.h>
#import "AFNetworking.h"
@interface TLNetworking : NSObject
+ (AFHTTPSessionManager *)HTTPSessionManager;
@property (nonatomic,strong, readonly) AFHTTPSessionManager *manager;
@property (nonatomic,strong)  NSMutableDictionary *parameters;
@property (nonatomic,copy) NSString *code; 
@property (nonatomic,strong) UIView *showView; 
@property (nonatomic,assign) BOOL isShowMsg; 
@property (nonatomic,copy) NSString *url;
@property (nonatomic, copy) NSString *isShow;
- (NSURLSessionDataTask *)postWithSuccess:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;
+ (NSURLSessionDataTask *)POST:(NSString *)URLString
                    parameters:(NSDictionary *)parameters
                       success:( void (^)(id responseObject))success
                       failure: (void (^)(NSError *error))failure;
+ (NSURLSessionDataTask *)GET:(NSString *)URLString
                   parameters:(NSDictionary *)parameters
                      success:(void (^)(NSString *msg,id data))success
                  abnormality:(void (^)())abnormality
                      failure:(void (^)(NSError *error))failure;
+ (NSString *)ipUrl;
@end
