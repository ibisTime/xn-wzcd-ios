//
//  GPSInformationListCell.m
//  CarLoans
//
//  Created by QinBao Zheng on 2018/8/31.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "GPSInformationListCell.h"

@implementation GPSInformationListCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSArray *nameArray = @[@"设备号:",
                               @"状    态:",
                               @"类    型:",
                               @"位    置:",
                               @"时    间:",
                               @"人    员"
                               ];
        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(15, 0, SCREEN_WIDTH - 30, 195)];
        backView.backgroundColor = BackColor;
        kViewBorderRadius(backView, 2, 1, HGColor(230, 230, 230));
        [self addSubview:backView];

        for (int j = 0; j < 6; j ++) {
            UILabel *nameLabel = [UILabel labelWithFrame:CGRectMake(15, 15 + j%6*30, 60, 15) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(13) textColor:GaryTextColor];
            nameLabel.text = nameArray[j];
            [backView addSubview:nameLabel];

            UILabel *informationLabel = [[UILabel alloc]initWithFrame:CGRectMake(75, 15+j%6*30, SCREEN_WIDTH - 120, 15) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(13) textColor:TextColor];

//            informationLabel.text = detailsArray[j];
            informationLabel.tag = 1000 + j;
            [backView addSubview:informationLabel];
        }

//        UIButton *deleteBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
//        deleteBtn.frame = CGRectMake(SCREEN_WIDTH - 45, 0, 30, 30);
//        _deleteBtn = deleteBtn;
//        [deleteBtn addTarget:self action:@selector(backButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
//        [deleteBtn setImage:HGImage(@"删除") forState:(UIControlStateNormal)];
        //        deleteBtn.backgroundColor = [UIColor redColor];
//        [self addSubview:deleteBtn];
    }
    return self;
}
-(void)setDic:(NSDictionary *)dic
{
    NSLog(@"%@",dic);
    NSString *gpsType;
    if ([dic[@"gpsType"] integerValue] == 1) {
        gpsType = @"使用中";
    }else
    {
        gpsType = @"未使用";
    }
    NSString *azLocation;
    if ([dic[@"state"] integerValue] == 1) {
        azLocation = @"有线";
    }else
    {
        azLocation = @"无线";
    }
    UILabel *label1 = [self viewWithTag:1000];
    UILabel *label2 = [self viewWithTag:1001];
    UILabel *label3 = [self viewWithTag:1002];
    UILabel *label4 = [self viewWithTag:1003];
    UILabel *label5 = [self viewWithTag:1004];
    UILabel *label6 = [self viewWithTag:1005];
    label1.text = [NSString stringWithFormat:@"%@",dic[@"gpsDevNo"]];
    label2.text = gpsType;
    label3.text = azLocation;
    label4.text = [NSString stringWithFormat:@"%@",[[BaseModel user]setParentKey:@"az_location" setDkey:dic[@"azLocation"]]];
    label5.text = [BaseModel convertNull:[dic[@"azDatetime"] convertDate]];
    label6.text = [BaseModel convertNull:dic[@"azUser"]];


}

@end
