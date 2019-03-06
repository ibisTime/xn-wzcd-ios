#import <UIKit/UIKit.h>
typedef enum {
    ShareTypeToQQFriend = 0,
    ShareTypeToQZone,
    ShareTypeToWechat,
    ShareTypeToWechatTimeline,
    ShareTypeToSina,
} ShareType;
@interface ShareButton : UIButton
@property (nonatomic , assign ) CGFloat range;
- (void)configTitle:(NSString *)title Image:(UIImage *)image;
@end
