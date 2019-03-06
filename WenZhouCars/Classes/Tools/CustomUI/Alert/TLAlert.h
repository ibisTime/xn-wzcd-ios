#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class SVProgressHUD;
@interface TLAlert : NSObject
@property (nonatomic, assign) CGFloat infoSecond;     
@property (nonatomic, assign) CGFloat errorSecond;    
@property (nonatomic, assign) CGFloat successSecond;  
+ (void)alertWithInfo:(NSString *)msg;
+ (void)alertWithError:(NSString *)msg;
+ (void)alertWithSucces:(NSString *)msg;
+ (void)alertWithMsg:(NSString * )message;
+ (void)alertWithMsg:(NSString * )message viewCtrl:(UIViewController *)vc;
+ (void)alertWithTitle:(NSString *)title
               message:(NSString *)message;
+ (void)alertWithTitle:(NSString *)title
               message:(NSString *)message
         confirmAction:(void(^)())confirmAction;
+ (void)alertWithTitle:(NSString *)title message:(NSString *)message confirmMsg:(NSString *)confirmMsg confirmAction:(void(^)())confirmAction;
+ (UIAlertController *)alertWithTitle:(NSString *)title
                                  msg:(NSString *)msg
                           confirmMsg:(NSString *)confirmMsg
                            cancleMsg:(NSString *)cancleMsg
                                maker:(UIViewController *)viewCtrl
                               cancle:(void(^)(UIAlertAction *action))cancle
                              confirm:(void(^)(UIAlertAction *action))confirm;
+ (UIAlertController *)alertWithTitle:(NSString *)title
                                  msg:(NSString *)msg
                           confirmMsg:(NSString *)confirmMsg
                            cancleMsg:(NSString *)msg
                               cancle:(void(^)(UIAlertAction *action))cancle
                              confirm:(void(^)(UIAlertAction *action))confirm;
+ (UIAlertController *)alertWithTitle:(NSString *)title
                                  msg:(NSString *)msg
                           confirmMsg:(NSString *)confirmMsg
                            cancleMsg:(NSString *)msg
                          placeHolder:(NSString *)placeHolder
                                maker:(UIViewController *)viewCtrl
                               cancle:(void(^)(UIAlertAction *action))cancle
                              confirm:(void(^)(UIAlertAction *action, UITextField *textField))confirm;
@end
