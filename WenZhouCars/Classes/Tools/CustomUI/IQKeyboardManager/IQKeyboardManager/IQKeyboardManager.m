#import "IQKeyboardManager.h"
#import "IQUIView+Hierarchy.h"
#import "IQUIView+IQKeyboardToolbar.h"
#import "IQUIWindow+Hierarchy.h"
#import "IQNSArray+Sort.h"
#import "IQKeyboardManagerConstantsInternal.h"
#import "IQUIScrollView+Additions.h"
#import "IQUITextFieldView+Additions.h"
#import "IQUIViewController+Additions.h"
#import "IQPreviousNextView.h"
#import <QuartzCore/CABase.h>
#import <objc/runtime.h>
#import <UIKit/UINavigationBar.h>
#import <UIKit/UITapGestureRecognizer.h>
#import <UIKit/UITextField.h>
#import <UIKit/UITextView.h>
#import <UIKit/UITableViewController.h>
#import <UIKit/UICollectionViewController.h>
#import <UIKit/UINavigationController.h>
#import <UIKit/UITouch.h>
#import <UIKit/NSLayoutConstraint.h>
NSInteger const kIQDoneButtonToolbarTag             =   -1002;
NSInteger const kIQPreviousNextButtonToolbarTag     =   -1005;
@interface IQKeyboardManager()<UIGestureRecognizerDelegate>
@property(nonatomic, assign) UIEdgeInsets     startingTextViewContentInsets;
@property(nonatomic, assign) UIEdgeInsets   startingTextViewScrollIndicatorInsets;
@property(nonatomic, assign) BOOL    isTextViewContentInsetChanged;
@property(nonatomic, weak) UIView       *textFieldView;
@property(nonatomic, assign) CGRect     topViewBeginRect;
@property(nonatomic, weak) UIViewController *rootViewController;
@property(nonatomic, assign) CGFloat    layoutGuideConstraintInitialConstant;
@property(nonatomic, weak) NSLayoutConstraint   *layoutGuideConstraint;
@property(nonatomic, weak) UIScrollView     *lastScrollView;
@property(nonatomic, assign) UIEdgeInsets   startingContentInsets;
@property(nonatomic, assign) UIEdgeInsets   startingScrollIndicatorInsets;
@property(nonatomic, assign) CGPoint        startingContentOffset;
@property(nonatomic, assign) CGFloat    animationDuration;
@property(nonatomic, assign) NSInteger  animationCurve;
@property(nonatomic, strong, nonnull, readwrite) NSMutableSet<Class> *registeredClasses;
@property(nonatomic, strong, nonnull, readwrite) NSMutableSet<Class> *disabledDistanceHandlingClasses;
@property(nonatomic, strong, nonnull, readwrite) NSMutableSet<Class> *enabledDistanceHandlingClasses;
@property(nonatomic, strong, nonnull, readwrite) NSMutableSet<Class> *disabledToolbarClasses;
@property(nonatomic, strong, nonnull, readwrite) NSMutableSet<Class> *enabledToolbarClasses;
@property(nonatomic, strong, nonnull, readwrite) NSMutableSet<Class> *toolbarPreviousNextAllowedClasses;
@property(nonatomic, strong, nonnull, readwrite) NSMutableSet<Class> *disabledTouchResignedClasses;
@property(nonatomic, strong, nonnull, readwrite) NSMutableSet<Class> *enabledTouchResignedClasses;
@property(nonatomic, strong, nonnull, readwrite) NSMutableSet<Class> *touchResignedGestureIgnoreClasses;
@end
@implementation IQKeyboardManager
{
	@package
    NSNotification          *_kbShowNotification;
    CGSize                   _kbSize;
    CGRect                   _statusBarFrame;
}
@synthesize enable                              =   _enable;
@synthesize keyboardDistanceFromTextField       =   _keyboardDistanceFromTextField;
@synthesize preventShowingBottomBlankSpace      =   _preventShowingBottomBlankSpace;
@synthesize overrideKeyboardAppearance          =   _overrideKeyboardAppearance;
@synthesize keyboardAppearance                  =   _keyboardAppearance;
@synthesize enableAutoToolbar                   =   _enableAutoToolbar;
@synthesize toolbarManageBehaviour              =   _toolbarManageBehaviour;
@synthesize shouldToolbarUsesTextFieldTintColor =   _shouldToolbarUsesTextFieldTintColor;
@synthesize toolbarTintColor                    =   _toolbarTintColor;
@synthesize toolbarBarTintColor                 =   _toolbarBarTintColor;
@dynamic shouldShowTextFieldPlaceholder;
@synthesize shouldShowToolbarPlaceholder        =   _shouldShowToolbarPlaceholder;
@synthesize placeholderFont                     =   _placeholderFont;
@synthesize shouldResignOnTouchOutside          =   _shouldResignOnTouchOutside;
@synthesize resignFirstResponderGesture         =   _resignFirstResponderGesture;
@synthesize shouldPlayInputClicks               =   _shouldPlayInputClicks;
@synthesize layoutIfNeededOnUpdate              =   _layoutIfNeededOnUpdate;
#pragma mark - Initializing functions
+(void)load
{
    [self performSelectorOnMainThread:@selector(sharedManager) withObject:nil waitUntilDone:NO];
}
-(instancetype)init
{
	if (self = [super init])
    {
        __weak typeof(self) weakSelf = self;
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            __strong typeof(self) strongSelf = weakSelf;
            strongSelf.registeredClasses = [[NSMutableSet alloc] init];
            [strongSelf registerAllNotifications];
            _resignFirstResponderGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapRecognized:)];
            strongSelf.resignFirstResponderGesture.cancelsTouchesInView = NO;
            [strongSelf.resignFirstResponderGesture setDelegate:self];
            strongSelf.resignFirstResponderGesture.enabled = strongSelf.shouldResignOnTouchOutside;
            strongSelf.animationDuration = 0.25;
            strongSelf.animationCurve = UIViewAnimationCurveEaseInOut;
            [self setEnable:YES];
			[self setKeyboardDistanceFromTextField:10.0];
            [self setShouldPlayInputClicks:YES];
            [self setShouldResignOnTouchOutside:NO];
            [self setOverrideKeyboardAppearance:NO];
            [self setKeyboardAppearance:UIKeyboardAppearanceDefault];
            [self setEnableAutoToolbar:YES];
            [self setPreventShowingBottomBlankSpace:YES];
            [self setShouldShowToolbarPlaceholder:YES];
            [self setToolbarManageBehaviour:IQAutoToolbarBySubviews];
            [self setLayoutIfNeededOnUpdate:NO];
            [self setShouldFixInteractivePopGestureRecognizer:YES];
            {
                UITextField *view = [[UITextField alloc] init];
                [view addDoneOnKeyboardWithTarget:nil action:nil];
                [view addPreviousNextDoneOnKeyboardWithTarget:nil previousAction:nil nextAction:nil doneAction:nil];
            }
            strongSelf.disabledDistanceHandlingClasses = [[NSMutableSet alloc] initWithObjects:[UITableViewController class],[UIAlertController class], nil];
            strongSelf.enabledDistanceHandlingClasses = [[NSMutableSet alloc] init];
            strongSelf.disabledToolbarClasses = [[NSMutableSet alloc] initWithObjects:[UIAlertController class], nil];
            strongSelf.enabledToolbarClasses = [[NSMutableSet alloc] init];
            strongSelf.toolbarPreviousNextAllowedClasses = [[NSMutableSet alloc] initWithObjects:[UITableView class],[UICollectionView class],[IQPreviousNextView class], nil];
            strongSelf.disabledTouchResignedClasses = [[NSMutableSet alloc] initWithObjects:[UIAlertController class], nil];
            strongSelf.enabledTouchResignedClasses = [[NSMutableSet alloc] init];
            strongSelf.touchResignedGestureIgnoreClasses = [[NSMutableSet alloc] initWithObjects:[UIControl class],[UINavigationBar class], nil];
            [self setShouldToolbarUsesTextFieldTintColor:NO];
        });
    }
    return self;
}
+ (IQKeyboardManager*)sharedManager
{
	static IQKeyboardManager *kbManager;
	static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        kbManager = [[self alloc] init];
    });
	return kbManager;
}
#pragma mark - Dealloc
-(void)dealloc
{
	[self setEnable:NO];
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark - Property functions
-(void)setEnable:(BOOL)enable
{
    if (enable == YES &&
        _enable == NO)
    {
		_enable = enable;
		if (_kbShowNotification)	[self keyboardWillShow:_kbShowNotification];
        [self showLog:@"Enabled"];
    }
    else if (enable == NO &&
             _enable == YES)
    {
		[self keyboardWillHide:nil];
		_enable = enable;
        [self showLog:@"Disabled"];
    }
	else if (enable == NO &&
             _enable == NO)
	{
        [self showLog:@"Already Disabled"];
	}
	else if (enable == YES &&
             _enable == YES)
	{
        [self showLog:@"Already Enabled"];
	}
}
-(BOOL)privateIsEnabled
{
    BOOL enable = _enable;
    UIViewController *textFieldViewController = [_textFieldView viewController];
    if (textFieldViewController)
    {
        if (enable == NO)
        {
            for (Class enabledClass in _enabledDistanceHandlingClasses)
            {
                if ([textFieldViewController isKindOfClass:enabledClass])
                {
                    enable = YES;
                    break;
                }
            }
        }
        if (enable)
        {
            for (Class disabledClass in _disabledDistanceHandlingClasses)
            {
                if ([textFieldViewController isKindOfClass:disabledClass])
                {
                    enable = NO;
                    break;
                }
            }
            if (enable == YES)
            {
                NSString *classNameString = NSStringFromClass([textFieldViewController class]);
                if ([classNameString containsString:@"UIAlertController"] && [classNameString hasSuffix:@"TextFieldViewController"])
                {
                    enable = NO;
                }
            }
        }
    }
    return enable;
}
-(BOOL)shouldShowTextFieldPlaceholder
{
    return _shouldShowToolbarPlaceholder;
}
-(void)setShouldShowTextFieldPlaceholder:(BOOL)shouldShowTextFieldPlaceholder
{
    _shouldShowToolbarPlaceholder = shouldShowTextFieldPlaceholder;
}
-(void)setKeyboardDistanceFromTextField:(CGFloat)keyboardDistanceFromTextField
{
	_keyboardDistanceFromTextField = MAX(keyboardDistanceFromTextField, 0);
    [self showLog:[NSString stringWithFormat:@"keyboardDistanceFromTextField: %.2f",_keyboardDistanceFromTextField]];
}
-(void)setShouldResignOnTouchOutside:(BOOL)shouldResignOnTouchOutside
{
    [self showLog:[NSString stringWithFormat:@"shouldResignOnTouchOutside: %@",shouldResignOnTouchOutside?@"Yes":@"No"]];
    _shouldResignOnTouchOutside = shouldResignOnTouchOutside;
    [_resignFirstResponderGesture setEnabled:[self privateShouldResignOnTouchOutside]];
}
-(BOOL)privateShouldResignOnTouchOutside
{
    BOOL shouldResignOnTouchOutside = _shouldResignOnTouchOutside;
    UIViewController *textFieldViewController = [_textFieldView viewController];
    if (textFieldViewController)
    {
        if (shouldResignOnTouchOutside == NO)
        {
            for (Class enabledClass in _enabledTouchResignedClasses)
            {
                if ([textFieldViewController isKindOfClass:enabledClass])
                {
                    shouldResignOnTouchOutside = YES;
                    break;
                }
            }
        }
        if (shouldResignOnTouchOutside)
        {
            for (Class disabledClass in _disabledTouchResignedClasses)
            {
                if ([textFieldViewController isKindOfClass:disabledClass])
                {
                    shouldResignOnTouchOutside = NO;
                    break;
                }
            }
            if (shouldResignOnTouchOutside == YES)
            {
                NSString *classNameString = NSStringFromClass([textFieldViewController class]);
                if ([classNameString containsString:@"UIAlertController"] && [classNameString hasSuffix:@"TextFieldViewController"])
                {
                    shouldResignOnTouchOutside = NO;
                }
            }
        }
    }
    return shouldResignOnTouchOutside;
}
-(void)setEnableAutoToolbar:(BOOL)enableAutoToolbar
{
    _enableAutoToolbar = enableAutoToolbar;
    [self showLog:[NSString stringWithFormat:@"enableAutoToolbar: %@",enableAutoToolbar?@"Yes":@"No"]];
    if ([self privateIsEnableAutoToolbar] == YES)
    {
        [self addToolbarIfRequired];
    }
    else
    {
        [self removeToolbarIfRequired];
    }
}
-(BOOL)privateIsEnableAutoToolbar
{
    BOOL enableAutoToolbar = _enableAutoToolbar;
    UIViewController *textFieldViewController = [_textFieldView viewController];
    if (textFieldViewController)
    {
        if (enableAutoToolbar == NO)
        {
            for (Class enabledToolbarClass in _enabledToolbarClasses)
            {
                if ([textFieldViewController isKindOfClass:enabledToolbarClass])
                {
                    enableAutoToolbar = YES;
                    break;
                }
            }
        }
        if (enableAutoToolbar)
        {
            for (Class disabledToolbarClass in _disabledToolbarClasses)
            {
                if ([textFieldViewController isKindOfClass:disabledToolbarClass])
                {
                    enableAutoToolbar = NO;
                    break;
                }
            }
            if (enableAutoToolbar == YES)
            {
                NSString *classNameString = NSStringFromClass([textFieldViewController class]);
                if ([classNameString containsString:@"UIAlertController"] && [classNameString hasSuffix:@"TextFieldViewController"])
                {
                    enableAutoToolbar = NO;
                }
            }
        }
    }
    return enableAutoToolbar;
}
#pragma mark - Private Methods
-(UIWindow *)keyWindow
{
    if (_textFieldView.window)
    {
        return _textFieldView.window;
    }
    else
    {
        static UIWindow *_keyWindow = nil;
        UIWindow *originalKeyWindow = [[UIApplication sharedApplication] keyWindow];
        if (originalKeyWindow != nil &&
            _keyWindow != originalKeyWindow)
        {
            _keyWindow = originalKeyWindow;
        }
        return _keyWindow;
    }
}
-(void)setRootViewFrame:(CGRect)frame
{
    UIViewController *controller = [_textFieldView topMostController];
    if (controller == nil)  controller = [[self keyWindow] topMostWindowController];
    frame.size = controller.view.frame.size;
    if (controller == nil)
        [self showLog:@"You must set UIWindow.rootViewController in your AppDelegate to work with IQKeyboardManager"];
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:_animationDuration delay:0 options:(_animationCurve|UIViewAnimationOptionBeginFromCurrentState) animations:^{
        __strong typeof(self) strongSelf = weakSelf;
        [controller.view setFrame:frame];
        if (strongSelf.layoutIfNeededOnUpdate)
        {
            [controller.view setNeedsLayout];
            [controller.view layoutIfNeeded];
        }
        [self showLog:[NSString stringWithFormat:@"Set %@ frame to : %@",[controller _IQDescription],NSStringFromCGRect(frame)]];
    } completion:NULL];
}
-(void)adjustFrame
{
    if (_textFieldView == nil)   return;
    CFTimeInterval startTime = CACurrentMediaTime();
    [self showLog:[NSString stringWithFormat:@"****** %@ started ******",NSStringFromSelector(_cmd)]];
    UIWindow *keyWindow = [self keyWindow];
    UIViewController *rootController = [_textFieldView topMostController];
    if (rootController == nil)  rootController = [keyWindow topMostWindowController];
    CGRect textFieldViewRect = [[_textFieldView superview] convertRect:_textFieldView.frame toView:keyWindow];
    CGRect rootViewRect = [[rootController view] frame];
    CGFloat specialKeyboardDistanceFromTextField = _textFieldView.keyboardDistanceFromTextField;
    if (_textFieldView.isSearchBarTextField)
    {
        UISearchBar *searchBar = (UISearchBar*)[_textFieldView superviewOfClassType:[UISearchBar class]];
        specialKeyboardDistanceFromTextField = searchBar.keyboardDistanceFromTextField;
    }
    CGFloat keyboardDistanceFromTextField = (specialKeyboardDistanceFromTextField == kIQUseDefaultKeyboardDistance)?_keyboardDistanceFromTextField:specialKeyboardDistanceFromTextField;
    CGSize kbSize = _kbSize;
    kbSize.height += keyboardDistanceFromTextField;
    CGRect statusBarFrame = [[UIApplication sharedApplication] statusBarFrame];
    IQLayoutGuidePosition layoutGuidePosition = IQLayoutGuidePositionNone;
    if (_layoutGuideConstraint && (_layoutGuideConstraint.firstItem == [[_textFieldView viewController] topLayoutGuide] ||
        _layoutGuideConstraint.secondItem == [[_textFieldView viewController] topLayoutGuide]))
    {
        layoutGuidePosition = IQLayoutGuidePositionTop;
    }
    else if (_layoutGuideConstraint && (_layoutGuideConstraint.firstItem == [[_textFieldView viewController] bottomLayoutGuide] ||
             _layoutGuideConstraint.secondItem == [[_textFieldView viewController] bottomLayoutGuide]))
    {
        layoutGuidePosition = IQLayoutGuidePositionBottom;
    }
    CGFloat topLayoutGuide = CGRectGetHeight(statusBarFrame);
    CGFloat move = 0;
    if (layoutGuidePosition == IQLayoutGuidePositionBottom)
    {
        move = CGRectGetMaxY(textFieldViewRect)-(CGRectGetHeight(keyWindow.frame)-kbSize.height);
    }
    else
    {
        move = MIN(CGRectGetMinY(textFieldViewRect)-(topLayoutGuide+5), CGRectGetMaxY(textFieldViewRect)-(CGRectGetHeight(keyWindow.frame)-kbSize.height));
    }
    [self showLog:[NSString stringWithFormat:@"Need to move: %.2f",move]];
    UIScrollView *superScrollView = nil;
    UIScrollView *superView = (UIScrollView*)[_textFieldView superviewOfClassType:[UIScrollView class]];
    while (superView)
    {
        if (superView.isScrollEnabled && superView.shouldIgnoreScrollingAdjustment == NO)
        {
            superScrollView = superView;
            break;
        }
        else
        {
            superView = (UIScrollView*)[superView superviewOfClassType:[UIScrollView class]];
        }
    }
    if (_lastScrollView)
    {
        if (superScrollView == nil)
        {
            [self showLog:[NSString stringWithFormat:@"Restoring %@ contentInset to : %@ and contentOffset to : %@",[_lastScrollView _IQDescription],NSStringFromUIEdgeInsets(_startingContentInsets),NSStringFromCGPoint(_startingContentOffset)]];
            __weak typeof(self) weakSelf = self;
            [UIView animateWithDuration:_animationDuration delay:0 options:(_animationCurve|UIViewAnimationOptionBeginFromCurrentState) animations:^{
                __strong typeof(self) strongSelf = weakSelf;
                [strongSelf.lastScrollView setContentInset:strongSelf.startingContentInsets];
                strongSelf.lastScrollView.scrollIndicatorInsets = strongSelf.startingScrollIndicatorInsets;
            } completion:NULL];
            if (_lastScrollView.shouldRestoreScrollViewContentOffset)
            {
                [_lastScrollView setContentOffset:_startingContentOffset animated:YES];
            }
            _startingContentInsets = UIEdgeInsetsZero;
            _startingScrollIndicatorInsets = UIEdgeInsetsZero;
            _startingContentOffset = CGPointZero;
            _lastScrollView = nil;
        }
        else if (superScrollView != _lastScrollView)
        {
            [self showLog:[NSString stringWithFormat:@"Restoring %@ contentInset to : %@ and contentOffset to : %@",[_lastScrollView _IQDescription],NSStringFromUIEdgeInsets(_startingContentInsets),NSStringFromCGPoint(_startingContentOffset)]];
            __weak typeof(self) weakSelf = self;
            [UIView animateWithDuration:_animationDuration delay:0 options:(_animationCurve|UIViewAnimationOptionBeginFromCurrentState) animations:^{
                __strong typeof(self) strongSelf = weakSelf;
                [strongSelf.lastScrollView setContentInset:strongSelf.startingContentInsets];
                strongSelf.lastScrollView.scrollIndicatorInsets = strongSelf.startingScrollIndicatorInsets;
            } completion:NULL];
            if (_lastScrollView.shouldRestoreScrollViewContentOffset)
            {
                [_lastScrollView setContentOffset:_startingContentOffset animated:YES];
            }
            _lastScrollView = superScrollView;
            _startingContentInsets = superScrollView.contentInset;
            _startingScrollIndicatorInsets = superScrollView.scrollIndicatorInsets;
            _startingContentOffset = superScrollView.contentOffset;
            [self showLog:[NSString stringWithFormat:@"Saving New %@ contentInset: %@ and contentOffset : %@",[_lastScrollView _IQDescription],NSStringFromUIEdgeInsets(_startingContentInsets),NSStringFromCGPoint(_startingContentOffset)]];
        }
    }
    else if(superScrollView)
    {
        _lastScrollView = superScrollView;
        _startingContentInsets = superScrollView.contentInset;
        _startingContentOffset = superScrollView.contentOffset;
        _startingScrollIndicatorInsets = superScrollView.scrollIndicatorInsets;
        [self showLog:[NSString stringWithFormat:@"Saving %@ contentInset: %@ and contentOffset : %@",[_lastScrollView _IQDescription],NSStringFromUIEdgeInsets(_startingContentInsets),NSStringFromCGPoint(_startingContentOffset)]];
    }
    {
        if (_lastScrollView)
        {
            UIView *lastView = _textFieldView;
            UIScrollView *superScrollView = _lastScrollView;
            while (superScrollView &&
                   (move>0?(move > (-superScrollView.contentOffset.y-superScrollView.contentInset.top)):superScrollView.contentOffset.y>0) )
            {
                UIScrollView *nextScrollView = nil;
                UIScrollView *tempScrollView = (UIScrollView*)[superScrollView superviewOfClassType:[UIScrollView class]];
                while (tempScrollView)
                {
                    if (tempScrollView.isScrollEnabled && tempScrollView.shouldIgnoreScrollingAdjustment == NO)
                    {
                        nextScrollView = tempScrollView;
                        break;
                    }
                    else
                    {
                        tempScrollView = (UIScrollView*)[tempScrollView superviewOfClassType:[UIScrollView class]];
                    }
                }
                CGRect lastViewRect = [[lastView superview] convertRect:lastView.frame toView:superScrollView];
                CGFloat shouldOffsetY = superScrollView.contentOffset.y - MIN(superScrollView.contentOffset.y,-move);
                shouldOffsetY = MIN(shouldOffsetY, lastViewRect.origin.y);   
                if ([_textFieldView isKindOfClass:[UITextView class]] &&
                    nextScrollView == nil &&
                    (shouldOffsetY >= 0))
                {
                    CGFloat maintainTopLayout = 0;
                        maintainTopLayout = CGRectGetMaxY(_textFieldView.viewController.navigationController.navigationBar.frame);
                    maintainTopLayout+= 10; 
                    CGRect currentTextFieldViewRect = [[_textFieldView superview] convertRect:_textFieldView.frame toView:keyWindow];
                    CGFloat expectedFixDistance = CGRectGetMinY(currentTextFieldViewRect) - maintainTopLayout;
                    shouldOffsetY = MIN(shouldOffsetY, superScrollView.contentOffset.y + expectedFixDistance);
                    move = 0;
                }
                else
                {
                    move -= (shouldOffsetY-superScrollView.contentOffset.y);
                }
                [UIView animateWithDuration:_animationDuration delay:0 options:(_animationCurve|UIViewAnimationOptionBeginFromCurrentState) animations:^{
                    [self showLog:[NSString stringWithFormat:@"Adjusting %.2f to %@ ContentOffset",(superScrollView.contentOffset.y-shouldOffsetY),[superScrollView _IQDescription]]];
                    [self showLog:[NSString stringWithFormat:@"Remaining Move: %.2f",move]];
                    superScrollView.contentOffset = CGPointMake(superScrollView.contentOffset.x, shouldOffsetY);
                } completion:NULL];
                lastView = superScrollView;
                superScrollView = nextScrollView;
            }
            {
                CGRect lastScrollViewRect = [[_lastScrollView superview] convertRect:_lastScrollView.frame toView:keyWindow];
                CGFloat bottom = kbSize.height-keyboardDistanceFromTextField-(CGRectGetHeight(keyWindow.frame)-CGRectGetMaxY(lastScrollViewRect));
                UIEdgeInsets movedInsets = _lastScrollView.contentInset;
                movedInsets.bottom = MAX(_startingContentInsets.bottom, bottom);
                [self showLog:[NSString stringWithFormat:@"%@ old ContentInset : %@",[_lastScrollView _IQDescription], NSStringFromUIEdgeInsets(_lastScrollView.contentInset)]];
                __weak typeof(self) weakSelf = self;
                [UIView animateWithDuration:_animationDuration delay:0 options:(_animationCurve|UIViewAnimationOptionBeginFromCurrentState) animations:^{
                    __strong typeof(self) strongSelf = weakSelf;
                    strongSelf.lastScrollView.contentInset = movedInsets;
                    UIEdgeInsets newInset = strongSelf.lastScrollView.scrollIndicatorInsets;
                    newInset.bottom = movedInsets.bottom;
                    strongSelf.lastScrollView.scrollIndicatorInsets = newInset;
                } completion:NULL];
                [self showLog:[NSString stringWithFormat:@"%@ new ContentInset : %@",[_lastScrollView _IQDescription], NSStringFromUIEdgeInsets(_lastScrollView.contentInset)]];
            }
        }
    }
    if (layoutGuidePosition == IQLayoutGuidePositionTop)
    {
        CGFloat constant = MIN(_layoutGuideConstraintInitialConstant, _layoutGuideConstraint.constant-move);
        __weak typeof(self) weakSelf = self;
        [UIView animateWithDuration:_animationDuration delay:0 options:(_animationCurve|UIViewAnimationOptionBeginFromCurrentState) animations:^{
            __strong typeof(self) strongSelf = weakSelf;
            weakSelf.layoutGuideConstraint.constant = constant;
            [strongSelf.rootViewController.view setNeedsLayout];
            [strongSelf.rootViewController.view layoutIfNeeded];
        } completion:NULL];
    }
    else if (layoutGuidePosition == IQLayoutGuidePositionBottom)
    {
        CGFloat constant = MAX(_layoutGuideConstraintInitialConstant, _layoutGuideConstraint.constant+move);
        __weak typeof(self) weakSelf = self;
        [UIView animateWithDuration:_animationDuration delay:0 options:(_animationCurve|UIViewAnimationOptionBeginFromCurrentState) animations:^{
            __strong typeof(self) strongSelf = weakSelf;
            weakSelf.layoutGuideConstraint.constant = constant;
            [strongSelf.rootViewController.view setNeedsLayout];
            [strongSelf.rootViewController.view layoutIfNeeded];
        } completion:NULL];
    }
    else
    {
        if ([_textFieldView isKindOfClass:[UITextView class]])
        {
            UITextView *textView = (UITextView*)_textFieldView;
            CGFloat textViewHeight = MIN(CGRectGetHeight(_textFieldView.frame), (CGRectGetHeight(keyWindow.frame)-kbSize.height-(topLayoutGuide)));
            if (_textFieldView.frame.size.height-textView.contentInset.bottom>textViewHeight)
            {
                __weak typeof(self) weakSelf = self;
                [UIView animateWithDuration:_animationDuration delay:0 options:(_animationCurve|UIViewAnimationOptionBeginFromCurrentState) animations:^{
                    __strong typeof(self) strongSelf = weakSelf;
                    [self showLog:[NSString stringWithFormat:@"%@ Old UITextView.contentInset : %@",[strongSelf.textFieldView _IQDescription], NSStringFromUIEdgeInsets(textView.contentInset)]];
                    if (_isTextViewContentInsetChanged == NO)
                    {
                        _startingTextViewContentInsets = textView.contentInset;
                        _startingTextViewScrollIndicatorInsets = textView.scrollIndicatorInsets;
                    }
                    UIEdgeInsets newContentInset = textView.contentInset;
                    newContentInset.bottom = _textFieldView.frame.size.height-textViewHeight;
                    textView.contentInset = newContentInset;
                    textView.scrollIndicatorInsets = newContentInset;
                    strongSelf.isTextViewContentInsetChanged = YES;
                    [self showLog:[NSString stringWithFormat:@"%@ New UITextView.contentInset : %@",[strongSelf.textFieldView _IQDescription], NSStringFromUIEdgeInsets(textView.contentInset)]];
                } completion:NULL];
            }
        }
        if ([rootController modalPresentationStyle] == UIModalPresentationFormSheet ||
            [rootController modalPresentationStyle] == UIModalPresentationPageSheet)
        {
            [self showLog:[NSString stringWithFormat:@"Found Special case for Model Presentation Style: %ld",(long)(rootController.modalPresentationStyle)]];
            if (move>=0)
            {
                rootViewRect.origin.y -= move;
                if (_preventShowingBottomBlankSpace == YES)
                {
                    CGFloat minimumY = (CGRectGetHeight(keyWindow.frame)-rootViewRect.size.height-topLayoutGuide)/2-(kbSize.height-keyboardDistanceFromTextField);
                    rootViewRect.origin.y = MAX(rootViewRect.origin.y, minimumY);
                }
                [self showLog:@"Moving Upward"];
                [self setRootViewFrame:rootViewRect];
                _movedDistance = (_topViewBeginRect.origin.y-rootViewRect.origin.y);
            }
            else
            {
                CGFloat disturbDistance = CGRectGetMinY(rootViewRect)-CGRectGetMinY(_topViewBeginRect);
                if(disturbDistance<0)
                {
                    rootViewRect.origin.y -= MAX(move, disturbDistance);
                    [self showLog:@"Moving Downward"];
                    [self setRootViewFrame:rootViewRect];
                    _movedDistance = (_topViewBeginRect.origin.y-rootViewRect.origin.y);
                }
            }
        }
        else
        {
            if (move>=0)
            {
                rootViewRect.origin.y -= move;
                if (_preventShowingBottomBlankSpace == YES)
                {
                    rootViewRect.origin.y = MAX(rootViewRect.origin.y, MIN(0, -kbSize.height+keyboardDistanceFromTextField));
                }
                [self showLog:@"Moving Upward"];
                [self setRootViewFrame:rootViewRect];
                _movedDistance = (_topViewBeginRect.origin.y-rootViewRect.origin.y);
            }
            else
            {
                CGFloat disturbDistance = CGRectGetMinY(rootViewRect)-CGRectGetMinY(_topViewBeginRect);
                if(disturbDistance<0)
                {
                    rootViewRect.origin.y -= MAX(move, disturbDistance);
                    [self showLog:@"Moving Downward"];
                    [self setRootViewFrame:rootViewRect];
                    _movedDistance = (_topViewBeginRect.origin.y-rootViewRect.origin.y);
                }
            }
        }
    }
    CFTimeInterval elapsedTime = CACurrentMediaTime() - startTime;
    [self showLog:[NSString stringWithFormat:@"****** %@ ended: %g seconds ******",NSStringFromSelector(_cmd),elapsedTime]];
}
#pragma mark - Public Methods
- (void)reloadLayoutIfNeeded
{
    if ([self privateIsEnabled] == YES)
    {
        if (_textFieldView != nil &&
            _keyboardShowing == YES &&
            CGRectEqualToRect(_topViewBeginRect, CGRectZero) == false &&
            [_textFieldView isAlertViewTextField] == NO)
        {
            [self adjustFrame];
        }
    }
}
#pragma mark - UIKeyboad Notification methods
-(void)keyboardWillShow:(NSNotification*)aNotification
{
    _kbShowNotification = aNotification;
    _keyboardShowing = YES;
    NSInteger curve = [[aNotification userInfo][UIKeyboardAnimationCurveUserInfoKey] integerValue];
    _animationCurve = curve<<16;
    CGFloat duration = [[aNotification userInfo][UIKeyboardAnimationDurationUserInfoKey] floatValue];
    if (duration != 0.0)    _animationDuration = duration;
    CGSize oldKBSize = _kbSize;
    CGRect kbFrame = [[aNotification userInfo][UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGRect screenSize = [[UIScreen mainScreen] bounds];
    CGRect intersectRect = CGRectIntersection(kbFrame, screenSize);
    if (CGRectIsNull(intersectRect))
    {
        _kbSize = CGSizeMake(screenSize.size.width, 0);
    }
    else
    {
        _kbSize = intersectRect.size;
    }
	if ([self privateIsEnabled] == NO)	return;
    CFTimeInterval startTime = CACurrentMediaTime();
    [self showLog:[NSString stringWithFormat:@"****** %@ started ******",NSStringFromSelector(_cmd)]];
    if (_textFieldView != nil && CGRectEqualToRect(_topViewBeginRect, CGRectZero))    
    {
        _layoutGuideConstraint = [[_textFieldView viewController] IQLayoutGuideConstraint];
        _layoutGuideConstraintInitialConstant = [_layoutGuideConstraint constant];
        _rootViewController = [_textFieldView topMostController];
        if (_rootViewController == nil)  _rootViewController = [[self keyWindow] topMostWindowController];
        _topViewBeginRect = _rootViewController.view.frame;
        if (_shouldFixInteractivePopGestureRecognizer &&
            [_rootViewController isKindOfClass:[UINavigationController class]] &&
            [_rootViewController modalPresentationStyle] != UIModalPresentationFormSheet &&
            [_rootViewController modalPresentationStyle] != UIModalPresentationPageSheet)
        {
            _topViewBeginRect.origin = CGPointMake(0, [self keyWindow].frame.size.height-_rootViewController.view.frame.size.height);
        }
        [self showLog:[NSString stringWithFormat:@"Saving %@ beginning Frame: %@",[_rootViewController _IQDescription] ,NSStringFromCGRect(_topViewBeginRect)]];
    }
    if (!CGSizeEqualToSize(_kbSize, oldKBSize))
    {
        if (_keyboardShowing == YES &&
            _textFieldView != nil  &&
            [_textFieldView isAlertViewTextField] == NO)
        {
            [self adjustFrame];
        }
    }
    CFTimeInterval elapsedTime = CACurrentMediaTime() - startTime;
    [self showLog:[NSString stringWithFormat:@"****** %@ ended: %g seconds ******",NSStringFromSelector(_cmd),elapsedTime]];
}
- (void)keyboardDidShow:(NSNotification*)aNotification
{
    if ([self privateIsEnabled] == NO)	return;
    CFTimeInterval startTime = CACurrentMediaTime();
    [self showLog:[NSString stringWithFormat:@"****** %@ started ******",NSStringFromSelector(_cmd)]];
    UIViewController *controller = [_textFieldView topMostController];
    if (controller == nil)  controller = [[self keyWindow] topMostWindowController];
    if (_keyboardShowing == YES &&
        _textFieldView != nil &&
        (controller.modalPresentationStyle == UIModalPresentationFormSheet || controller.modalPresentationStyle == UIModalPresentationPageSheet) &&
        [_textFieldView isAlertViewTextField] == NO)
    {
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [self adjustFrame];
        }];
    }
    CFTimeInterval elapsedTime = CACurrentMediaTime() - startTime;
    [self showLog:[NSString stringWithFormat:@"****** %@ ended: %g seconds ******",NSStringFromSelector(_cmd),elapsedTime]];
}
- (void)keyboardWillHide:(NSNotification*)aNotification
{
    if (aNotification != nil)	_kbShowNotification = nil;
    _keyboardShowing = NO;
    CGFloat aDuration = [[aNotification userInfo][UIKeyboardAnimationDurationUserInfoKey] floatValue];
    if (aDuration!= 0.0f)
    {
        _animationDuration = aDuration;
    }
    if ([self privateIsEnabled] == NO)	return;
    CFTimeInterval startTime = CACurrentMediaTime();
    [self showLog:[NSString stringWithFormat:@"****** %@ started ******",NSStringFromSelector(_cmd)]];
    if (_lastScrollView)
    {
        __weak typeof(self) weakSelf = self;
        [UIView animateWithDuration:_animationDuration delay:0 options:(_animationCurve|UIViewAnimationOptionBeginFromCurrentState) animations:^{
            __strong typeof(self) strongSelf = weakSelf;
            strongSelf.lastScrollView.contentInset = strongSelf.startingContentInsets;
            strongSelf.lastScrollView.scrollIndicatorInsets = strongSelf.startingScrollIndicatorInsets;
            if (strongSelf.lastScrollView.shouldRestoreScrollViewContentOffset)
            {
                strongSelf.lastScrollView.contentOffset = strongSelf.startingContentOffset;
            }
            [self showLog:[NSString stringWithFormat:@"Restoring %@ contentInset to : %@ and contentOffset to : %@",[strongSelf.lastScrollView _IQDescription],NSStringFromUIEdgeInsets(strongSelf.startingContentInsets),NSStringFromCGPoint(strongSelf.startingContentOffset)]];
            UIScrollView *superscrollView = strongSelf.lastScrollView;
            do
            {
                CGSize contentSize = CGSizeMake(MAX(superscrollView.contentSize.width, CGRectGetWidth(superscrollView.frame)), MAX(superscrollView.contentSize.height, CGRectGetHeight(superscrollView.frame)));
                CGFloat minimumY = contentSize.height-CGRectGetHeight(superscrollView.frame);
                if (minimumY<superscrollView.contentOffset.y)
                {
                    superscrollView.contentOffset = CGPointMake(superscrollView.contentOffset.x, minimumY);
                    [self showLog:[NSString stringWithFormat:@"Restoring %@ contentOffset to : %@",[superscrollView _IQDescription],NSStringFromCGPoint(superscrollView.contentOffset)]];
                }
            } while ((superscrollView = (UIScrollView*)[superscrollView superviewOfClassType:[UIScrollView class]]));
        } completion:NULL];
    }
    if (!CGRectEqualToRect(_topViewBeginRect, CGRectZero) &&
        _rootViewController)
    {
        _topViewBeginRect.size = _rootViewController.view.frame.size;
        __weak typeof(self) weakSelf = self;
        [UIView animateWithDuration:_animationDuration delay:0 options:(_animationCurve|UIViewAnimationOptionBeginFromCurrentState) animations:^{
            __strong typeof(self) strongSelf = weakSelf;
            if (weakSelf.layoutGuideConstraint)
            {
                weakSelf.layoutGuideConstraint.constant = strongSelf.layoutGuideConstraintInitialConstant;
                [strongSelf.rootViewController.view setNeedsLayout];
                [strongSelf.rootViewController.view layoutIfNeeded];
            }
            else
            {
                [self showLog:[NSString stringWithFormat:@"Restoring %@ frame to : %@",[strongSelf.rootViewController _IQDescription],NSStringFromCGRect(strongSelf.topViewBeginRect)]];
                [strongSelf.rootViewController.view setFrame:strongSelf.topViewBeginRect];
                _movedDistance = 0;
                if (strongSelf.layoutIfNeededOnUpdate)
                {
                    [strongSelf.rootViewController.view setNeedsLayout];
                    [strongSelf.rootViewController.view layoutIfNeeded];
                }
            }
        } completion:NULL];
        _rootViewController = nil;
    }
    else if (_layoutGuideConstraint)
    {
        __weak typeof(self) weakSelf = self;
        [UIView animateWithDuration:_animationDuration delay:0 options:(_animationCurve|UIViewAnimationOptionBeginFromCurrentState) animations:^{
            __strong typeof(self) strongSelf = weakSelf;
            weakSelf.layoutGuideConstraint.constant = strongSelf.layoutGuideConstraintInitialConstant;
            [strongSelf.rootViewController.view setNeedsLayout];
            [strongSelf.rootViewController.view layoutIfNeeded];
        } completion:NULL];
    }
    _layoutGuideConstraint = nil;
    _layoutGuideConstraintInitialConstant = 0;
    _lastScrollView = nil;
    _kbSize = CGSizeZero;
    _startingContentInsets = UIEdgeInsetsZero;
    _startingScrollIndicatorInsets = UIEdgeInsetsZero;
    _startingContentOffset = CGPointZero;
    CFTimeInterval elapsedTime = CACurrentMediaTime() - startTime;
    [self showLog:[NSString stringWithFormat:@"****** %@ ended: %g seconds ******",NSStringFromSelector(_cmd),elapsedTime]];
}
- (void)keyboardDidHide:(NSNotification*)aNotification
{
    CFTimeInterval startTime = CACurrentMediaTime();
    [self showLog:[NSString stringWithFormat:@"****** %@ started ******",NSStringFromSelector(_cmd)]];
    _topViewBeginRect = CGRectZero;
    _kbSize = CGSizeZero;
    CFTimeInterval elapsedTime = CACurrentMediaTime() - startTime;
    [self showLog:[NSString stringWithFormat:@"****** %@ ended: %g seconds ******",NSStringFromSelector(_cmd),elapsedTime]];
}
#pragma mark - UITextFieldView Delegate methods
-(void)textFieldViewDidBeginEditing:(NSNotification*)notification
{
    CFTimeInterval startTime = CACurrentMediaTime();
    [self showLog:[NSString stringWithFormat:@"****** %@ started ******",NSStringFromSelector(_cmd)]];
    _textFieldView = notification.object;
    if (_overrideKeyboardAppearance == YES)
    {
        UITextField *textField = (UITextField*)_textFieldView;
        if ([textField respondsToSelector:@selector(keyboardAppearance)])
        {
            if (textField.keyboardAppearance != _keyboardAppearance)
            {
                textField.keyboardAppearance = _keyboardAppearance;
                [textField reloadInputViews];
            }
        }
    }
	if ([self privateIsEnableAutoToolbar])
    {
        if ([_textFieldView isKindOfClass:[UITextView class]] &&
            _textFieldView.inputAccessoryView == nil)
        {
            __weak typeof(self) weakSelf = self;
            [UIView animateWithDuration:0.00001 delay:0 options:(_animationCurve|UIViewAnimationOptionBeginFromCurrentState) animations:^{
                [self addToolbarIfRequired];
            } completion:^(BOOL finished) {
                __strong typeof(self) strongSelf = weakSelf;
                [strongSelf.textFieldView reloadInputViews];
            }];
        }
        else
        {
            [self addToolbarIfRequired];
        }
    }
    else
    {
        [self removeToolbarIfRequired];
    }
    [_resignFirstResponderGesture setEnabled:[self privateShouldResignOnTouchOutside]];
    [_textFieldView.window addGestureRecognizer:_resignFirstResponderGesture];
	if ([self privateIsEnabled] == YES)
    {
        if (CGRectEqualToRect(_topViewBeginRect, CGRectZero))    
        {
            _layoutGuideConstraint = [[_textFieldView viewController] IQLayoutGuideConstraint];
            _layoutGuideConstraintInitialConstant = [_layoutGuideConstraint constant];
            _rootViewController = [_textFieldView topMostController];
            if (_rootViewController == nil)  _rootViewController = [[self keyWindow] topMostWindowController];
            _topViewBeginRect = _rootViewController.view.frame;
            if (_shouldFixInteractivePopGestureRecognizer &&
                [_rootViewController isKindOfClass:[UINavigationController class]] &&
                [_rootViewController modalPresentationStyle] != UIModalPresentationFormSheet &&
                [_rootViewController modalPresentationStyle] != UIModalPresentationPageSheet)
            {
                _topViewBeginRect.origin = CGPointMake(0, [self keyWindow].frame.size.height-_rootViewController.view.frame.size.height);
            }
            [self showLog:[NSString stringWithFormat:@"Saving %@ beginning Frame: %@",[_rootViewController _IQDescription], NSStringFromCGRect(_topViewBeginRect)]];
        }
        if (_keyboardShowing == YES &&
            _textFieldView != nil  &&
            [_textFieldView isAlertViewTextField] == NO)
        {
            [self adjustFrame];
        }
    }
    CFTimeInterval elapsedTime = CACurrentMediaTime() - startTime;
    [self showLog:[NSString stringWithFormat:@"****** %@ ended: %g seconds ******",NSStringFromSelector(_cmd),elapsedTime]];
}
-(void)textFieldViewDidEndEditing:(NSNotification*)notification
{
    CFTimeInterval startTime = CACurrentMediaTime();
    [self showLog:[NSString stringWithFormat:@"****** %@ started ******",NSStringFromSelector(_cmd)]];
    [_textFieldView.window removeGestureRecognizer:_resignFirstResponderGesture];
    if(_isTextViewContentInsetChanged == YES &&
       [_textFieldView isKindOfClass:[UITextView class]])
    {
        UITextView *textView = (UITextView*)_textFieldView;
        __weak typeof(self) weakSelf = self;
        [UIView animateWithDuration:_animationDuration delay:0 options:(_animationCurve|UIViewAnimationOptionBeginFromCurrentState) animations:^{
            __strong typeof(self) strongSelf = weakSelf;
            strongSelf.isTextViewContentInsetChanged = NO;
            [self showLog:[NSString stringWithFormat:@"Restoring %@ textView.contentInset to : %@",[strongSelf.textFieldView _IQDescription],NSStringFromUIEdgeInsets(strongSelf.startingTextViewContentInsets)]];
            textView.contentInset = strongSelf.startingTextViewContentInsets;
            textView.scrollIndicatorInsets = strongSelf.startingTextViewScrollIndicatorInsets;
        } completion:NULL];
    }
    _textFieldView = nil;
    CFTimeInterval elapsedTime = CACurrentMediaTime() - startTime;
    [self showLog:[NSString stringWithFormat:@"****** %@ ended: %g seconds ******",NSStringFromSelector(_cmd),elapsedTime]];
}
#pragma mark - UIStatusBar Notification methods
- (void)willChangeStatusBarOrientation:(NSNotification*)aNotification
{
    CFTimeInterval startTime = CACurrentMediaTime();
    [self showLog:[NSString stringWithFormat:@"****** %@ started ******",NSStringFromSelector(_cmd)]];
    if (_isTextViewContentInsetChanged == YES &&
        [_textFieldView isKindOfClass:[UITextView class]])
    {
        UITextView *textView = (UITextView*)_textFieldView;
        __weak typeof(self) weakSelf = self;
        [UIView animateWithDuration:_animationDuration delay:0 options:(_animationCurve|UIViewAnimationOptionBeginFromCurrentState) animations:^{
            __strong typeof(self) strongSelf = weakSelf;
            strongSelf.isTextViewContentInsetChanged = NO;
            [self showLog:[NSString stringWithFormat:@"Restoring %@ textView.contentInset to : %@",[strongSelf.textFieldView _IQDescription],NSStringFromUIEdgeInsets(strongSelf.startingTextViewContentInsets)]];
            textView.contentInset = strongSelf.startingTextViewContentInsets;
            textView.scrollIndicatorInsets = strongSelf.startingTextViewScrollIndicatorInsets;
        } completion:NULL];
    }
    CFTimeInterval elapsedTime = CACurrentMediaTime() - startTime;
    [self showLog:[NSString stringWithFormat:@"****** %@ ended: %g seconds ******",NSStringFromSelector(_cmd),elapsedTime]];
}
- (void)didChangeStatusBarFrame:(NSNotification*)aNotification
{
    CGRect oldStatusBarFrame = _statusBarFrame;
    _statusBarFrame = [[aNotification userInfo][UIApplicationStatusBarFrameUserInfoKey] CGRectValue];
    if ([self privateIsEnabled] == NO)	return;
    CFTimeInterval startTime = CACurrentMediaTime();
    [self showLog:[NSString stringWithFormat:@"****** %@ started ******",NSStringFromSelector(_cmd)]];
    if (_rootViewController &&
        !CGRectEqualToRect(_topViewBeginRect, _rootViewController.view.frame))
    {
        _topViewBeginRect = _rootViewController.view.frame;
        if (_shouldFixInteractivePopGestureRecognizer &&
            [_rootViewController isKindOfClass:[UINavigationController class]] &&
            [_rootViewController modalPresentationStyle] != UIModalPresentationFormSheet &&
            [_rootViewController modalPresentationStyle] != UIModalPresentationPageSheet)
        {
            _topViewBeginRect.origin = CGPointMake(0, [self keyWindow].frame.size.height-_rootViewController.view.frame.size.height);
        }
        [self showLog:[NSString stringWithFormat:@"Saving %@ beginning Frame: %@",[_rootViewController _IQDescription] ,NSStringFromCGRect(_topViewBeginRect)]];
    }
    if (_keyboardShowing == YES &&
        _textFieldView != nil  &&
        CGSizeEqualToSize(_statusBarFrame.size, oldStatusBarFrame.size) == NO &&
        [_textFieldView isAlertViewTextField] == NO)
    {
        [self adjustFrame];
    }
    CFTimeInterval elapsedTime = CACurrentMediaTime() - startTime;
    [self showLog:[NSString stringWithFormat:@"****** %@ ended: %g seconds ******",NSStringFromSelector(_cmd),elapsedTime]];
}
#pragma mark AutoResign methods
- (void)tapRecognized:(UITapGestureRecognizer*)gesture  
{
    if (gesture.state == UIGestureRecognizerStateEnded)
    {
        [self resignFirstResponder];
    }
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return NO;
}
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    for (Class aClass in self.touchResignedGestureIgnoreClasses)
    {
        if ([[touch view] isKindOfClass:aClass])
        {
            return NO;
        }
    }
    return YES;
}
- (BOOL)resignFirstResponder
{
    if (_textFieldView)
    {
        UIView *textFieldRetain = _textFieldView;
        BOOL isResignFirstResponder = [_textFieldView resignFirstResponder];
        if (isResignFirstResponder == NO)
        {
            [textFieldRetain becomeFirstResponder];
            [self showLog:[NSString stringWithFormat:@"Refuses to Resign first responder: %@",[_textFieldView _IQDescription]]];
        }
        return isResignFirstResponder;
    }
    else
    {
        return NO;
    }
}
-(BOOL)canGoPrevious
{
    NSArray *textFields = [self responderViews];
    NSUInteger index = [textFields indexOfObject:_textFieldView];
    if (index != NSNotFound &&
        index > 0)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}
