#import <UIKit/UIKit.h>
@interface ChooseCell : UITableViewCell
@property (nonatomic , copy)NSString *name;
@property (nonatomic , strong)UILabel *nameLabel;
@property (nonatomic , strong)UILabel *detailsLabel;
@property (nonatomic , strong)UIImageView *xiaImage;
@property (nonatomic , copy)NSString *details;
@end
