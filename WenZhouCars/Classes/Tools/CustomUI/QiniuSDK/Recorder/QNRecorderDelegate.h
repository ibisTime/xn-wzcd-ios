#import <Foundation/Foundation.h>
typedef NSString * (^QNRecorderKeyGenerator)(NSString *uploadKey, NSString *filePath);
@protocol QNRecorderDelegate <NSObject>
- (NSError *)set:(NSString *)key
            data:(NSData *)value;
- (NSData *)get:(NSString *)key;
- (NSError *)del:(NSString *)key;
@end