-(BOOL)canGoNext
{
    NSArray *textFields = [self responderViews];
    NSUInteger index = [textFields indexOfObject:_textFieldView];
    if (index != NSNotFound &&
        index < textFields.count-1)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}
-(BOOL)goPrevious
{
    NSArray *textFields = [self responderViews];
    NSUInteger index = [textFields indexOfObject:_textFieldView];
    if (index != NSNotFound &&
        index > 0)
    {
        UITextField *nextTextField = textFields[index-1];
        UIView *textFieldRetain = _textFieldView;
        BOOL isAcceptAsFirstResponder = [nextTextField becomeFirstResponder];
        if (isAcceptAsFirstResponder == NO)
        {
            [textFieldRetain becomeFirstResponder];
            [self showLog:[NSString stringWithFormat:@"Refuses to become first responder: %@",[nextTextField _IQDescription]]];
        }
        return isAcceptAsFirstResponder;
    }
    else
    {
        return NO;
    }
}
-(BOOL)goNext
{
    NSArray *textFields = [self responderViews];
    NSUInteger index = [textFields indexOfObject:_textFieldView];
    if (index != NSNotFound &&
        index < textFields.count-1)
    {
        UITextField *nextTextField = textFields[index+1];
        UIView *textFieldRetain = _textFieldView;
        BOOL isAcceptAsFirstResponder = [nextTextField becomeFirstResponder];
        if (isAcceptAsFirstResponder == NO)
        {
            [textFieldRetain becomeFirstResponder];
            [self showLog:[NSString stringWithFormat:@"Refuses to become first responder: %@",[nextTextField _IQDescription]]];
        }
        return isAcceptAsFirstResponder;
    }
    else
    {
        return NO;
    }
}
#pragma mark AutoToolbar methods
-(NSArray*)responderViews
{
    UIView *superConsideredView;
    for (Class consideredClass in _toolbarPreviousNextAllowedClasses)
    {
        superConsideredView = [_textFieldView superviewOfClassType:consideredClass];
        if (superConsideredView != nil)
            break;
    }
    if (superConsideredView)
    {
        return [superConsideredView deepResponderViews];
    }
    else
    {
        NSArray *textFields = [_textFieldView responderSiblings];
        switch (_toolbarManageBehaviour)
        {
            case IQAutoToolbarBySubviews:
                return textFields;
                break;
            case IQAutoToolbarByTag:
                return [textFields sortedArrayByTag];
                break;
            case IQAutoToolbarByPosition:
                return [textFields sortedArrayByPosition];
                break;
            default:
                return nil;
                break;
        }
    }
}
-(void)addToolbarIfRequired
{
    CFTimeInterval startTime = CACurrentMediaTime();
    [self showLog:[NSString stringWithFormat:@"****** %@ started ******",NSStringFromSelector(_cmd)]];
    NSArray *siblings = [self responderViews];
    [self showLog:[NSString stringWithFormat:@"Found %lu responder sibling(s)",(unsigned long)siblings.count]];
    if ([_textFieldView respondsToSelector:@selector(setInputAccessoryView:)])
    {
        if ([_textFieldView inputAccessoryView] == nil ||
            [[_textFieldView inputAccessoryView] tag] == kIQPreviousNextButtonToolbarTag ||
            [[_textFieldView inputAccessoryView] tag] == kIQDoneButtonToolbarTag)
        {
            UITextField *textField = (UITextField*)_textFieldView;
            if ((siblings.count==1 && self.previousNextDisplayMode == IQPreviousNextDisplayModeDefault) || self.previousNextDisplayMode == IQPreviousNextDisplayModeAlwaysHide)
            {
                if (_toolbarDoneBarButtonItemImage)
                {
                    [textField addRightButtonOnKeyboardWithImage:_toolbarDoneBarButtonItemImage target:self action:@selector(doneAction:) shouldShowPlaceholder:_shouldShowToolbarPlaceholder];
                }
                else if (_toolbarDoneBarButtonItemText)
                {
                    [textField addRightButtonOnKeyboardWithText:_toolbarDoneBarButtonItemText target:self action:@selector(doneAction:) shouldShowPlaceholder:_shouldShowToolbarPlaceholder];
                }
                else
                {
                    [textField addDoneOnKeyboardWithTarget:self action:@selector(doneAction:) shouldShowPlaceholder:_shouldShowToolbarPlaceholder];
                }
                textField.inputAccessoryView.tag = kIQDoneButtonToolbarTag; 
            }
            else if ((siblings.count && self.previousNextDisplayMode == IQPreviousNextDisplayModeDefault) || self.previousNextDisplayMode == IQPreviousNextDisplayModeAlwaysShow)
            {
                if (_toolbarDoneBarButtonItemImage)
                {
                    [textField addPreviousNextRightOnKeyboardWithTarget:self rightButtonImage:_toolbarDoneBarButtonItemImage previousAction:@selector(previousAction:) nextAction:@selector(nextAction:) rightButtonAction:@selector(doneAction:) shouldShowPlaceholder:_shouldShowToolbarPlaceholder];
                }
                else if (_toolbarDoneBarButtonItemText)
                {
                    [textField addPreviousNextRightOnKeyboardWithTarget:self rightButtonTitle:_toolbarDoneBarButtonItemText previousAction:@selector(previousAction:) nextAction:@selector(nextAction:) rightButtonAction:@selector(doneAction:) shouldShowPlaceholder:_shouldShowToolbarPlaceholder];
                }
                else
                {
                    [textField addPreviousNextDoneOnKeyboardWithTarget:self previousAction:@selector(previousAction:) nextAction:@selector(nextAction:) doneAction:@selector(doneAction:) shouldShowPlaceholder:_shouldShowToolbarPlaceholder];
                }
                textField.inputAccessoryView.tag = kIQPreviousNextButtonToolbarTag; 
            }
            IQToolbar *toolbar = textField.keyboardToolbar;
            if ([textField respondsToSelector:@selector(keyboardAppearance)])
            {
                switch ([textField keyboardAppearance])
                {
                    case UIKeyboardAppearanceAlert:
                    {
                        toolbar.barStyle = UIBarStyleBlack;
                        [toolbar setTintColor:[UIColor whiteColor]];
                        [toolbar setBarTintColor:nil];
                    }
                        break;
                    default:
                    {
                        toolbar.barStyle = UIBarStyleDefault;
                        toolbar.barTintColor = _toolbarBarTintColor?:nil;
                        if (_shouldToolbarUsesTextFieldTintColor)
                        {
                            toolbar.tintColor = [textField tintColor];
                        }
                        else if (_toolbarTintColor)
                        {
                            toolbar.tintColor = _toolbarTintColor;
                        }
                        else
                        {
                            toolbar.tintColor = [UIColor blackColor];
                        }
                    }
                        break;
                }
                if (_shouldShowToolbarPlaceholder &&
                    textField.shouldHideToolbarPlaceholder == NO)
                {
                    if (toolbar.titleBarButton.title == nil ||
                        [toolbar.titleBarButton.title isEqualToString:textField.drawingToolbarPlaceholder] == NO)
                    {
                        [toolbar.titleBarButton setTitle:textField.drawingToolbarPlaceholder];
                    }
                    if (_placeholderFont &&
                        [_placeholderFont isKindOfClass:[UIFont class]])
                    {
                        [toolbar.titleBarButton setTitleFont:_placeholderFont];
                    }
                }
                else
                {
                    toolbar.titleBarButton.title = nil;
                }
            }
            if (siblings.firstObject == textField)
            {
                if (siblings.count == 1)
                {
                    textField.keyboardToolbar.previousBarButton.enabled = NO;
                    textField.keyboardToolbar.nextBarButton.enabled = NO;
                }
                else
                {
                    textField.keyboardToolbar.previousBarButton.enabled = NO;
                    textField.keyboardToolbar.nextBarButton.enabled = YES;
                }
            }
            else if ([siblings lastObject] == textField)
            {
                textField.keyboardToolbar.previousBarButton.enabled = YES;
                textField.keyboardToolbar.nextBarButton.enabled = NO;
            }
            else
            {
                textField.keyboardToolbar.previousBarButton.enabled = YES;
                textField.keyboardToolbar.nextBarButton.enabled = YES;
            }
        }
    }
    CFTimeInterval elapsedTime = CACurrentMediaTime() - startTime;
    [self showLog:[NSString stringWithFormat:@"****** %@ ended: %g seconds ******",NSStringFromSelector(_cmd),elapsedTime]];
}
-(void)removeToolbarIfRequired  
{
    CFTimeInterval startTime = CACurrentMediaTime();
    [self showLog:[NSString stringWithFormat:@"****** %@ started ******",NSStringFromSelector(_cmd)]];
    NSArray *siblings = [self responderViews];
    [self showLog:[NSString stringWithFormat:@"Found %lu responder sibling(s)",(unsigned long)siblings.count]];
    for (UITextField *textField in siblings)
    {
        UIView *toolbar = [textField inputAccessoryView];
        if ([textField respondsToSelector:@selector(setInputAccessoryView:)] &&
            ([toolbar isKindOfClass:[IQToolbar class]] && (toolbar.tag == kIQDoneButtonToolbarTag || toolbar.tag == kIQPreviousNextButtonToolbarTag)))
        {
            textField.inputAccessoryView = nil;
            [textField reloadInputViews];
        }
    }
    CFTimeInterval elapsedTime = CACurrentMediaTime() - startTime;
    [self showLog:[NSString stringWithFormat:@"****** %@ ended: %g seconds ******",NSStringFromSelector(_cmd),elapsedTime]];
}
- (void)reloadInputViews
{
    if ([self privateIsEnableAutoToolbar] == YES)
    {
        [self addToolbarIfRequired];
    }
    else
    {
        [self removeToolbarIfRequired];
    }
}
#pragma mark previous/next/done functionality
-(void)previousAction:(IQBarButtonItem*)barButton
{
    if (_shouldPlayInputClicks)
    {
        [[UIDevice currentDevice] playInputClick];
    }
    if ([self canGoPrevious])
    {
        UIView *currentTextFieldView = _textFieldView;
        BOOL isAcceptAsFirstResponder = [self goPrevious];
        if (isAcceptAsFirstResponder == YES && barButton.invocation)
        {
            if (barButton.invocation.methodSignature.numberOfArguments > 2)
            {
                [barButton.invocation setArgument:&currentTextFieldView atIndex:2];
            }
            [barButton.invocation invoke];
        }
    }
}
-(void)nextAction:(IQBarButtonItem*)barButton
{
    if (_shouldPlayInputClicks)
    {
        [[UIDevice currentDevice] playInputClick];
    }
    if ([self canGoNext])
    {
        UIView *currentTextFieldView = _textFieldView;
        BOOL isAcceptAsFirstResponder = [self goNext];
        if (isAcceptAsFirstResponder == YES && barButton.invocation)
        {
            if (barButton.invocation.methodSignature.numberOfArguments > 2)
            {
                [barButton.invocation setArgument:&currentTextFieldView atIndex:2];
            }
            [barButton.invocation invoke];
        }
    }
}
-(void)doneAction:(IQBarButtonItem*)barButton
{
    if (_shouldPlayInputClicks)
    {
        [[UIDevice currentDevice] playInputClick];
    }
    UIView *currentTextFieldView = _textFieldView;
    BOOL isResignedFirstResponder = [self resignFirstResponder];
    if (isResignedFirstResponder == YES && barButton.invocation)
    {
        if (barButton.invocation.methodSignature.numberOfArguments > 2)
        {
            [barButton.invocation setArgument:&currentTextFieldView atIndex:2];
        }
        [barButton.invocation invoke];
    }
}
#pragma mark - Customised textField/textView support.
-(void)registerTextFieldViewClass:(nonnull Class)aClass
  didBeginEditingNotificationName:(nonnull NSString *)didBeginEditingNotificationName
    didEndEditingNotificationName:(nonnull NSString *)didEndEditingNotificationName
{
    [_registeredClasses addObject:aClass];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldViewDidBeginEditing:) name:didBeginEditingNotificationName object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldViewDidEndEditing:) name:didEndEditingNotificationName object:nil];
}
-(void)unregisterTextFieldViewClass:(nonnull Class)aClass
    didBeginEditingNotificationName:(nonnull NSString *)didBeginEditingNotificationName
      didEndEditingNotificationName:(nonnull NSString *)didEndEditingNotificationName
{
    [_registeredClasses removeObject:aClass];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:didBeginEditingNotificationName object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:didEndEditingNotificationName object:nil];
}
-(void)registerAllNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
    [self registerTextFieldViewClass:[UITextField class]
     didBeginEditingNotificationName:UITextFieldTextDidBeginEditingNotification
       didEndEditingNotificationName:UITextFieldTextDidEndEditingNotification];
    [self registerTextFieldViewClass:[UITextView class]
     didBeginEditingNotificationName:UITextViewTextDidBeginEditingNotification
       didEndEditingNotificationName:UITextViewTextDidEndEditingNotification];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willChangeStatusBarOrientation:) name:UIApplicationWillChangeStatusBarOrientationNotification object:[UIApplication sharedApplication]];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didChangeStatusBarFrame:) name:UIApplicationDidChangeStatusBarFrameNotification object:[UIApplication sharedApplication]];
}
-(void)unregisterAllNotifications
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidHideNotification object:nil];
    [self unregisterTextFieldViewClass:[UITextField class]
     didBeginEditingNotificationName:UITextFieldTextDidBeginEditingNotification
       didEndEditingNotificationName:UITextFieldTextDidEndEditingNotification];
    [self unregisterTextFieldViewClass:[UITextView class]
     didBeginEditingNotificationName:UITextViewTextDidBeginEditingNotification
       didEndEditingNotificationName:UITextViewTextDidEndEditingNotification];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillChangeStatusBarOrientationNotification object:[UIApplication sharedApplication]];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidChangeStatusBarFrameNotification object:[UIApplication sharedApplication]];
}
-(void)showLog:(NSString*)logString
{
    if (_enableDebugging)
    {
        NSLog(@"IQKeyboardManager: %@",logString);
    }
}
@end
