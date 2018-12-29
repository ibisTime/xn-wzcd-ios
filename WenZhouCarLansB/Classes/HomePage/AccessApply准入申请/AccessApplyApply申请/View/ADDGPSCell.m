//
//  ADDGPSCell.m
//  WenZhouCarLansB
//
//  Created by QinBao Zheng on 2018/9/10.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "ADDGPSCell.h"

@implementation ADDGPSCell

-(UIButton *)addGPSBtn
{
    if (!_addGPSBtn) {
        _addGPSBtn = [UIButton buttonWithTitle:@"" titleColor:GaryTextColor backgroundColor:BackColor titleFont:13];
        kViewBorderRadius(_addGPSBtn, 5, 1, HGColor(230, 230, 230));
        _addGPSBtn.frame = CGRectMake(15, 10, SCREEN_WIDTH - 30, 105);
        [_addGPSBtn setTitle:@"新增" forState:(UIControlStateNormal)];
        [_addGPSBtn SG_imagePositionStyle:(SGImagePositionStyleTop) spacing:10 imagePositionBlock:^(UIButton *button) {
            [button setImage:[UIImage imageNamed:@"添加"] forState:(UIControlStateNormal)];
        }];
    }
    return _addGPSBtn;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.addGPSBtn];

//        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(15, 10, SCREEN_WIDTH - 30, 85)];
//        [self addSubview:backView];
    }
    return self;
}

@end
