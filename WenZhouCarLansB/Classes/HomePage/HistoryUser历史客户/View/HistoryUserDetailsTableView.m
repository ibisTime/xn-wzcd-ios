//
//  HistoryUserDetailsTableView.m
//  CarLoans
//
//  Created by QinBao Zheng on 2018/8/31.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "HistoryUserDetailsTableView.h"
#import "TextFieldCell.h"
#define TextField @"TextFieldCell"
#import "ChooseCell.h"
#define Choose @"ChooseCell"
#import "RepaymentPlanCell.h"
#define RepaymentPlan @"RepaymentPlanCell"
@interface HistoryUserDetailsTableView ()<UITableViewDataSource,UITableViewDelegate>

@end
@implementation HistoryUserDetailsTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {

    if (self = [super initWithFrame:frame style:style]) {
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[TextFieldCell class] forCellReuseIdentifier:TextField];
        [self registerClass:[RepaymentPlanCell class] forCellReuseIdentifier:RepaymentPlan];


    }
    return self;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

#pragma mark -- 行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 9;
    }
    return self.model.repayPlanList.count;
}

#pragma mark -- tableView
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:TextField forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        NSArray *nameArray = @[@"状态",@"客户姓名",@"业务编号",@"公司名称",@"贷款期限",@"贷款金额",@"剩余欠款",@"贷款银行",@"还款计划"];
        cell.name = nameArray[indexPath.row];
        NSDictionary *budgetOrder = self.model.budgetOrder;
        cell.isInput = @"0";
        NSArray *detailsArray = @[
                                  [[BaseModel user]note:self.model.curNodeCode],
                                  [NSString stringWithFormat:@"%@",budgetOrder[@"applyUserName"]],
                                  [NSString stringWithFormat:@"%@",_model.code],
                                  [NSString stringWithFormat:@"%@",budgetOrder[@"companyName"]],
                                  [NSString stringWithFormat:@"%@",_model.periods],
                                  [NSString stringWithFormat:@"¥%.2f",[_model.loanAmount floatValue]/1000],
                                  [NSString stringWithFormat:@"¥%.2f",[self.model.restAmount floatValue]/1000],
                                  [NSString stringWithFormat:@"%@",budgetOrder[@"loanBankName"]],
                                  @""
                                  ];
        cell.TextFidStr = detailsArray[indexPath.row];

        return cell;
    }


    RepaymentPlanCell *cell = [tableView dequeueReusableCellWithIdentifier:RepaymentPlan forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.dic = self.model.repayPlanList[indexPath.row];
    return cell;

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
    if (indexPath.section == 0) {
        return 50;
    }
    return 130;

}

#pragma mark -- 区头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{

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
