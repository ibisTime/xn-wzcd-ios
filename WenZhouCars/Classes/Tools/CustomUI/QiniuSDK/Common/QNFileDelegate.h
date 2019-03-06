#import <Foundation/Foundation.h>
@protocol QNFileDelegate <NSObject>
- (NSData *)read:(long)offset
            size:(long)size;
- (NSData *)readAll;
- (void)close;
- (NSString *)path;
- (int64_t)modifyTime;
- (int64_t)size;
@end
