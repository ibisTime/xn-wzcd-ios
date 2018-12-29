//
//  RepaymentPlanCell.m
//  CarLoans
//
//  Created by QinBao Zheng on 2018/8/31.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "RepaymentPlanCell.h"

@implementation RepaymentPlanCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(15, 10, SCREEN_WIDTH - 30, 110)];
        backView.backgroundColor = BackColor;
        kViewBorderRadius(backView, 2, 1, HGColor(230, 230, 230));
        [self addSubview:backView];


        for (int j = 0; j < 4; j ++) {
            UILabel *nameLabel = [UILabel labelWithFrame:CGRectMake(15, 15 + j%4*25, SCREEN_WIDTH - 60, 15) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(13) textColor:GaryTextColor];
//            nameLabel.text = nameArray[j];
            if (j == 0) {
                nameLabel.frame = CGRectMake(15, 10 + j%4*25, (SCREEN_WIDTH - 60)/2, 15);
            }
            nameLabel.tag = j + 100;
            [backView addSubview:nameLabel];
        }

        UILabel *nameLabel1 = [UILabel labelWithFrame:CGRectMake(15 + (SCREEN_WIDTH - 60)/2, 15 , (SCREEN_WIDTH - 60)/2, 15) textAligment:(NSTextAlignmentRight) backgroundColor:kClearColor font:HGfont(13) textColor:GaryTextColor];
        nameLabel1.text = @"应还本息";
        nameLabel1.tag = 104;
        [backView addSubview:nameLabel1];

    }
    return self;
}

-(void)setDic:(NSDictionary *)dic
{
//    NSArray *nameArray = @[@"当前期数",@"应还金额",@"逾期金额",@"剩余欠款"];
    UILabel *label1 = [self viewWithTag:100];
    UILabel *label2 = [self viewWithTag:101];
    UILabel *label3 = [self viewWithTag:102];
    UILabel *label4 = [self viewWithTag:103];
    UILabel *label5 = [self viewWithTag:104];
    label1.text = [NSString stringWithFormat:@"当前期数%ld",[dic[@"curPeriods"] integerValue]];
    label2.text = [NSString stringWithFormat:@"应还金额:  ¥%.2f",[dic[@"repayCapital"] floatValue]/1000];
    label3.text = [NSString stringWithFormat:@"逾期金额:  ¥%.2f",[dic[@"overdueAmount"] floatValue]/1000];
    label4.text = [NSString stringWithFormat:@"剩余欠款:  ¥%.2f",[dic[@"overplusAmount"] floatValue]/1000];
    label5.text = [NSString stringWithFormat:@"应还本息:  ¥%.2f",[dic[@"repayCapital"] floatValue]/1000];

}

@end
