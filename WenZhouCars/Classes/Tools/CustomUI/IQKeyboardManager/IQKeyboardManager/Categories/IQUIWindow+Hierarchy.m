#import "IQUIWindow+Hierarchy.h"
#import <UIKit/UINavigationController.h>
@implementation UIWindow (IQ_UIWindow_Hierarchy)
- (UIViewController*)topMostWindowController
{
    UIViewController *topController = [self rootViewController];
    while ([topController presentedViewController])	topController = [topController presentedViewController];
    return topController;
}
- (UIViewController*)currentViewController;
{
    UIViewController *currentViewController = [self topMostWindowController];
    while ([currentViewController isKindOfClass:[UINavigationController class]] && [(UINavigationController*)currentViewController topViewController])
        currentViewController = [(UINavigationController*)currentViewController topViewController];
    return currentViewController;
}
@end
