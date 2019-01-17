#import <Foundation/Foundation.h>
@interface HttpLogger : NSObject
+ (void)logDebugInfoWithRequest:(NSURLRequest *)request
                        apiName:(NSString *)apiName
                  requestParams:(id)requestParams
                     httpMethod:(NSString *)httpMethod;
+ (void)logDebugInfoWithResponse:(NSURLResponse *)response
                         apiName:(NSString *)apiName
                   resposeString:(NSString *)responseString
                         request:(NSURLRequest *)request
                           error:(NSError *)error;
+ (void)logJSONStringWithResponseObject:(id)responseObject;
@end
