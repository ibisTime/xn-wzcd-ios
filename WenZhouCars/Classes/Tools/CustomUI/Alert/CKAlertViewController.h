#import <UIKit/UIKit.h>
@interface CKAlertAction : NSObject
@property (nonatomic, readonly) NSString *title;
+ (instancetype)actionWithTitle:(NSString *)title handler:(void (^)(CKAlertAction *action))handler;
@end
@interface CKAlertViewController : UIViewController
@property (nonatomic, readonly) NSArray<CKAlertAction *> *actions;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, assign) NSTextAlignment messageAlignment;
+ (instancetype)alertControllerWithTitle:(NSString *)title message:(NSString *)message;
- (void)addAction:(CKAlertAction *)action;
@end
