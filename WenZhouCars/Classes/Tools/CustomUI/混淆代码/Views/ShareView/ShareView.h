#import <UIKit/UIKit.h>
#import "ShareButton.h"
@interface ShareView : UIView
@property (nonatomic , copy ) void (^openShareBlock)(ShareType type);
- (instancetype)initWithFrame:(CGRect)frame
                    InfoArray:(NSArray *)infoArray
                MaxLineNumber:(NSInteger)maxLineNumber
               MaxSingleCount:(NSInteger)maxSingleCount;
@end
