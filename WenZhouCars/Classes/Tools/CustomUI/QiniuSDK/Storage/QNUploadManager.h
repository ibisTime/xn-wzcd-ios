#import <Foundation/Foundation.h>
#import "QNRecorderDelegate.h"
@class QNResponseInfo;
@class QNUploadOption;
@class QNConfiguration;
@class ALAsset;
@class PHAsset;
@class PHAssetResource;
typedef void (^QNUpCompletionHandler)(QNResponseInfo *info, NSString *key, NSDictionary *resp);
@interface QNUploadManager : NSObject
- (instancetype)init;
- (instancetype)initWithRecorder:(id<QNRecorderDelegate>)recorder;
- (instancetype)initWithRecorder:(id<QNRecorderDelegate>)recorder
            recorderKeyGenerator:(QNRecorderKeyGenerator)recorderKeyGenerator;
- (instancetype)initWithConfiguration:(QNConfiguration *)config;
+ (instancetype)sharedInstanceWithConfiguration:(QNConfiguration *)config;
- (void)putData:(NSData *)data
            key:(NSString *)key
          token:(NSString *)token
       complete:(QNUpCompletionHandler)completionHandler
         option:(QNUploadOption *)option;
- (void)putFile:(NSString *)filePath
            key:(NSString *)key
          token:(NSString *)token
       complete:(QNUpCompletionHandler)completionHandler
         option:(QNUploadOption *)option;
- (void)putALAsset:(ALAsset *)asset
               key:(NSString *)key
             token:(NSString *)token
          complete:(QNUpCompletionHandler)completionHandler
            option:(QNUploadOption *)option;
- (void)putPHAsset:(PHAsset *)asset
               key:(NSString *)key
             token:(NSString *)token
          complete:(QNUpCompletionHandler)completionHandler
            option:(QNUploadOption *)option;
- (void)putPHAssetResource:(PHAssetResource *)assetResource
                       key:(NSString *)key
                     token:(NSString *)token
                  complete:(QNUpCompletionHandler)completionHandler
                    option:(QNUploadOption *)option;
@end
