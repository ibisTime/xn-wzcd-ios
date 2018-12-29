//
//  GPSInvalidTableView.m
//  WenZhouCarLansB
//
//  Created by QinBao Zheng on 2018/9/5.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "GPSInvalidTableView.h"

#import "TextFieldCell.h"
#define TextField @"TextFieldCell"
#import "SurveyPeopleTableViewCell.h"
#define SurveyPeople @"SurveyPeopleTableViewCell"
#import "GPSInformationListCell.h"
#define GPSInformationList @"GPSInformationListCell"
#import "AddGPSPeopleCell.h"
#define AddGPSPeople @"AddGPSPeopleCell"
#import "ChooseCell.h"
#define Choose @"ChooseCell"
#import "ChooseCell2.h"
#define Choose2 @"ChooseCell2"
#import "TextFieldCell.h"
#define TextField @"TextFieldCell"
@interface GPSInvalidTableView ()<UITableViewDataSource,UITableViewDelegate,SurveyPeopleDelegate>

@end


@implementation GPSInvalidTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {

    if (self = [super initWithFrame:frame style:style]) {
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[TextFieldCell class] forCellReuseIdentifier:TextField];
        [self registerClass:[SurveyPeopleTableViewCell class] forCellReuseIdentifier:SurveyPeople];
        [self registerClass:[GPSInformationListCell class] forCellReuseIdentifier:GPSInformationList];
        [self registerClass:[AddGPSPeopleCell class] forCellReuseIdentifier:AddGPSPeople];
        [self registerClass:[ChooseCell class] forCellReuseIdentifier:Choose];
        [self registerClass:[ChooseCell2 class] forCellReuseIdentifier:Choose2];



    }
    return self;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

#pragma mark -- 行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 4;
    }
    if (section == 3) {
        return _model.budgetOrderGpsList.count;
    }
    return 1;
}

#pragma mark -- tableView
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:TextField forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSArray *nameArray = @[@"客户姓名",@"业务编号",@"贷款银行",@"贷款金额"];
        cell.name = nameArray[indexPath.row];
        cell.isInput = @"0";
        NSArray *detailsArray = @[
                                  [NSString stringWithFormat:@"%@", _model.customerName],
                                  [NSString stringWithFormat:@"%@", _model.code],
                                  [NSString stringWithFormat:@"%@", _model.loanBankName],
                                  [NSString stringWithFormat:@"%.2f  ¥", [_model.credit[@"loanAmount"] floatValue]]
                                  ];
        cell.TextFidStr = detailsArray[indexPath.row];
        return cell;
    }
    if (indexPath.section == 1) {
        ChooseCell *cell = [tableView dequeueReusableCellWithIdentifier:Choose forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.name = @"作废GPS设备号";
        cell.details = _GPS;
        return cell;
    }
    if (indexPath.section == 2) {
        TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:TextField forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.name = @"备注";
        cell.nameText = @"请输入备注";
        cell.nameTextField.tag = 100;
        return cell;
    }
    GPSInformationListCell *cell = [tableView dequeueReusableCellWithIdentifier:GPSInformationList forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.dic = _model.budgetOrderGpsList[indexPath.row];
    [cell.deleteBtn addTarget:self action:@selector(deleteBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
    cell.deleteBtn.tag = indexPath.row;
    return cell;
}

-(void)deleteBtnClick:(UIButton *)sender
{
    if ([self.refreshDelegate respondsToSelector:@selector(refreshTableViewButtonClick:button:selectRowAtIndex:selectRowState:)]) {

        [self.refreshDelegate refreshTableViewButtonClick:self button:sender selectRowAtIndex:sender.tag selectRowState:@""];
    }
}


//添加证信人
-(void)photoBtnClick:(UIButton *)sender
{
    if ([self.refreshDelegate respondsToSelector:@selector(refreshTableViewButtonClick:button:selectRowAtIndex:)]) {

        [self.refreshDelegate refreshTableViewButtonClick:self button:sender selectRowAtIndex:sender.tag];
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.refreshDelegate respondsToSelector:@selector(refreshTableView:didSelectRowAtIndexPath:)]) {
        [self.refreshDelegate refreshTableView:self didSelectRowAtIndexPath:indexPath];
    }
}

#pragma mark -- 行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 3) {
        return 215;
    }
    return 50;
}

#pragma mark -- 区头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return 10;
    }
    if (section == 3) {
        return 50;
    }
    return 0.01;
}

#pragma mark -- 区尾高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 2) {
        return 10;
    }
    if (section == 3) {
        return 100;
    }
    return 0.01;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 3) {
        UIView *headView = [[UIView alloc]init];
        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
        backView.backgroundColor = [UIColor whiteColor];
        [headView addSubview:backView];

        UILabel *headLabel = [UILabel labelWithFrame:CGRectMake(15, 0, SCREEN_WIDTH - 30, 50) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(15) textColor:[UIColor blackColor]];
        headLabel.text = @"已安装列表";
        [backView addSubview:headLabel];

        return headView;
    }
    return nil;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{

    if (section == 3) {
        UIView *headView = [[UIView alloc]init];

        UIButton *confirmButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        confirmButton.frame = CGRectMake(20, 30, SCREEN_WIDTH - 40, 50);
        [confirmButton setTitle:@"确定" forState:(UIControlStateNormal)];
        confirmButton.backgroundColor = MainColor;
        kViewRadius(confirmButton, 5);
        confirmButton.titleLabel.font = HGfont(18);
        [confirmButton addTarget:self action:@selector(photoBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
        confirmButton.tag = 100;
        [headView addSubview:confirmButton];

        return headView;
    }
    return nil;
}


@end
