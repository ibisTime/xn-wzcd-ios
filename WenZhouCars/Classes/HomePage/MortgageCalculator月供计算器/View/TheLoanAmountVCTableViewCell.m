#import "TheLoanAmountVCTableViewCell.h"
@implementation TheLoanAmountVCTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UITextField *_nameTextField = [[UITextField alloc]initWithFrame:CGRectMake(20, 0, SCREEN_WIDTH - 40, 50)];
        _nameTextField.font = HGfont(14);
        [_nameTextField setValue:HGfont(14) forKeyPath:@"_placeholderLabel.font"];
        _nameTextField.placeholder = @"*贷款金额";
        _nameTextField.tag = 300;
        [self addSubview:_nameTextField];
    }
    return self;
}
@end
