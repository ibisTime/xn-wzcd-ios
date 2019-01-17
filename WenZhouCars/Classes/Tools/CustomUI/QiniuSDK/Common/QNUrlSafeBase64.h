#import <Foundation/Foundation.h>
@interface QNUrlSafeBase64 : NSObject
+ (NSString *)encodeString:(NSString *)source;
+ (NSString *)encodeData:(NSData *)source;
+ (NSData *)decodeString:(NSString *)data;
@end
