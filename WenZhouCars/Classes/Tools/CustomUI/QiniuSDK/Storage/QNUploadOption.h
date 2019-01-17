#import <Foundation/Foundation.h>
typedef void (^QNUpProgressHandler)(NSString *key, float percent);
typedef BOOL (^QNUpCancellationSignal)(void);
@interface QNUploadOption : NSObject
@property (copy, nonatomic, readonly) NSDictionary *params;
@property (copy, nonatomic, readonly) NSString *mimeType;
@property (readonly) BOOL checkCrc;
@property (copy, readonly) QNUpProgressHandler progressHandler;
@property (copy, readonly) QNUpCancellationSignal cancellationSignal;
- (instancetype)initWithMime:(NSString *)mimeType
             progressHandler:(QNUpProgressHandler)progress
                      params:(NSDictionary *)params
                    checkCrc:(BOOL)check
          cancellationSignal:(QNUpCancellationSignal)cancellation;
- (instancetype)initWithProgessHandler:(QNUpProgressHandler)progress DEPRECATED_ATTRIBUTE;
- (instancetype)initWithProgressHandler:(QNUpProgressHandler)progress;
+ (instancetype)defaultOptions;
@end
