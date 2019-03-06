#import "AddGPSListCell.h"
@implementation AddGPSListCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(15, 10, SCREEN_WIDTH - 30, 105)];
        backView.backgroundColor = BackColor;
        [self addSubview:backView];
        kViewBorderRadius(backView, 5, 1, HGColor(230, 230, 230));
        for ( int i = 0; i < 3; i ++) {
            UILabel *gpsLabel = [UILabel labelWithFrame:CGRectMake(10, 15 + i%3*30, SCREEN_WIDTH - 50, 15) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(13) textColor:GaryTextColor];
            gpsLabel.tag = 1000000 + i;
            [backView addSubview:gpsLabel];
        }
    }
    return self;
}
-(void)setDic:(NSDictionary *)dic
{
    NSLog(@"%@",dic);
    UILabel *label1 = [self viewWithTag:1000000];
    UILabel *label2 = [self viewWithTag:1000001];
    UILabel *label3 = [self viewWithTag:1000002];
    label1.text = [NSString stringWithFormat:@"设备号:  %@",dic[@"gpsDevNo"]];
    if ([dic[@"gpsType"] isEqualToString:@"1"]) {
        label2.text = @"类    型:  有线";
    }else
    {
        label2.text = @"类    型:  无线";
    }
    label3.text = [NSString stringWithFormat:@"位    置:  %@",[[BaseModel user] setParentKey:@"az_location" setDkey:dic[@"azLocation"]]];
}
@end
