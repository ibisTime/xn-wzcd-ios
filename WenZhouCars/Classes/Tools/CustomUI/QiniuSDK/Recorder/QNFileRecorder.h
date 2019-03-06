#import "QNRecorderDelegate.h"
#import <Foundation/Foundation.h>
@interface QNFileRecorder : NSObject <QNRecorderDelegate>
+ (instancetype)fileRecorderWithFolder:(NSString *)directory
                                 error:(NSError *__autoreleasing *)error;
+ (instancetype)fileRecorderWithFolder:(NSString *)directory
                             encodeKey:(BOOL)encode
                                 error:(NSError *__autoreleasing *)error;
+ (void)removeKey:(NSString *)key
        directory:(NSString *)dir
        encodeKey:(BOOL)encode;
@end
