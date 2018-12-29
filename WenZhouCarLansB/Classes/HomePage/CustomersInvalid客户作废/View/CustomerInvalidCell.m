//
//  CustomerInvalidCell.m
//  CarLoans
//
//  Created by QinBao Zheng on 2018/8/1.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "CustomerInvalidCell.h"

@implementation CustomerInvalidCell

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


        _button = [UIButton buttonWithTitle:@"审核" titleColor:MainColor backgroundColor:kClearColor titleFont:15];
        _button.frame = CGRectMake(SCREEN_WIDTH - 115, 255, 100, 30);
        kViewBorderRadius(_button, 5, 1, MainColor);
        [self addSubview:_button];
        _button.hidden = YES;

        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 50, SCREEN_WIDTH, 1)];
        lineView.backgroundColor = LineBackColor;
        [self addSubview:lineView];




        for (int i = 0; i < 5; i ++) {
            _nameLabel = [UILabel labelWithFrame:CGRectMake(15 , 70 + i % 6 * 35, 100, 15) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(14) textColor:GaryTextColor];
            //            _nameLabel.text = nameArray[i];
            _nameLabel.tag = 100000 + i;
            [self addSubview:_nameLabel];

            _InformationLabel = [UILabel labelWithFrame:CGRectMake(115 , 70 + i % 6 * 35, SCREEN_WIDTH - 130, 15) textAligment:(NSTextAlignmentRight) backgroundColor:kClearColor font:HGfont(14) textColor:TextColor];
            _InformationLabel.tag = 1000000 + i;
            [self addSubview:_InformationLabel];
        }

        UIView *lineView2 = [[UIView alloc]initWithFrame:CGRectMake(0, 244, SCREEN_WIDTH, 1)];
        lineView2.backgroundColor = LineBackColor;
        [self addSubview:lineView2];

    }
    return self;
}

-(void)setModel:(CustomerInvalidModel *)model
{
    _codeLabel.text = [NSString stringWithFormat:@"%@",model.code];
    _stateLabel.text = [[BaseModel user]note:model.curNodeCode];

    NSLog(@"%@",[[BaseModel user]note:model.curNodeCode]);
    NSArray *nameArray = @[
                           @"购车途径",
                           @"客户姓名",
                           @"贷款金额",
                           @"贷款银行",
                           @"申请时间"];
    NSString *shopWay;
    if ([model.shopWay integerValue] == 1) {
        shopWay = @"新车";
    }
    else
    {
        shopWay = @"二手车";
    }

    NSArray *InformationArray = @[
                                  [NSString stringWithFormat:@"%@",shopWay],
                                  [NSString stringWithFormat:@"%@",model.customerName],
                                  [NSString stringWithFormat:@"%.2f",[model.loanAmount floatValue]/1000],
                                  [NSString stringWithFormat:@"%@",model.loanBankName],
                                  [NSString stringWithFormat:@"%@",[model.applyDatetime convertToDetailDate]]];

    for (int i = 0; i < nameArray.count; i ++ ) {
        UILabel *nameLabel = [self viewWithTag:100000 + i];
        nameLabel.text = nameArray[i];
        UILabel *InformationLabel = [self viewWithTag:1000000 + i];
        InformationLabel.text =[BaseModel convertNull: InformationArray[i]];
    }

}

-(void)setSettlementAuditModel:(SettlementAuditModel *)settlementAuditModel
{
    _codeLabel.text = [NSString stringWithFormat:@"%@",settlementAuditModel.code];
    _stateLabel.text = [[BaseModel user]note:settlementAuditModel.curNodeCode];
    NSArray *nameArray = @[
                           @"业务种类",
                           @"客户姓名",
                           @"贷款金额",
                           @"贷款银行",
                           @"申请时间"];
    NSString *shopWay;
    if ([settlementAuditModel.shopWay integerValue] == 1) {
        shopWay = @"新车";
    }
    else
    {
        shopWay = @"二手车";
    }

    NSArray *InformationArray = @[
                                  shopWay,
                                  [NSString stringWithFormat:@"%@",settlementAuditModel.realName],
                                  [NSString stringWithFormat:@"¥%.2f",[settlementAuditModel.loanAmount floatValue]/1000],
                                  [NSString stringWithFormat:@"%@",settlementAuditModel.loanBankName],
                                  [NSString stringWithFormat:@"%@",[settlementAuditModel.budgetOrder[@"applyDatetime"] convertToDetailDate]]];

    for (int i = 0; i < nameArray.count; i ++ ) {
        UILabel *nameLabel = [self viewWithTag:100000 + i];
        nameLabel.text = nameArray[i];
        UILabel *InformationLabel = [self viewWithTag:1000000 + i];
        InformationLabel.text = [BaseModel convertNull:InformationArray[i]];
    }

}

@end
