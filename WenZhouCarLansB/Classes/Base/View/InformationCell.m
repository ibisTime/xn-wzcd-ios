//
//  InformationCell.m
//  CarLoans
//
//  Created by QinBao Zheng on 2018/7/18.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "InformationCell.h"

@implementation InformationCell

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
        for (int i = 0; i < 6; i ++) {
            _nameLabel = [UILabel labelWithFrame:CGRectMake(15 , 70 + i % 6 * 35, 100, 15) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(14) textColor:GaryTextColor];
//            _nameLabel.text = nameArray[i];
            _nameLabel.tag = 100000 + i;
            [self addSubview:_nameLabel];

            _InformationLabel = [UILabel labelWithFrame:CGRectMake(115 , 70 + i % 6 * 35, SCREEN_WIDTH - 130, 15) textAligment:(NSTextAlignmentRight) backgroundColor:kClearColor font:HGfont(14) textColor:TextColor];
            _InformationLabel.tag = 1000000 + i;
            [self addSubview:_InformationLabel];
        }

        UIView *lineView2 = [[UIView alloc]initWithFrame:CGRectMake(0, 279, SCREEN_WIDTH, 1)];
        lineView2.backgroundColor = LineBackColor;
        [self addSubview:lineView2];

        _button1 = [UIButton buttonWithTitle:@"" titleColor:MainColor backgroundColor:kClearColor titleFont:15];
        _button1.frame = CGRectMake(SCREEN_WIDTH - 115 * 2, 290, 100, 30);
        kViewBorderRadius(_button1, 5, 1, MainColor);
        [self addSubview:_button1];
        _button1.hidden = YES;

        _button2 = [UIButton buttonWithTitle:@"" titleColor:MainColor backgroundColor:kClearColor titleFont:15];
        _button2.frame = CGRectMake(SCREEN_WIDTH - 115, 290, 100, 30);
        kViewBorderRadius(_button2, 5, 1, MainColor);
        [self addSubview:_button2];
        _button2.hidden = YES;

    }
    return self;
}


//
-(void)setAccessApplyModel:(AccessApplyModel *)accessApplyModel
{
    _codeLabel.text = [NSString stringWithFormat:@"%@",accessApplyModel.code];
    _stateLabel.text = [[BaseModel user]note:accessApplyModel.curNodeCode];

    NSLog(@"%@",[[BaseModel user]note:accessApplyModel.curNodeCode]);
    NSArray *nameArray = @[
                           @"购车途径",
                           @"客户姓名",
                           @"贷款金额",
                           @"贷款银行",
                           @"是否垫资",
                           @"申请时间"];
    NSString *shopWay;
    if ([accessApplyModel.shopWay integerValue] == 1) {
        shopWay = @"新车";
    }
    else
    {
        shopWay = @"二手车";
    }
    NSString *isAdvanceFund;
    if ([accessApplyModel.isAdvanceFund isEqualToString:@"1"]) {
        isAdvanceFund = @"是";
    }else
    {
        isAdvanceFund = @"否";
    }
    NSArray *InformationArray = @[
                                  [NSString stringWithFormat:@"%@",shopWay],
                                  [NSString stringWithFormat:@"%@",accessApplyModel.customerName],
                                  [NSString stringWithFormat:@"%.2f",[accessApplyModel.loanAmount floatValue]/1000],
                                  [NSString stringWithFormat:@"%@",accessApplyModel.loanBankName],
                                  isAdvanceFund,
                                  [NSString stringWithFormat:@"%@",[accessApplyModel.applyDatetime convertToDetailDate]]];

    for (int i = 0; i < nameArray.count; i ++ ) {
        UILabel *nameLabel = [self viewWithTag:100000 + i];
        nameLabel.text = nameArray[i];
        UILabel *InformationLabel = [self viewWithTag:1000000 + i];
        InformationLabel.text = [BaseModel convertNull:InformationArray[i]];
    }
}


