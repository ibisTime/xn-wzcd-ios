#import "HomeHeadView.h"
@implementation HomeHeadView
-(UIImageView *)headImage
{
    if (!_headImage) {
        _headImage = [[UIImageView alloc]initWithFrame:CGRectMake(15, 30, 70, 70)];
        _headImage.image = HGImage(@"默认头像");
    }
    return _headImage;
}
-(UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [UILabel labelWithFrame:CGRectMake(95, 40, SCREEN_WIDTH - 110, 30) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(18) textColor:[UIColor whiteColor]];
    }
    return _nameLabel;
}
-(UILabel *)introduceLabel
{
    if (!_introduceLabel) {
        _introduceLabel = [UILabel labelWithFrame:CGRectMake(95, 70, SCREEN_WIDTH - 110, 20) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(12) textColor:[UIColor whiteColor]];
        NSLog(@"%@",[USERDEFAULTS objectForKey:USERDATA]);
    }
    return _introduceLabel;
}
-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        UIImageView *backImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 130)];
        backImage.image = HGImage(@"背景");
        [self addSubview:backImage];
        [self addSubview:self.headImage];
        [self addSubview:self.nameLabel];
        [self addSubview:self.introduceLabel];
    }
    return self;
}
-(void)setDic:(NSDictionary *)dic
{
    NSString *remark;
    if ([BaseModel isBlankString:dic[@"postName"]] == YES) {
        remark = @"[其他]";
    }
    else
    {
        remark = [NSString stringWithFormat:@"[%@]",dic[@"postName"]];
    }
    NSString *needText = [NSString stringWithFormat:@"%@ %@",[BaseModel convertNull:dic[@"loginName"]],remark];
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:needText];
    [attrString addAttribute:NSFontAttributeName value:HGfont(11) range:NSMakeRange(needText.length - remark.length,remark.length)];
    _nameLabel.attributedText = attrString;
    _introduceLabel.text = [BaseModel convertNull:dic[@"companyName"]];
}
@end
