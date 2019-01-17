#import <UIKit/UIKit.h>
@interface UIButton (Custom)
+ (UIButton *)buttonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor backgroundColor:(UIColor *)backgroundColor titleFont:(CGFloat)titleFont;
+ (UIButton *)buttonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor backgroundColor:(UIColor *)backgroundColor titleFont:(CGFloat)titleFont cornerRadius:(CGFloat)cornerRadius;
+ (UIButton *)buttonWithImageName:(NSString *)imageName;
+ (UIButton *)buttonWithImageName:(NSString *)imageName cornerRadius:(CGFloat)cornerRadius;
+ (UIButton *)buttonWithImageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName;
- ( instancetype )initWithFrame:(CGRect)frame
                          title:(NSString *)title
                backgroundColor:(UIColor *)color;
- (void)setBackgroundColor:(UIColor *)color forState:(UIControlState)state;
@end
