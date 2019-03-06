#import "IQToolbar.h"
#import "IQKeyboardManagerConstantsInternal.h"
#import "IQUIView+Hierarchy.h"
#import <UIKit/UIAccessibility.h>
#import <UIKit/UIViewController.h>
@implementation IQToolbar
@synthesize previousBarButton = _previousBarButton;
@synthesize nextBarButton = _nextBarButton;
@synthesize titleBarButton = _titleBarButton;
@synthesize doneBarButton = _doneBarButton;
+(void)initialize
{
    [super initialize];
    IQToolbar *appearanceProxy = [self appearance];
    [appearanceProxy setTintColor:nil];
    [appearanceProxy setBarTintColor:nil];
    NSArray <NSNumber*> *positions = @[@(UIBarPositionAny),@(UIBarPositionBottom),@(UIBarPositionTop),@(UIBarPositionTopAttached)];
    for (NSNumber *position in positions)
    {
        UIToolbarPosition toolbarPosition = [position unsignedIntegerValue];
        [appearanceProxy setBackgroundImage:nil forToolbarPosition:toolbarPosition barMetrics:UIBarMetricsDefault];
        [appearanceProxy setShadowImage:nil forToolbarPosition:toolbarPosition];
    }
    [appearanceProxy setBackgroundColor:nil];
}
-(void)initialize
{
    [self sizeToFit];
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.translucent = YES;
    [self setTintColor:[UIColor blackColor]];
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self initialize];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self)
    {
        [self initialize];
    }
    return self;
}
-(IQBarButtonItem *)previousBarButton
{
    if (_previousBarButton == nil)
    {
        _previousBarButton = [[IQBarButtonItem alloc] initWithImage:nil style:UIBarButtonItemStylePlain target:nil action:nil];
        _previousBarButton.accessibilityLabel = @"Toolbar Previous Button";
    }
    return _previousBarButton;
}
-(IQBarButtonItem *)nextBarButton
{
    if (_nextBarButton == nil)
    {
        _nextBarButton = [[IQBarButtonItem alloc] initWithImage:nil style:UIBarButtonItemStylePlain target:nil action:nil];
        _nextBarButton.accessibilityLabel = @"Toolbar Next Button";
    }
    return _nextBarButton;
}
-(IQTitleBarButtonItem *)titleBarButton
{
    if (_titleBarButton == nil)
    {
        _titleBarButton = [[IQTitleBarButtonItem alloc] initWithTitle:nil];
        _titleBarButton.accessibilityLabel = @"Toolbar Title Button";
    }
    return _titleBarButton;
}
-(IQBarButtonItem *)doneBarButton
{
    if (_doneBarButton == nil)
    {
        _doneBarButton = [[IQBarButtonItem alloc] initWithTitle:nil style:UIBarButtonItemStyleDone target:nil action:nil];
        _doneBarButton.accessibilityLabel = @"Toolbar Done Button";
    }
    return _doneBarButton;
}
-(CGSize)sizeThatFits:(CGSize)size
{
    CGSize sizeThatFit = [super sizeThatFits:size];
    sizeThatFit.height = 44;
    return sizeThatFit;
}
-(void)setBarStyle:(UIBarStyle)barStyle
{
    [super setBarStyle:barStyle];
    if (barStyle == UIBarStyleDefault)
    {
        [self.titleBarButton setSelectableTextColor:[UIColor colorWithRed:0.0 green:0.5 blue:1.0 alpha:1.0]];
    }
    else
    {
        [self.titleBarButton setSelectableTextColor:[UIColor yellowColor]];
    }
}
-(void)setTintColor:(UIColor *)tintColor
{
    [super setTintColor:tintColor];
    for (UIBarButtonItem *item in self.items)
    {
        [item setTintColor:tintColor];
    }
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    if (IQ_IS_IOS11_OR_GREATER == NO)
    {
        CGRect leftRect = CGRectNull;
        CGRect rightRect = CGRectNull;
        BOOL isTitleBarButtonFound = NO;
        NSArray *subviews = [self.subviews sortedArrayUsingComparator:^NSComparisonResult(UIView *view1, UIView *view2) {
            CGFloat x1 = CGRectGetMinX(view1.frame);
            CGFloat y1 = CGRectGetMinY(view1.frame);
            CGFloat x2 = CGRectGetMinX(view2.frame);
            CGFloat y2 = CGRectGetMinY(view2.frame);
            if (x1 < x2)  return NSOrderedAscending;
            else if (x1 > x2) return NSOrderedDescending;
            else if (y1 < y2)  return NSOrderedAscending;
            else if (y1 > y2) return NSOrderedDescending;
            else    return NSOrderedSame;
        }];
        for (UIView *barButtonItemView in subviews)
        {
            if (isTitleBarButtonFound == YES)
            {
                rightRect = barButtonItemView.frame;
                break;
            }
            else if ([barButtonItemView isMemberOfClass:[UIView class]])
            {
                isTitleBarButtonFound = YES;
            }
            else if ([barButtonItemView isKindOfClass:[UIControl class]])
            {
                leftRect = barButtonItemView.frame;
            }
        }
        CGFloat x = 16;
        if (CGRectIsNull(leftRect) == false)
        {
            x = CGRectGetMaxX(leftRect) + 16;
        }
        CGFloat width = CGRectGetWidth(self.frame) - 32 - (CGRectIsNull(leftRect)?0:CGRectGetMaxX(leftRect)) - (CGRectIsNull(rightRect)?0:CGRectGetWidth(self.frame)-CGRectGetMinX(rightRect));
        for (UIBarButtonItem *item in self.items)
        {
            if ([item isKindOfClass:[IQTitleBarButtonItem class]])
            {
                CGRect titleRect = CGRectMake(x, 0, width, self.frame.size.height);
                item.customView.frame = titleRect;
                break;
            }
        }
    }
}
#pragma mark - UIInputViewAudioFeedback delegate
- (BOOL) enableInputClicksWhenVisible
{
	return YES;
}
@end
