#import "CarSettledUpdataPhotoCell.h"
@implementation CarSettledUpdataPhotoCell
{
    NSString *Str;
    UIImageView *_photoImg;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _photoBtn = [UIButton buttonWithTitle:@"" titleColor:GaryTextColor backgroundColor:BackColor titleFont:13];
        _photoBtn.frame = CGRectMake(15 , 0, (SCREEN_WIDTH - 40)/2, SCREEN_WIDTH/3);
        kViewBorderRadius(_photoBtn, 5, 1, HGColor(230, 230, 230));
        [_photoBtn addTarget:self action:@selector(photoBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:_photoBtn];
        UIImageView *photoImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, (SCREEN_WIDTH - 40)/2, SCREEN_WIDTH/3)];
        _photoImg = photoImg;
        [_photoBtn addSubview:photoImg];
    }
    return self;
}
-(void)setPhotoimg:(NSString *)photoimg
{
    if ([BaseModel isBlankString:photoimg] == NO) {
        [_photoImg sd_setImageWithURL:[NSURL URLWithString:[photoimg convertImageUrl]]];
    }
}
-(void)setSelectStr:(NSString *)selectStr
{
    Str = selectStr;
}
-(void)setPhotoStr:(NSString *)photoStr
{
    [_photoBtn setTitle:photoStr forState:(UIControlStateNormal)];
    [_photoBtn SG_imagePositionStyle:(SGImagePositionStyleTop) spacing:10 imagePositionBlock:^(UIButton *button) {
        [button setImage:[UIImage imageNamed:@"添加"] forState:(UIControlStateNormal)];
    }];
}
-(void)photoBtnClick:(UIButton *)sender
{
    [_IdCardDelegate CarSettledUpdataPhotoBtn:sender selectStr:Str];
}
@end
