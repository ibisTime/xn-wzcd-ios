#ifndef AppColorMacro_h
#define AppColorMacro_h
#import <UIKit/UIKit.h>
#import "UIColor+Extension.h"
#pragma mark - UIMacros
#define RGB(r, g, b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define kAppCustomMainColor [UIColor colorWithHexString:@"#f15353"]
#define kNavBarMainColor  [UIColor appNavBarMainColor]
#define kNavBarBgColor    [UIColor appNavBarBgColor]
#define kTabbarMainColor   [UIColor appTabbarMainColor]
#define kTabbarBgColor     [UIColor appTabbarBgColor]
#define RGB(r, g, b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define ButtonTextColor RGB(2, 142, 255)
#define TextColor RGB(51, 51, 51)
#define MainColor RGB(0, 145, 247)
#define GaryTextColor RGB(153, 153, 153)
#define LineBackColor RGB(247.0, 247.0, 247.0)
#define BackColor RGB(247.0, 247.0, 247.0)
#define PriceColor RGB(255.0, 133.0, 42.0)
#define kNavBarBackgroundColor  RGB(25, 25, 25)
#define MoneyColor        [UIColor colorWithHexString:@"#ff5000"]
#define kBackgroundColor  RGB(247.0, 247.0, 247.0)   
#define kLineColor              [UIColor colorWithHexString:@"#EEEEEE"]   
#define kTextColor              [UIColor colorWithHexString:@"#484848"]   
#define kTextColor2             [UIColor colorWithHexString:@"#999999"]   
#define kTextColor3             [UIColor colorWithHexString:@"#666666"]   
#define kTextColor4             [UIColor colorWithHexString:@"#b3b3b3"]   
#define kThemeColor             [UIColor colorWithHexString:@"#f15353"]  
#define kPaleBlueColor          [UIColor colorWithHexString:@"#48b0fb"]    
#define kRiseColor              [UIColor colorWithHexString:@"#2ac64c"]  
#define kAuxiliaryTipColor      [UIColor colorWithHexString:@"#FF254C"]   
#define kBottomItemGrayColor    [UIColor colorWithHexString:@"#FAFAFA"]   
#define kCommentSecondColor     [UIColor colorWithHexString:@"#FAFAFA"]   
#define kPlaceholderColor       [UIColor colorWithHexString:@"#CCCCCC"]
#define kLightGreyColor RGB(153, 153, 153)         
#define kOrangeRedColor RGB(255, 83, 27)           
#define kPaleGreyColor RGB(245, 245, 245)          
#define kDeepGreenColor RGB(65, 117, 5)            
#define kLightGreenColor RGB(200, 220, 81)         
#define kDarkGreenColor kButtonBackgroundColor     
#define kBrickRedColor RGB(240, 41, 0)             
#define kWhiteColor RGB(255, 255, 255)             
#define kBlackColor RGB(0, 0, 0)                   
#define kSilverGreyColor RGB(236, 236, 236)        
#define kShallowGreyColor RGB(206, 206, 206)       
#define kClearColor [UIColor clearColor]           
#define kWidth(x) (x)*(kScreenWidth)/375.0
#define kHeight(y) (y)*(kScreenHeight)/667.0
#define kDevice_Is_iPhoneX (SCREEN_HEIGHT == 812 ? YES : NO)
#define kNavigationBarHeight  (kDevice_Is_iPhoneX == YES ? 88: 64)
#define kStatusBarHeight (kDevice_Is_iPhoneX == YES ? 44: 20)
#define kTabBarHeight  (49 + kBottomInsetHeight)
#define kBottomInsetHeight  (kDevice_Is_iPhoneX == YES ? 34: 0)
#define kSuperViewHeight    kScreenHeight - kNavigationBarHeight
#define kLeftMargin 15
#define kLineHeight 0.5
#define kImage(I)       [UIImage imageNamed:I]
#define kFontHeight(F)  [Font(F) lineHeight]
#define Font(F)         [UIFont systemFontOfSize:(F)]
#define boldFont(F)     [UIFont boldSystemFontOfSize:(F)]
#pragma mark - Image
#define USER_PLACEHOLDER_SMALL  [UIImage imageNamed:@"头像"]
#define PLACEHOLDER_SMALL       @"icon"
#define kCancelIcon             @"cancel"
#define GOOD_PLACEHOLDER_SMALL  [UIImage imageNamed:@"产品占位图"]
#define kDateFormmatter @"MMM dd, yyyy hh:mm:ss aa"
#pragma mark - 轮播图
#define kCarouselHeight (kScreenWidth/5*3)
#define kViewBorderRadius(View,Radius,Width,Color)\
\
[View.layer setCornerRadius:(Radius)];\
\
[View.layer setMasksToBounds:YES];\
\
[View.layer setBorderWidth:(Width)];\
\
[View.layer setBorderColor:[Color CGColor]]
#define kViewRadius(View,Radius)\
\
[View.layer setCornerRadius:(Radius)];\
\
[View.layer setMasksToBounds:YES]
#endif 
