#import <UIKit/UIWindow.h>
@class UIViewController;
@interface UIWindow (IQ_UIWindow_Hierarchy)
@property (nullable, nonatomic, readonly, strong) UIViewController *topMostWindowController;
@property (nullable, nonatomic, readonly, strong) UIViewController *currentViewController;
@end
