#import "UIColor+theme.h"
#import "UIColor+Extension.h"
@implementation UIColor (theme)
+ (UIColor *)themeColor {
    return [self colorWithHexString:@"#f15353"];
}
+ (UIColor *)textColor {
    return [self colorWithHexString:@"#484848"];
}
+ (UIColor *)textColor2 {
    return [self colorWithHexString:@""];
}
+ (UIColor *)lineColor {
    return [self colorWithHexString:@"#eeeeee"];
}
+ (UIColor *)backgroundColor {
    return [self colorWithHexString:@"#fafafa"];
}
+ (UIColor *)customYellowColor {
    return [UIColor colorWithHexString:@"#dab616"];
}
@end
