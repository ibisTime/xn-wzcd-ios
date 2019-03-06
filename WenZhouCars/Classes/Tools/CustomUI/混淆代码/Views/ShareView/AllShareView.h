#import <UIKit/UIKit.h>
#import "ShareButton.h"
typedef enum {
    MoreTypeToTheme = 0, 
    MoreTypeToReport, 
    MoreTypeToFontSize, 
    MoreTypeToCopyLink, 
} MoreType;
@interface AllShareView : UIView
- (instancetype)initWithFrame:(CGRect)frame ShowMore:(BOOL)showMore;
- (instancetype)initWithFrame:(CGRect)frame ShowMore:(BOOL)showMore ShowReport:(BOOL)showReport;
@property (nonatomic , copy ) void (^openShareBlock)(ShareType type);
@property (nonatomic , copy ) void (^openMoreBlock)(MoreType type);
- (void)show;
@end
