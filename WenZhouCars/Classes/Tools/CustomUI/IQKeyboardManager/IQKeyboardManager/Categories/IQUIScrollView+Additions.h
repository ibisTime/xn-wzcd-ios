#import <UIKit/UIKit.h>
@interface UIScrollView (Additions)
@property(nonatomic, assign) BOOL shouldIgnoreScrollingAdjustment;
@property(nonatomic, assign) BOOL shouldRestoreScrollViewContentOffset;
@end
