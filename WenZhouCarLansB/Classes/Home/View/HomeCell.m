//
//  HomeCell.m
//  CarLoans
//
//  Created by QinBao Zheng on 2018/7/17.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "HomeCell.h"
#import "IconView.h"
@implementation HomeCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {


    }
    return self;
}


-(void)setSectionNum:(NSInteger)sectionNum
{
    if (sectionNum == 0)
    {
//        NSArray *imageArray = @[HGImage(@"咨信调查")];
        NSArray *nameArray = @[@"咨信调查",@"准入申请",@"财务垫资"];
        for (int i = 0; i < nameArray.count; i ++) {
            IconView *iconView = [[IconView alloc]initWithFrame:CGRectMake(i % 3 * SCREEN_WIDTH/3, i / 3 * (SCREEN_WIDTH/3), SCREEN_WIDTH/3, SCREEN_WIDTH/3 )];
            [iconView.backButton addTarget:self action:@selector(backButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
            iconView.backButton.tag = 100 + i;

            iconView.image = [UIImage imageNamed:nameArray[i]];
            iconView.nameStr = nameArray[i];
            //            iconView.numberStr = numberArray[i];
            iconView.numberLabel.tag = 5000 + i;
            [self addSubview:iconView];
        }
    }
    else if (sectionNum == 1)
    {
        NSArray *nameArray = @[@"制卡",@"发保合",@"发票不匹配",@"客户作废",@"GPS申领",@"GPS安装",@"历史客户",@"月供计算器"];
        for (int i = 0; i < nameArray.count; i ++) {
            IconView *iconView = [[IconView alloc]initWithFrame:CGRectMake(i % 3 * SCREEN_WIDTH/3, i / 3 * (SCREEN_WIDTH/3), SCREEN_WIDTH/3, SCREEN_WIDTH/3 )];
            [iconView.backButton addTarget:self action:@selector(backButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
            iconView.backButton.tag = 1000 + i;

            iconView.image = [UIImage imageNamed:nameArray[i]];
            iconView.nameStr = nameArray[i];
            //            iconView.numberStr = numberArray[i];
            [self addSubview:iconView];
        }

    }
    else if (sectionNum == 2)
    {

        NSArray *nameArray = @[@"资料传递",@"扫码收件"];
        for (int i = 0; i < nameArray.count; i ++) {
            IconView *iconView = [[IconView alloc]initWithFrame:CGRectMake(i % 3 * SCREEN_WIDTH/3, i / 3 * (SCREEN_WIDTH/3), SCREEN_WIDTH/3, SCREEN_WIDTH/3 )];
            [iconView.backButton addTarget:self action:@selector(backButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
            iconView.backButton.tag = 10000 + i;

            iconView.image = [UIImage imageNamed:nameArray[i]];
            iconView.nameStr = nameArray[i];
            //            iconView.numberStr = numberArray[i];
            iconView.numberLabel.tag = 5005;
            [self addSubview:iconView];
        }
    }else if (sectionNum == 100)
    {
        NSArray *nameArray = @[@"咨信调查",@"准入申请",@"银行放款"];
        for (int i = 0; i < nameArray.count; i ++) {
            IconView *iconView = [[IconView alloc]initWithFrame:CGRectMake(i % 3 * SCREEN_WIDTH/3, i / 3 * (SCREEN_WIDTH/3), SCREEN_WIDTH/3, SCREEN_WIDTH/3 )];
            [iconView.backButton addTarget:self action:@selector(backButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
            iconView.backButton.tag = 100 + i;
            iconView.numberLabel.tag = 5000 + i;

            if (i == 2) {
                iconView.numberLabel.tag = 5000 + i + 10;
            }
            if (i == 4) {
                iconView.numberLabel.tag = 5000 + i + 10;
            }

            iconView.image = [UIImage imageNamed:nameArray[i]];
            iconView.nameStr = nameArray[i];
//            iconView.numberStr = numberArray[i];
            [self addSubview:iconView];
        }
    }else if (sectionNum == 101)
    {
        NSArray *nameArray = @[@"解除抵押",@"月供计算器"];
        for (int i = 0; i < nameArray.count; i ++) {
            IconView *iconView = [[IconView alloc]initWithFrame:CGRectMake(i % 3 * SCREEN_WIDTH/3, i / 3 * (SCREEN_WIDTH/3), SCREEN_WIDTH/3, SCREEN_WIDTH/3 )];
            [iconView.backButton addTarget:self action:@selector(backButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
            iconView.backButton.tag = 1000 + i;
            iconView.numberLabel.tag = 5005;
            iconView.image = [UIImage imageNamed:nameArray[i]];
            iconView.nameStr = nameArray[i];
            [self addSubview:iconView];
        }
    }else if (sectionNum == 102)
    {
        NSArray *nameArray = @[@"资料传递"];
        for (int i = 0; i < nameArray.count; i ++) {
            IconView *iconView = [[IconView alloc]initWithFrame:CGRectMake(i % 3 * SCREEN_WIDTH/3, i / 3 * (SCREEN_WIDTH/3), SCREEN_WIDTH/3, SCREEN_WIDTH/3 )];
            [iconView.backButton addTarget:self action:@selector(backButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
            iconView.backButton.tag = 10000 + i;
            iconView.numberLabel.tag = 5005;
            iconView.image = [UIImage imageNamed:nameArray[i]];
            iconView.nameStr = nameArray[i];
            [self addSubview:iconView];
        }
    }
}



-(void)backButtonClick:(UIButton *)sender
{
    [_HomeDelegate HomeCell:sender.tag button:sender];
}

@end
