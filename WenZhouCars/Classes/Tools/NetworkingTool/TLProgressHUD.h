#import <SVProgressHUD/SVProgressHUD.h>
@interface TLProgressHUD : SVProgressHUD
+ (void)showWithStatus:(NSString *)msg;
+ (void)showInfoWithStatus:(NSString *)status;
+ (void)showSuccessWithStatus:(NSString *)status;
+ (void)showErrorWithStatus:(NSString *)status;
+ (void)dismiss;
+ (void)showErrorWithStatusAutoDismiss:(NSString *)msg;
+ (void)showWithStatusAutoDismiss:(NSString *)msg;
+ (void)showWithStatusAutoDismiss:(NSString *)msg delay:(NSInteger)delayTime;
+ (void)showWithStatusAutoDismiss:(NSString *)msg delay:(NSInteger)delayTime completion:(void(^)())completion;
@end
