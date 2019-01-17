#ifndef QNPipeline_h
#define QNPipeline_h
@class QNResponseInfo;
@interface QNPipelineConfig : NSObject
@property (copy, nonatomic, readonly) NSString *host;
@property (assign) UInt32 timeoutInterval;
- (instancetype)initWithHost:(NSString *)host;
- (instancetype)init;
@end
typedef void (^QNPipelineCompletionHandler)(QNResponseInfo *info);
@interface QNPipeline : NSObject
- (instancetype)init:(QNPipelineConfig *)config;
- (void)pumpRepo:(NSString *)repo
           event:(NSDictionary *)data
           token:(NSString *)token
         handler:(QNPipelineCompletionHandler)handler;
- (void)pumpRepo:(NSString *)repo
          events:(NSArray<NSDictionary *> *)data
           token:(NSString *)token
         handler:(QNPipelineCompletionHandler)handler;
@end
#endif 
