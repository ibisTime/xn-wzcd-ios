#import <UIKit/UIKit.h>
@interface UIColor (Extension)
- (UIImage *)convertToImage;
+ (UIColor *)colorWithHexString:(NSString *)color;
+ (UIColor *)colorWithUIColor:(UIColor *)color alpha:(CGFloat)alpha;
@end
