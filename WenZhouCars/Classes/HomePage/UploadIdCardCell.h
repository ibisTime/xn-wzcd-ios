#import <UIKit/UIKit.h>
@protocol UploadIdCardDelegate <NSObject>
-(void)UploadIdCardBtn:(UIButton *)sender;
-(void)SelectButtonClick:(UIButton *)sender;
@end
@interface UploadIdCardCell : UITableViewCell
@property (nonatomic, assign) id <UploadIdCardDelegate> IdCardDelegate;
@property (nonatomic , copy)NSString *idNoFront;
@property (nonatomic , copy)NSString *idNoReverse;
@property (nonatomic , strong)UILabel *nameLbl;
@property (nonatomic , strong)UIButton *photoBtn;
@property (nonatomic , strong)UIImageView *photoImage;
@end
