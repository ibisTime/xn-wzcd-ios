#import "QNFileDelegate.h"
#import "QNHttpDelegate.h"
#import "QNUpToken.h"
#import "QNUploadManager.h"
#import <Foundation/Foundation.h>
@interface QNResumeUpload : NSObject
- (instancetype)initWithFile:(id<QNFileDelegate>)file
                     withKey:(NSString *)key
                   withToken:(QNUpToken *)token
       withCompletionHandler:(QNUpCompletionHandler)block
                  withOption:(QNUploadOption *)option
                withRecorder:(id<QNRecorderDelegate>)recorder
             withRecorderKey:(NSString *)recorderKey
             withHttpManager:(id<QNHttpDelegate>)http
           withConfiguration:(QNConfiguration *)config;
- (void)run;
@end
