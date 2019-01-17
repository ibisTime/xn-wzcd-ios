#import <Foundation/Foundation.h>
@interface QNUserAgent : NSObject
@property (copy, nonatomic, readonly) NSString *id;
- (NSString *)description;
- (NSString *)getUserAgent:(NSString *)access;
+ (instancetype)sharedInstance;
@end
