#import <UIKit/UIKit.h>
#import "PopoverAction.h"
@interface PopoverView : UIView
@property (nonatomic, assign) BOOL hideAfterTouchOutside; 
@property (nonatomic, assign) BOOL showShade; 
@property (nonatomic, assign) PopoverViewStyle style; 
+ (instancetype)popoverView;
- (void)showToView:(UIView *)pointView withActions:(NSArray<PopoverAction *> *)actions;
- (void)showToPoint:(CGPoint)toPoint withActions:(NSArray<PopoverAction *> *)actions;
@end
