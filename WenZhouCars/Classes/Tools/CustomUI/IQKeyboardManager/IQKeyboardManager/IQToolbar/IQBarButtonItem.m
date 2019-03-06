#import "IQBarButtonItem.h"
#import "IQKeyboardManagerConstantsInternal.h"
@implementation IQBarButtonItem
+(void)initialize
{
    [super initialize];
    IQBarButtonItem *appearanceProxy = [self appearance];
    NSArray <NSNumber*> *states = @[@(UIControlStateNormal),@(UIControlStateHighlighted),@(UIControlStateDisabled),@(UIControlStateSelected),@(UIControlStateApplication),@(UIControlStateReserved)];
    [appearanceProxy setTintColor:nil];
    for (NSNumber *state in states)
    {
        UIControlState controlState = [state unsignedIntegerValue];
        [appearanceProxy setTitleTextAttributes:nil forState:controlState];
        [appearanceProxy setBackgroundImage:nil forState:controlState barMetrics:UIBarMetricsDefault];
        [appearanceProxy setBackgroundImage:nil forState:controlState style:UIBarButtonItemStyleDone barMetrics:UIBarMetricsDefault];
        [appearanceProxy setBackgroundImage:nil forState:controlState style:UIBarButtonItemStylePlain barMetrics:UIBarMetricsDefault];
        [appearanceProxy setBackButtonBackgroundImage:nil forState:controlState barMetrics:UIBarMetricsDefault];
    }
    [appearanceProxy setTitlePositionAdjustment:UIOffsetZero forBarMetrics:UIBarMetricsDefault];
    [appearanceProxy setBackgroundVerticalPositionAdjustment:0 forBarMetrics:UIBarMetricsDefault];
    [appearanceProxy setBackButtonTitlePositionAdjustment:UIOffsetZero forBarMetrics:UIBarMetricsDefault];
    [appearanceProxy setBackButtonBackgroundVerticalPositionAdjustment:0 forBarMetrics:UIBarMetricsDefault];
}
- (instancetype)initWithBarButtonSystemItem:(UIBarButtonSystemItem)systemItem target:(nullable id)target action:(nullable SEL)action
{
    self = [super initWithBarButtonSystemItem:systemItem target:target action:action];
    if (self)
    {
        _isSystemItem = YES;
    }
    return self;
}
-(void)setTarget:(nullable id)target action:(nullable SEL)action
{
    NSInvocation *invocation = nil;
    if (target && action)
    {
        invocation = [NSInvocation invocationWithMethodSignature:[target methodSignatureForSelector:action]];
        invocation.target = target;
        invocation.selector = action;
    }
    self.invocation = invocation;
}
@end
