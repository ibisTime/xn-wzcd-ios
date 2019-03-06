#import <UIKit/UIKit.h>
@protocol CarSettledUpdataPhotoDelegate <NSObject>
-(void)CarSettledUpdataPhotoBtn:(UIButton *)sender selectStr:(NSString *)Str;
@end
@interface CarSettledUpdataPhotoCell : UITableViewCell
@property (nonatomic , copy)NSString *selectStr;
@property (nonatomic , copy)NSString *photoStr;
@property (nonatomic , copy)NSString *photoimg;
@property (nonatomic, assign) id <CarSettledUpdataPhotoDelegate> IdCardDelegate;
@property (nonatomic , strong)UIButton *photoBtn;
@end
