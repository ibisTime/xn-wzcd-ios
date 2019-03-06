#import <Foundation/Foundation.h>
@interface QNEtag : NSObject
+ (NSString *)file:(NSString *)filePath
             error:(NSError **)error;
+ (NSString *)data:(NSData *)data;
@end
