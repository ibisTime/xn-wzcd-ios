#import "TLAlert.h"
@implementation TLAlert
+ (void)alertWithInfo:(NSString *)msg {
    [SVProgressHUD showInfoWithStatus:msg];
    [SVProgressHUD setMinimumDismissTimeInterval:1];
}
+ (void)alertWithError:(NSString *)msg {
    [SVProgressHUD showErrorWithStatus:msg];
    [SVProgressHUD setMinimumDismissTimeInterval:1];
}
+ (void)alertWithSucces:(NSString *)msg {
    [SVProgressHUD showSuccessWithStatus:msg];
    [SVProgressHUD setMinimumDismissTimeInterval:1];
}
#pragma mark- 基于系统的alertController
+ (void)alertWithMsg:(NSString * )message viewCtrl:(UIViewController *)vc {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    [action2 setValue:[UIColor blackColor] forKey:@"titleTextColor"];
    [alertController addAction:action2];
    [vc presentViewController:alertController animated:YES completion:nil];
}
+ (void)alertWithMsg:(NSString * )message
{
    [self alertWithTitle:nil message:message confirmAction:nil];
}
+ (void)alertWithTitle:(NSString *)title message:(NSString *)message
{
    [self alertWithTitle:title message:message confirmAction:nil];
}
+ (void)alertWithTitle:(NSString *)title message:(NSString *)message confirmAction:(void(^)())confirmAction;
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        if (confirmAction) {
            confirmAction();
        }
    }];
    [action2 setValue:[UIColor blackColor] forKey:@"titleTextColor"];
    [alertController addAction:action2];
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController ;
    if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tbc = (UITabBarController *)rootViewController;
        [tbc.selectedViewController  presentViewController:alertController animated:YES completion:nil];
    } else {
        [rootViewController presentViewController:alertController animated:YES completion:nil];
    }
}
+ (void)alertWithTitle:(NSString *)title message:(NSString *)message confirmMsg:(NSString *)confirmMsg confirmAction:(void(^)())confirmAction
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:confirmMsg style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        if (confirmAction) {
            confirmAction();
        }
    }];
    [action2 setValue:[UIColor blackColor] forKey:@"titleTextColor"];
    [alertController addAction:action2];
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController ;
    if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tbc = (UITabBarController *)rootViewController;
        [tbc.selectedViewController  presentViewController:alertController animated:YES completion:nil];
    } else {
        [rootViewController presentViewController:alertController animated:YES completion:nil];
    }
}
+ (UIAlertController *)alertWithTitle:(NSString *)title
                                  msg:(NSString *)msg
                           confirmMsg:(NSString *)confirmMsg
                            cancleMsg:(NSString *)cancleMsg
                               cancle:(void(^)(UIAlertAction *action))cancle
                              confirm:(void(^)(UIAlertAction *action))confirm {
    return  [self alertWithTitle:title msg:msg confirmMsg:confirmMsg cancleMsg:cancleMsg maker:nil cancle:cancle confirm:confirm];
}
+ (UIAlertController *)alertWithTitle:(NSString *)title
                                  msg:(NSString *)msg
                           confirmMsg:(NSString *)confirmMsg
                            cancleMsg:(NSString *)cancleMsg
                                maker:(UIViewController *)viewCtrl
                               cancle:(void(^)(UIAlertAction *action))cancle
                              confirm:(void(^)(UIAlertAction *action))confirm{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:cancleMsg style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if(cancle){
            cancle(action);
        }
    }];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:confirmMsg style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (confirm) {
            confirm(action);
        }
    }];
    [action2 setValue:[UIColor blackColor] forKey:@"titleTextColor"];
    [action1 setValue:[UIColor blackColor] forKey:@"titleTextColor"];
    [alertController addAction:action2];
    [alertController addAction:action1];
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    if (viewCtrl) {
        [viewCtrl presentViewController:alertController animated:YES completion:nil];
    } else if([rootViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tbc = (UITabBarController *)rootViewController;
        [tbc presentViewController:alertController animated:YES completion:nil];
    } else {
        [rootViewController presentViewController:alertController animated:YES completion:nil];
    }
    return alertController;
}
+ (UIAlertController *)alertWithTitle:(NSString *)title
                              Message:(NSString *)message
                           confirmMsg:(NSString *)confirmMsg
                            CancleMsg:(NSString *)cancleMsg
                               cancle:(void(^)(UIAlertAction *action))cancle
                              confirm:(void(^)(UIAlertAction *action))confirm
{
    return [self alertWithTitle:title msg:message confirmMsg:confirmMsg cancleMsg:cancleMsg cancle:cancle confirm:confirm];
}
+ (UIAlertController *)alertWithTitle:(NSString *)title
                                  msg:(NSString *)msg
                           confirmMsg:(NSString *)confirmMsg
                            cancleMsg:(NSString *)cancleMsg
                          placeHolder:(NSString *)placeHolder
                                maker:(UIViewController *)viewCtrl
                               cancle:(void(^)(UIAlertAction *action))cancle
                              confirm:(void(^)(UIAlertAction *action, UITextField *textField))confirm{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:cancleMsg style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if(cancle){
            cancle(action);
        }
    }];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:confirmMsg style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (confirm) {
            confirm(action, alertController.textFields.firstObject);
        }
    }];
    [action2 setValue:[UIColor blackColor] forKey:@"titleTextColor"];
    [action1 setValue:[UIColor blackColor] forKey:@"titleTextColor"];
    [alertController addAction:action2];
    [alertController addAction:action1];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = placeHolder;
        textField.secureTextEntry = YES;
    }];
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    if (viewCtrl) {
        [viewCtrl presentViewController:alertController animated:YES completion:nil];
    } else if([rootViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tbc = (UITabBarController *)rootViewController;
        [tbc presentViewController:alertController animated:YES completion:nil];
    } else {
        [rootViewController presentViewController:alertController animated:YES completion:nil];
    }
    return alertController;
}
@end
