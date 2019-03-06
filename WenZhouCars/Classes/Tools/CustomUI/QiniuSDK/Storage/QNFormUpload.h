#import "QNHttpDelegate.h"
#import "QNUpToken.h"
#import "QNUploadManager.h"
#import <Foundation/Foundation.h>
@interface QNFormUpload : NSObject
- (instancetype)initWithData:(NSData *)data
                     withKey:(NSString *)key
                   withToken:(QNUpToken *)token
       withCompletionHandler:(QNUpCompletionHandler)block
                  withOption:(QNUploadOption *)option
             withHttpManager:(id<QNHttpDelegate>)http
           withConfiguration:(QNConfiguration *)config;
- (void)put;
@end
