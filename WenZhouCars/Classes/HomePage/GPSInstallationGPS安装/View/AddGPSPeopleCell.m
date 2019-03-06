#import "AddGPSPeopleCell.h"
@implementation AddGPSPeopleCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier   ];
    if (self) {
        _addButton = [UIButton buttonWithTitle:@"" titleColor:[UIColor blackColor] backgroundColor:BackColor titleFont:13];
        _addButton.frame = CGRectMake(15, 0, SCREEN_WIDTH - 30, 135);
        [_addButton setTitleColor:GaryTextColor forState:(UIControlStateNormal)];
        kViewBorderRadius(_addButton, 5, 1, HGColor(230, 230, 230));
        [_addButton setTitle:@"添加GPS" forState:(UIControlStateNormal)];
        [_addButton SG_imagePositionStyle:(SGImagePositionStyleTop) spacing:10 imagePositionBlock:^(UIButton *button) {
            [button setImage:[UIImage imageNamed:@"添加"] forState:(UIControlStateNormal)];
        }];
        _addButton.enabled = YES;
        [self addSubview:self.addButton];
        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(15, 0, SCREEN_WIDTH - 30, 135)];
        [self addSubview:backView];
    }
    return self;
}
@end
