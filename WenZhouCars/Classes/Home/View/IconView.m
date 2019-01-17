#import "IconView.h"
@implementation IconView
-(UIButton *)backButton
{
    if (!_backButton) {
        _backButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _backButton.frame = CGRectMake(0, 0, SCREEN_WIDTH/3, SCREEN_WIDTH/3);
    }
    return _backButton;
}
-(UIImageView *)iconImage
{
    if (!_iconImage) {
        _iconImage = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/3/2 - 20, SCREEN_WIDTH/3/2 - 35, 40, 40)];
    }
    return _iconImage;
}
-(UILabel *)numberLabel
{
    if (!_numberLabel) {
        _numberLabel = [UILabel labelWithFrame:CGRectMake(30, -3, 13, 13) textAligment:(NSTextAlignmentCenter) backgroundColor:[UIColor redColor] font:HGfont(10) textColor:[UIColor whiteColor]];
        kViewRadius(_numberLabel, 6.5);
        _numberLabel.hidden = YES;
    }
    return _numberLabel;
}
-(UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [UILabel labelWithFrame:CGRectMake(0, SCREEN_WIDTH/3/2 - 35 + 40 + 10, SCREEN_WIDTH/3, 20) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:HGfont(14) textColor:kTextColor3];
    }
    return _nameLabel;
}
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.backButton];
        [_backButton addSubview:self.iconImage];
        [_iconImage addSubview:self.numberLabel];
        [_backButton addSubview:self.nameLabel];
        kViewBorderRadius(_backButton, 0, 0.5, LineBackColor);
    }
    return self;
}
-(void)setImage:(UIImage *)image
{
    _iconImage.image = image;
}
-(void)setNameStr:(NSString *)nameStr
{
    _nameLabel.text = nameStr;
}
@end
