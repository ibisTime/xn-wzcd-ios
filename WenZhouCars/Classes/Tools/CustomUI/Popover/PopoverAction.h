#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, PopoverViewStyle) {
    PopoverViewStyleDefault = 0, 
    PopoverViewStyleDark, 
};
@interface PopoverAction : NSObject
@property (nonatomic, strong, readonly) UIImage *image; 
@property (nonatomic, copy, readonly) NSString *title; 
@property (nonatomic, copy, readonly) void(^handler)(PopoverAction *action); 
+ (instancetype)actionWithTitle:(NSString *)title handler:(void (^)(PopoverAction *action))handler;
+ (instancetype)actionWithImage:(UIImage *)image title:(NSString *)title handler:(void (^)(PopoverAction *action))handler;
@end
