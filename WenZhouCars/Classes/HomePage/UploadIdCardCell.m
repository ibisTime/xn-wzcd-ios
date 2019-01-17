#import "UploadIdCardCell.h"
@implementation UploadIdCardCell
-(UILabel *)nameLbl
{
    if (!_nameLbl) {
        _nameLbl = [UILabel labelWithFrame:CGRectMake(15, 0, SCREEN_WIDTH - 30, 50) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(14) textColor:[UIColor blackColor]];
        _nameLbl.text = @"身份证";
    }
    return _nameLbl;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.nameLbl];
        NSArray *nameArray = @[@"身份证正面",@"身份证反面"];
        for (int i = 0; i < 2; i ++) {
            _photoBtn = [UIButton buttonWithTitle:nameArray[i] titleColor:GaryTextColor backgroundColor:BackColor titleFont:13];
            _photoBtn.frame = CGRectMake(15 + i % 2 * (SCREEN_WIDTH - 20)/2, 50, (SCREEN_WIDTH - 40)/2, SCREEN_WIDTH/3);
            kViewBorderRadius(_photoBtn, 5, 1, HGColor(230, 230, 230));
            [_photoBtn SG_imagePositionStyle:(SGImagePositionStyleTop) spacing:10 imagePositionBlock:^(UIButton *button) {
                [button setImage:[UIImage imageNamed:@"添加"] forState:(UIControlStateNormal)];
            }];
            [_photoBtn addTarget:self action:@selector(photoBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
            _photoBtn.tag = 50 + i;
            [self addSubview:_photoBtn];
            _photoImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, (SCREEN_WIDTH - 40)/2, SCREEN_WIDTH/3)];
            kViewBorderRadius(_photoImage, 5, 1, HGColor(230, 230, 230));
            [_photoBtn addSubview:_photoImage];
            _photoImage.tag = 500 + i;
            _photoImage.hidden = YES;
            UIButton *selectButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
            selectButton.frame = selectButton.frame = CGRectMake(15 + (SCREEN_WIDTH - 40)/2 - 30 + i % 2 * (SCREEN_WIDTH - 20)/2, 50, 30, 30);
            [selectButton setImage:HGImage(@"删除") forState:(UIControlStateNormal)];
            [selectButton addTarget:self action:@selector(selectButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
            selectButton.tag = 5000 + i;
            selectButton.hidden= YES;
            [self addSubview:selectButton];
        }
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 49 + SCREEN_WIDTH/3 + 20, SCREEN_WIDTH, 1)];
        lineView.backgroundColor = LineBackColor;
        [self addSubview:lineView];
    }
    return self;
}
-(void)setIdNoFront:(NSString *)idNoFront
{
    UIImageView *image = [self viewWithTag:500];
    UIButton *btn = [self viewWithTag:5000];
    if ([BaseModel isBlankString:idNoFront] == NO) {
        btn.hidden = NO;
        image.hidden = NO;
        [image sd_setImageWithURL:[NSURL URLWithString:[idNoFront convertImageUrl]]];
    }else
    {
        image.hidden = YES;
        btn.hidden = YES;
    }
}
-(void)setIdNoReverse:(NSString *)idNoReverse
{
    UIImageView *image = [self viewWithTag:501];
    UIButton *btn = [self viewWithTag:5001];
    if ([BaseModel isBlankString:idNoReverse] == NO) {
        btn.hidden = NO;
        image.hidden = NO;
        [image sd_setImageWithURL:[NSURL URLWithString:[idNoReverse convertImageUrl]]];
    }
    else
    {
        image.hidden = YES;
        btn.hidden = YES;
    }
}
-(void)photoBtnClick:(UIButton *)sender
{
    [_IdCardDelegate UploadIdCardBtn:sender];
}
-(void)selectButtonClick:(UIButton *)sender
{
    [_IdCardDelegate SelectButtonClick:sender];
}
@end
