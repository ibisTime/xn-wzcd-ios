#import <UIKit/UIKit.h>
@interface TextFieldCell : UITableViewCell
@property (nonatomic , copy)NSString *isInput;
@property (nonatomic , copy)NSString *name;
@property (nonatomic , copy)NSString *nameText;
@property (nonatomic , copy)NSString *TextFidStr;
@property (nonatomic , strong)UILabel *nameLabel;
@property (nonatomic , strong)UITextField *nameTextField;
@end
