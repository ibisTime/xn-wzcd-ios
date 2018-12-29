//
//  SurveyDetailsTableView.m
//  CarLoans
//
//  Created by QinBao Zheng on 2018/7/31.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "SurveyDetailsTableView.h"

#import "TextFieldCell.h"
#define TextField @"TextFieldCell"
#import "CreditReportingPersonInformationCell.h"
#define CreditReportingPersonInformation @"CreditReportingPersonInformationCell"
#import "UsedCarInformationCell.h"
#define UsedCarInformation @"UsedCarInformationCell"
#import "UsedCarInformationCell.h"
#define UsedCarInformation @"UsedCarInformationCell"
@interface SurveyDetailsTableView ()<UITableViewDataSource,UITableViewDelegate,CreditReportingPersonInformationDelegate>

@end

@implementation SurveyDetailsTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {

    if (self = [super initWithFrame:frame style:style]) {
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[TextFieldCell class] forCellReuseIdentifier:TextField];
        [self registerClass:[CreditReportingPersonInformationCell class] forCellReuseIdentifier:CreditReportingPersonInformation];
        [self registerClass:[UsedCarInformationCell class] forCellReuseIdentifier:UsedCarInformation];
        [self registerClass:[UsedCarInformationCell class] forCellReuseIdentifier:UsedCarInformation];
        [self registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    }
    return self;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([_surveyDetailsModel.shopWay integerValue] == 1) {
        return 3;
    }else
    {
        return 4;
    }

}

#pragma mark -- 行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    if (section == 0) {
        return 3;
    }
    return 1;
}

#pragma mark -- tableView
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:TextField forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSArray *nameArray = @[@"银行",@"业务种类",@"贷款金额"];
        cell.name = nameArray[indexPath.row];
        cell.isInput = @"0";
        NSString *shopWay;
        if ([_surveyDetailsModel.shopWay integerValue] == 1) {
            shopWay = @"新车";
        }
        else
        {
            shopWay = @"二手车";
        }
        NSArray *detailsArray = @[
                                  [NSString stringWithFormat:@"%@",_surveyDetailsModel.loanBankName],
                 [NSString stringWithFormat:@"%@",shopWay],
                 [NSString stringWithFormat:@"%.2f   ¥",[_surveyDetailsModel.loanAmount floatValue]/1000]
                 ];
        cell.TextFidStr = detailsArray[indexPath.row];
        return cell;
    }
    if ([_surveyDetailsModel.shopWay integerValue] == 1) {
//        新车
        if (indexPath.section == 1) {
            TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:TextField forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.name = @"征信人";
            cell.isInput = @"0";
            return cell;
        }
        CreditReportingPersonInformationCell *cell = [tableView dequeueReusableCellWithIdentifier:CreditReportingPersonInformation forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.Delegate = self;
        if (self.surveyDetailsModel.creditUserList > 0) {
            cell.model = self.surveyDetailsModel;
        }
        return cell;
    }
    else
    {
//        二手车
        if (indexPath.section == 1) {
            UsedCarInformationCell *cell = [tableView dequeueReusableCellWithIdentifier:UsedCarInformation forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.name = @"二手车评估报告";
            cell.picArray = @[
                              [NSString stringWithFormat:@"%@",self.surveyDetailsModel.xszFront],
                              [NSString stringWithFormat:@"%@",self.surveyDetailsModel.xszReverse]
                              ];
            return cell;
        }
        if (indexPath.section == 2) {
            TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:TextField forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.name = @"征信人";
            cell.isInput = @"0";
            return cell;
        }
        CreditReportingPersonInformationCell *cell = [tableView dequeueReusableCellWithIdentifier:CreditReportingPersonInformation forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.Delegate = self;
        if (self.surveyDetailsModel.creditUserList > 0) {
            cell.model = self.surveyDetailsModel;
        }
        return cell;
    }


}

-(void)appraisalReportBtnClick
{

}

-(void)CreditReportingPersonInformationButton:(UIButton *)sender
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

    if ([_surveyDetailsModel.shopWay integerValue] == 1) {
        if (indexPath.section == 2) {
            return 30 + 135 * self.surveyDetailsModel.creditUserList.count + (self.surveyDetailsModel.creditUserList.count - 1) * 10 ;
        }
        return 50;
    }else
    {
        if (indexPath.section == 1) {
            return 50 + SCREEN_WIDTH/3 + 15;
        }
        if (indexPath.section == 3) {
            return 30 + 135 * self.surveyDetailsModel.creditUserList.count + (self.surveyDetailsModel.creditUserList.count - 1) * 10;
        }
        return 50;
    }

}

#pragma mark -- 区头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return 10;
    }
    return 0.01;
}

#pragma mark -- 区尾高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}


@end
