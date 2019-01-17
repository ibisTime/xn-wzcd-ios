#import <UIKit/UIKit.h>
#import "PopoverAction.h"
UIKIT_EXTERN float const PopoverViewCellHorizontalMargin; 
UIKIT_EXTERN float const PopoverViewCellVerticalMargin; 
UIKIT_EXTERN float const PopoverViewCellTitleLeftEdge; 
@class PopoverAction;
@interface PopoverViewCell : UITableViewCell
@property (nonatomic, assign) PopoverViewStyle style;
+ (UIFont *)titleFont;
+ (UIColor *)bottomLineColorForStyle:(PopoverViewStyle)style;
- (void)setAction:(PopoverAction *)action;
- (void)showBottomLine:(BOOL)show;
@end
