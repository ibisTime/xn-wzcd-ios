#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface DeviceUtil : NSObject
@property (nonatomic, assign,class,readonly) CGFloat statusBarHeight;
@property (nonatomic, assign,class,readonly) CGFloat bottomInsetHeight;
+ (CGFloat)top64;
+ (CGFloat)bottom49;
@end
