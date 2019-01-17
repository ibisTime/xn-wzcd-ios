#import "IQUIView+Hierarchy.h"
#import <UIKit/UICollectionView.h>
#import <UIKit/UIAlertController.h>
#import <UIKit/UITableView.h>
#import <UIKit/UITextView.h>
#import <UIKit/UITextField.h>
#import <UIKit/UISearchBar.h>
#import <UIKit/UIViewController.h>
#import <UIKit/UIWindow.h>
#import <objc/runtime.h>
#import "IQNSArray+Sort.h"
@implementation UIView (IQ_UIView_Hierarchy)
-(UIViewController*)viewController
{
    UIResponder *nextResponder =  self;
    do
    {
        nextResponder = [nextResponder nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]])
            return (UIViewController*)nextResponder;
    } while (nextResponder != nil);
    return nil;
}
-(UIViewController *)topMostController
{
    NSMutableArray<UIViewController*> *controllersHierarchy = [[NSMutableArray alloc] init];
    UIViewController *topController = self.window.rootViewController;
    if (topController)
    {
        [controllersHierarchy addObject:topController];
    }
    while ([topController presentedViewController]) {
        topController = [topController presentedViewController];
        [controllersHierarchy addObject:topController];
    }
    UIViewController *matchController = [self viewController];
    while (matchController != nil && [controllersHierarchy containsObject:matchController] == NO)
    {
        do
        {
            matchController = (UIViewController*)[matchController nextResponder];
        } while (matchController != nil && [matchController isKindOfClass:[UIViewController class]] == NO);
    }
    return (UIViewController*)matchController;
}
-(UIView*)superviewOfClassType:(Class)classType
{
    UIView *superview = self.superview;
    while (superview)
    {
        if ([superview isKindOfClass:classType])
        {
            if ([superview isKindOfClass:[UIScrollView class]])
            {
                NSString *classNameString = NSStringFromClass([superview class]);
                if ([superview.superview isKindOfClass:[UITableView class]] == NO &&
                    [superview.superview isKindOfClass:[UITableViewCell class]] == NO &&
                    [classNameString hasPrefix:@"_"] == NO)
                {
                    return superview;
                }
            }
            else
            {
                return superview;
            }
        }
        superview = superview.superview;
    }
    return nil;
}
-(BOOL)_IQcanBecomeFirstResponder
{
    BOOL _IQcanBecomeFirstResponder = NO;
    if ([self isKindOfClass:[UITextField class]])
    {
        _IQcanBecomeFirstResponder = [(UITextField*)self isEnabled];
    }
    else if ([self isKindOfClass:[UITextView class]])
    {
        _IQcanBecomeFirstResponder = [(UITextView*)self isEditable];
    }
    if (_IQcanBecomeFirstResponder == YES)
    {
        _IQcanBecomeFirstResponder = ([self isUserInteractionEnabled] && ![self isHidden] && [self alpha]!=0.0 && ![self isAlertViewTextField]  && ![self isSearchBarTextField]);
    }
    return _IQcanBecomeFirstResponder;
}
- (NSArray*)responderSiblings
{
    NSArray *siblings = self.superview.subviews;
    NSMutableArray<UIView*> *tempTextFields = [[NSMutableArray alloc] init];
    for (UIView *textField in siblings)
        if ([textField _IQcanBecomeFirstResponder])
            [tempTextFields addObject:textField];
    return tempTextFields;
}
- (NSArray*)deepResponderViews
{
    NSMutableArray<UIView*> *textFields = [[NSMutableArray alloc] init];
    for (UIView *textField in self.subviews)
    {
        if ([textField _IQcanBecomeFirstResponder])
        {
            [textFields addObject:textField];
        }
        if (textField.subviews.count && [textField isUserInteractionEnabled] && ![textField isHidden] && [textField alpha]!=0.0)
        {
            [textFields addObjectsFromArray:[textField deepResponderViews]];
        }
    }
    return [textFields sortedArrayUsingComparator:^NSComparisonResult(UIView *view1, UIView *view2) {
        CGRect frame1 = [view1 convertRect:view1.bounds toView:self];
        CGRect frame2 = [view2 convertRect:view2.bounds toView:self];
        CGFloat x1 = CGRectGetMinX(frame1);
        CGFloat y1 = CGRectGetMinY(frame1);
        CGFloat x2 = CGRectGetMinX(frame2);
        CGFloat y2 = CGRectGetMinY(frame2);
        if (y1 < y2)  return NSOrderedAscending;
        else if (y1 > y2) return NSOrderedDescending;
        else if (x1 < x2)  return NSOrderedAscending;
        else if (x1 > x2) return NSOrderedDescending;
        else    return NSOrderedSame;
    }];
    return textFields;
}
-(CGAffineTransform)convertTransformToView:(UIView*)toView
{
    if (toView == nil)
    {
        toView = self.window;
    }
    CGAffineTransform myTransform = CGAffineTransformIdentity;
    {
        UIView *superView = [self superview];
        if (superView)  myTransform = CGAffineTransformConcat(self.transform, [superView convertTransformToView:nil]);
        else            myTransform = self.transform;
    }
    CGAffineTransform viewTransform = CGAffineTransformIdentity;
    {
        UIView *superView = [toView superview];
        if (superView)  viewTransform = CGAffineTransformConcat(toView.transform, [superView convertTransformToView:nil]);
        else if (toView)  viewTransform = toView.transform;
    }
    return CGAffineTransformConcat(myTransform, CGAffineTransformInvert(viewTransform));
}
- (NSInteger)depth
{
    NSInteger depth = 0;
    if ([self superview])
    {
        depth = [[self superview] depth] + 1;
    }
    return depth;
}
- (NSString *)subHierarchy
{
    NSMutableString *debugInfo = [[NSMutableString alloc] initWithString:@"\n"];
    NSInteger depth = [self depth];
    for (int counter = 0; counter < depth; counter ++)  [debugInfo appendString:@"|  "];
    [debugInfo appendString:[self debugHierarchy]];
    for (UIView *subview in self.subviews)
    {
        [debugInfo appendString:[subview subHierarchy]];
    }
    return debugInfo;
}
- (NSString *)superHierarchy
{
    NSMutableString *debugInfo = [[NSMutableString alloc] init];
    if (self.superview)
    {
        [debugInfo appendString:[self.superview superHierarchy]];
    }
    else
    {
        [debugInfo appendString:@"\n"];
    }
    NSInteger depth = [self depth];
    for (int counter = 0; counter < depth; counter ++)  [debugInfo appendString:@"|  "];
    [debugInfo appendString:[self debugHierarchy]];
    [debugInfo appendString:@"\n"];
    return debugInfo;
}
-(NSString *)debugHierarchy
{
    NSMutableString *debugInfo = [[NSMutableString alloc] init];
    [debugInfo appendFormat:@"%@: ( %.0f, %.0f, %.0f, %.0f )",NSStringFromClass([self class]), CGRectGetMinX(self.frame), CGRectGetMinY(self.frame), CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)];
    if ([self isKindOfClass:[UIScrollView class]])
    {
        UIScrollView *scrollView = (UIScrollView*)self;
        [debugInfo appendFormat:@"%@: ( %.0f, %.0f )",NSStringFromSelector(@selector(contentSize)),scrollView.contentSize.width,scrollView.contentSize.height];
    }
    if (CGAffineTransformEqualToTransform(self.transform, CGAffineTransformIdentity) == false)
    {
        [debugInfo appendFormat:@"%@: %@",NSStringFromSelector(@selector(transform)),NSStringFromCGAffineTransform(self.transform)];
    }
    return debugInfo;
}
-(BOOL)isSearchBarTextField
{
    UIResponder *searchBar = [self nextResponder];
    BOOL isSearchBarTextField = NO;
    while (searchBar && isSearchBarTextField == NO)
    {
        if ([searchBar isKindOfClass:[UISearchBar class]])
        {
            isSearchBarTextField = YES;
            break;
        }
        else if ([searchBar isKindOfClass:[UIViewController class]])    
        {
            break;
        }
        searchBar = [searchBar nextResponder];
    }
    return isSearchBarTextField;
}
-(BOOL)isAlertViewTextField
{
    UIResponder *alertViewController = [self viewController];
    BOOL isAlertViewTextField = NO;
    while (alertViewController && isAlertViewTextField == NO)
    {
        if ([alertViewController isKindOfClass:[UIAlertController class]])
        {
            isAlertViewTextField = YES;
            break;
        }
        alertViewController = [alertViewController nextResponder];
    }
    return isAlertViewTextField;
}
@end
@implementation NSObject (IQ_Logging)
-(NSString *)_IQDescription
{
    return [NSString stringWithFormat:@"<%@ %p>",NSStringFromClass([self class]),self];
}
@end