-(void)setMakeCardModel:(MakeCardModel *)makeCardModel
{
    _codeLabel.text = [NSString stringWithFormat:@"%@",makeCardModel.code];
    _stateLabel.text = [[BaseModel user] setParentKey:@"make_card_status" setDkey:[NSString stringWithFormat:@"%@",makeCardModel.makeCardStatus]];

    NSLog(@"%@",[[BaseModel user]note:makeCardModel.curNodeCode]);
    NSArray *nameArray = @[
                           @"购车途径",
                           @"客户姓名",
                           @"贷款金额",
                           @"贷款银行",
                           @"是否垫资",
                           @"申请时间"];
    NSString *shopWay;
    if ([makeCardModel.shopWay integerValue] == 1) {
        shopWay = @"新车";
    }
    else
    {
        shopWay = @"二手车";
    }
    NSString *isAdvanceFund;
    if ([makeCardModel.isAdvanceFund isEqualToString:@"1"]) {
        isAdvanceFund = @"是";
    }else
    {
        isAdvanceFund = @"否";
    }
    NSArray *InformationArray = @[
                                  [NSString stringWithFormat:@"%@",shopWay],
                                  [NSString stringWithFormat:@"%@",makeCardModel.customerName],
                                  [NSString stringWithFormat:@"%.2f",[makeCardModel.loanAmount floatValue]/1000],
                                  [NSString stringWithFormat:@"%@",makeCardModel.loanBankName],
                                  isAdvanceFund,
                                  [NSString stringWithFormat:@"%@",[makeCardModel.applyDatetime convertToDetailDate]]];

    for (int i = 0; i < nameArray.count; i ++ ) {
        UILabel *nameLabel = [self viewWithTag:100000 + i];
        nameLabel.text = nameArray[i];
        UILabel *InformationLabel = [self viewWithTag:1000000 + i];
        InformationLabel.text = [BaseModel convertNull:InformationArray[i]];
    }
}

//准入单     车辆抵押    车辆落户
-(void)setAccessSingleModel:(AccessSingleModel *)accessSingleModel
{
    _codeLabel.text = [NSString stringWithFormat:@"%@",accessSingleModel.code];
    _stateLabel.text = [[BaseModel user]note:accessSingleModel.curNodeCode];

    NSLog(@"%@",[[BaseModel user]note:accessSingleModel.curNodeCode]);
    NSArray *nameArray = @[
                           @"业务种类",
                           @"客户姓名",
                           @"贷款金额",
                           @"贷款银行",
                           @"是否垫资",
                           @"申请时间"];
    NSString *shopWay;
    if ([accessSingleModel.shopWay integerValue] == 1) {
        shopWay = @"新车";
    }
    else
    {
        shopWay = @"二手车";
    }
    NSString *isAdvanceFund;
    if ([accessSingleModel.isAdvanceFund isEqualToString:@"1"]) {
        isAdvanceFund = @"已垫资";
    }else
    {
        isAdvanceFund = @"未垫资";
    }
    NSArray *InformationArray = @[
                                  [NSString stringWithFormat:@"%@",shopWay],
                                  [NSString stringWithFormat:@"%@",accessSingleModel.customerName],
                                  [NSString stringWithFormat:@"%.2f",[accessSingleModel.loanAmount floatValue]/1000],
                                  [NSString stringWithFormat:@"%@",accessSingleModel.loanBankName],
                                  isAdvanceFund,
                                  [NSString stringWithFormat:@"%@",[accessSingleModel.applyDatetime convertToDetailDate]]];

    for (int i = 0; i < nameArray.count; i ++ ) {
        UILabel *nameLabel = [self viewWithTag:100000 + i];
        nameLabel.text = nameArray[i];
        UILabel *InformationLabel = [self viewWithTag:1000000 + i];
        InformationLabel.text = [BaseModel convertNull:InformationArray[i]];
    }
}

//资料传递
-(void)setDataTransferModel:(DataTransferModel *)dataTransferModel
{
    _codeLabel.text = [NSString stringWithFormat:@"%@",dataTransferModel.bizCode];
        _stateLabel.text = [[BaseModel user] setParentKey:@"logistics_status" setDkey:dataTransferModel.status];
    NSArray *nameArray = @[
                           @"客户姓名",
                           @"传递方式",
                           @"快递公司",
                           @"快递单号",
                           @"发货说明",
                           @"补件原因"];
    //    (0 待发件 1已发件待收件 2已收件审核 3已收件待补件
    NSString *send_type;
    if ([BaseModel isBlankString:dataTransferModel.sendType] == YES) {
        send_type = @"";
    }else
    {
        send_type = [[BaseModel user] setParentKey:@"send_type" setDkey:dataTransferModel.sendType];
    }
    NSArray *InformationArray = @[
                                  [NSString stringWithFormat:@"%@",dataTransferModel.customerName],
                                  send_type,
                                  [NSString stringWithFormat:@"%@",[[BaseModel user] setParentKey:@"kd_company" setDkey:dataTransferModel.logisticsCompany]],
                                  [NSString stringWithFormat:@"%@",dataTransferModel.logisticsCode],
                                  [NSString stringWithFormat:@"%@",dataTransferModel.sendNote],
                                  [NSString stringWithFormat:@"%@",dataTransferModel.sendNote]];
    for (int i = 0; i < nameArray.count; i ++ ) {
        UILabel *nameLabel = [self viewWithTag:100000 + i];
        nameLabel.text = nameArray[i];
        UILabel *InformationLabel = [self viewWithTag:1000000 + i];
        InformationLabel.text = [BaseModel convertNull: InformationArray[i]];
    }
}

@end
