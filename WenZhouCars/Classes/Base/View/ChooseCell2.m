#import "ChooseCell2.h"
@implementation ChooseCell2
-(UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [UILabel labelWithFrame:CGRectMake(15, 0, 100, 50)  textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(14) textColor:[UIColor blackColor]];
    }
    return _nameLabel;
}
-(UIImageView *)xiaImage
{
    if (!_xiaImage) {
        _xiaImage = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 15 - 10, 17.5, 8, 15)];
        _xiaImage.image = HGImage(@"you");
    }
    return _xiaImage;
}
-(UILabel *)detailsLabel
{
    if (!_detailsLabel) {
        _detailsLabel = [UILabel labelWithFrame:CGRectMake(115, 0, SCREEN_WIDTH - 155, 50) textAligment:(NSTextAlignmentRight) backgroundColor:kClearColor font:HGfont(14) textColor:[UIColor blackColor]];
    }
    return _detailsLabel;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.nameLabel];
        [self addSubview:self.detailsLabel];
        [self addSubview:self.xiaImage];
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 49, SCREEN_WIDTH, 1)];
        lineView.backgroundColor = LineBackColor;
        [self addSubview:lineView];
    }
    return self;
}
-(void)setName:(NSString *)name
{
    _nameLabel.frame = CGRectMake(15, 18, 0, 14);
    _nameLabel.text = name;
    [_nameLabel sizeToFit];
    _detailsLabel.frame = CGRectMake(_nameLabel.frame.size.width + _nameLabel.frame.origin.x + 10, 0, SCREEN_WIDTH - _nameLabel.frame.size.width - _nameLabel.frame.origin.x - 10 - 15 - 20, 50);
}
-(void)setDetails:(NSString *)details
{
    _detailsLabel.text = details;
}
@end
