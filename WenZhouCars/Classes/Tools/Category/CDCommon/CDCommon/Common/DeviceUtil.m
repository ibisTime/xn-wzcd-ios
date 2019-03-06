#import "DeviceUtil.h"
@implementation DeviceUtil
+ (CGFloat)statusBarHeight {
    if ([self isPhoneX]) {
        return 20 + 24;
    }
    return 20;
}
+ (CGFloat)bottomInsetHeight {
    return [self isPhoneX] ? 34 : 0;
}
+ (CGFloat)top64 {
    if ([self isPhoneX]) {
        return 44 + self.statusBarHeight;
    } else {
        return 44 + self.statusBarHeight;
    }
}
+ (BOOL)isPhoneX {
    return [UIScreen mainScreen].bounds.size.height == 812;
}
+ (CGFloat)bottom49 {
    return 49 + self.bottomInsetHeight;
}
@end
