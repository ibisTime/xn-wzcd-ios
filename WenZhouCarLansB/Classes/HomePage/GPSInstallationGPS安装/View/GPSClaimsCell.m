//
//  GPSClaimsCell.m
//  CarLoans
//
//  Created by QinBao Zheng on 2018/7/30.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "GPSClaimsCell.h"

@implementation GPSClaimsCell

-(UILabel *)codeLabel
{
    if (!_codeLabel) {
        _codeLabel = [UILabel labelWithFrame:CGRectMake(15, 10, SCREEN_WIDTH/2 - 10, 40) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(12) textColor:GaryTextColor];
    }
    return _codeLabel;
}

-(UILabel *)stateLabel
{
    if (!_stateLabel) {
        _stateLabel = [UILabel labelWithFrame:CGRectMake(SCREEN_WIDTH/2, 10, SCREEN_WIDTH/2 - 10, 40) textAligment:(NSTextAlignmentRight) backgroundColor:kClearColor font:HGfont(12) textColor:GaryTextColor];
        _stateLabel.numberOfLines = 2;

    }
    return _stateLabel;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        UIView *lineView1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
        lineView1.backgroundColor = LineBackColor;
        [self addSubview:lineView1];

        [self addSubview:self.codeLabel];
        [self addSubview:self.stateLabel];


        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 50, SCREEN_WIDTH, 1)];
        lineView.backgroundColor = LineBackColor;
        [self addSubview:lineView];
        for (int i = 0; i < 3; i ++) {
            _nameLabel = [UILabel labelWithFrame:CGRectMake(15 , 70 + i % 3 * 35, 100, 15) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(14) textColor:GaryTextColor];
            //            _nameLabel.text = nameArray[i];
            _nameLabel.tag = 100000 + i;
            [self addSubview:_nameLabel];

            _InformationLabel = [UILabel labelWithFrame:CGRectMake(115 , 70 + i % 3 * 35, SCREEN_WIDTH - 130, 15) textAligment:(NSTextAlignmentRight) backgroundColor:kClearColor font:HGfont(14) textColor:TextColor];
            _InformationLabel.tag = 1000000 + i;
            [self addSubview:_InformationLabel];
        }

        UIView *lineView2 = [[UIView alloc]initWithFrame:CGRectMake(0, 174, SCREEN_WIDTH, 1)];
        lineView2.backgroundColor = LineBackColor;
        [self addSubview:lineView2];

        _button = [UIButton buttonWithTitle:@"安装回录" titleColor:MainColor backgroundColor:kClearColor titleFont:15];
        _button.frame = CGRectMake(SCREEN_WIDTH - 115 - 115, 185, 100, 30);
        kViewBorderRadius(_button, 5, 1, MainColor);
        [self addSubview:_button];
        _button.hidden = YES;

        _button1 = [UIButton buttonWithTitle:@"回收作废" titleColor:MainColor backgroundColor:kClearColor titleFont:15];
        _button1.frame = CGRectMake(SCREEN_WIDTH - 115, 185, 100, 30);
        kViewBorderRadius(_button1, 5, 1, MainColor);
        [self addSubview:_button1];
        _button1.hidden = YES;

    }
    return self;
}

-(void)setGpsclaimsModel:(GPSClaimsModel *)gpsclaimsModel
{
    _codeLabel.text = [NSString stringWithFormat:@"%@",gpsclaimsModel.applyUserName];
//0 待审核 1 审核通过,待发货 2 审核不通过 3 已发货,待收货 4 已收货
    if (gpsclaimsModel.status == 0) {
        _stateLabel.text = @"待审核";
    }else if (gpsclaimsModel.status == 1)
    {
        _stateLabel.text = @"审核通过,待发货";
    }
    else if (gpsclaimsModel.status == 2)
    {
        _stateLabel.text = @"审核不通过";
    }
    else if (gpsclaimsModel.status == 3)
    {
        _stateLabel.text = @"已发货,待收货";
    }else
    {
        _stateLabel.text = @"已收货";
    }

    NSArray *nameArray = @[
                           @"所属公司",
                           @"申领个数",
                           @"申领时间",
                           ];
    NSArray *InformationArray = @[
                                  [NSString stringWithFormat:@"%@",gpsclaimsModel.companyName],
                                  [NSString stringWithFormat:@"%.@",gpsclaimsModel.applyCount],
                                  [NSString stringWithFormat:@"%@",[gpsclaimsModel.applyDatetime convertToDetailDate]]];

    for (int i = 0; i < nameArray.count; i ++ ) {
        UILabel *nameLabel = [self viewWithTag:100000 + i];
        nameLabel.text = nameArray[i];
        UILabel *InformationLabel = [self viewWithTag:1000000 + i];
        InformationLabel.text = [BaseModel convertNull:InformationArray[i]];
    }
}


-(void)setGpsInstallationModel:(GPSInstallationModel *)gpsInstallationModel{
    _codeLabel.text = [NSString stringWithFormat:@"%@",gpsInstallationModel.code];
    _stateLabel.text = [[BaseModel user]note:gpsInstallationModel.curNodeCode];
    NSArray *nameArray = @[
                           @"客户姓名",
                           @"业务公司",
                           @"品牌型号",
                           ];
    NSArray *InformationArray = @[
                                  [NSString stringWithFormat:@"%@",gpsInstallationModel.customerName],
                                  [NSString stringWithFormat:@"%.@",gpsInstallationModel.companyName],
                                  [NSString stringWithFormat:@"%@%@",[BaseModel convertNull:gpsInstallationModel.carBrand],[BaseModel convertNull:gpsInstallationModel.carModel]]];

    for (int i = 0; i < nameArray.count; i ++ ) {
        UILabel *nameLabel = [self viewWithTag:100000 + i];
        nameLabel.text = nameArray[i];
        UILabel *InformationLabel = [self viewWithTag:1000000 + i];
        InformationLabel.text = [BaseModel convertNull:InformationArray[i]];
    }
}


@end
