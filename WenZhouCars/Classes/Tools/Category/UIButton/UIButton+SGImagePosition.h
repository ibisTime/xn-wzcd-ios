#import <UIKit/UIKit.h>
typedef enum : NSUInteger {
    SGImagePositionStyleDefault,
    SGImagePositionStyleRight,
    SGImagePositionStyleTop,
    SGImagePositionStyleBottom,
} SGImagePositionStyle;
@interface UIButton (SGImagePosition)
- (void)SG_imagePositionStyle:(SGImagePositionStyle)imagePositionStyle spacing:(CGFloat)spacing;
- (void)SG_imagePositionStyle:(SGImagePositionStyle)imagePositionStyle spacing:(CGFloat)spacing imagePositionBlock:(void (^)(UIButton *button))imagePositionBlock;
@end
