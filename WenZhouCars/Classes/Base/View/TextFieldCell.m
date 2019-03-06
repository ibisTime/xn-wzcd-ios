#import "TextFieldCell.h"
@implementation TextFieldCell
-(UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [UILabel labelWithFrame:CGRectMake(15, 0, 90, 50) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(14) textColor:[UIColor blackColor]];
    }
    return _nameLabel;
}
-(UITextField *)nameTextField
{
    if (!_nameTextField) {
        _nameTextField = [[UITextField alloc]initWithFrame:CGRectMake(105, 0, SCREEN_WIDTH - 120, 50)];
        _nameTextField.font = HGfont(14);
        _nameTextField.textAlignment = NSTextAlignmentRight;
        [_nameTextField setValue:HGfont(14) forKeyPath:@"_placeholderLabel.font"];
        _nameTextField.text = @"";
    }
    return _nameTextField;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.nameLabel];
        [self addSubview:self.nameTextField];
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 49, SCREEN_WIDTH, 1)];
        lineView.backgroundColor = LineBackColor;
        [self addSubview:lineView];
    }
    return self;
}
-(void)setName:(NSString *)name
{
    _nameLabel.text = name;
    _nameLabel.frame = CGRectMake(15, 18, 0, 14);
    [_nameLabel sizeToFit];
    _nameTextField.frame = CGRectMake(_nameLabel.frame.size.width + 25, 0, SCREEN_WIDTH - _nameLabel.frame.size.width - 40, 50);
}
-(void)setNameText:(NSString *)nameText
{
    _nameTextField.placeholder = nameText;
}
-(void)setIsInput:(NSString *)isInput
{
    if ([isInput isEqualToString:@"0"]) {
        _nameTextField.enabled = NO;
    }
}
-(void)setTextFidStr:(NSString *)TextFidStr
{
    _nameTextField.text = [BaseModel convertNull:TextFidStr];
}
@end
