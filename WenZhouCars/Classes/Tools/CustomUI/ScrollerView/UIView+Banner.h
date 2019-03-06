#import <UIKit/UIKit.h>
@interface UIView (Banner)
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat top;
@property (nonatomic, assign) CGFloat bottom;
@property (nonatomic, assign) CGFloat left;
@property (nonatomic, assign) CGFloat right;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGPoint origin;
- (void)addProjectionWithShadowOpacity:(CGFloat)shadowOpacity;
- (void)addBorderWithWidth:(CGFloat)width;
- (void)addBorderWithWidth:(CGFloat)width borderColor:(UIColor *)borderColor;
- (void)addRoundedCornersWithRadius:(CGFloat)radius;
- (void)addRoundedCornersWithRadius:(CGFloat)radius byRoundingCorners:(UIRectCorner)corners;
@end
