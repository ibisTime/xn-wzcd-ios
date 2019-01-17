#import <Foundation/Foundation.h>
@interface QNCrc32 : NSObject
+ (UInt32)file:(NSString *)filePath
         error:(NSError **)error;
+ (UInt32)data:(NSData *)data;
@end
