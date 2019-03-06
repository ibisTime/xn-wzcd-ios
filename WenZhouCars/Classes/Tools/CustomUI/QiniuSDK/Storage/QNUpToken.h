#import <Foundation/Foundation.h>
@interface QNUpToken : NSObject
+ (instancetype)parse:(NSString *)token;
@property (copy, nonatomic, readonly) NSString *access;
@property (copy, nonatomic, readonly) NSString *bucket;
@property (copy, nonatomic, readonly) NSString *token;
@property (readonly) BOOL hasReturnUrl;
- (NSString *)index;
@end
