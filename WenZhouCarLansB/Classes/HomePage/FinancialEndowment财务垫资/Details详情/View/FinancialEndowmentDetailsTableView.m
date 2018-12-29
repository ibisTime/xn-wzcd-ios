//
//  FinancialEndowmentDetailsTableView.m
//  WenZhouCarLansB
//
//  Created by QinBao Zheng on 2018/9/4.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "FinancialEndowmentDetailsTableView.h"
#import "TextFieldCell.h"
#define TextField @"TextFieldCell"
#import "ChooseCell2.h"
#define Choose @"ChooseCell2"
@interface FinancialEndowmentDetailsTableView ()<UITableViewDataSource,UITableViewDelegate>

@end
@implementation FinancialEndowmentDetailsTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {

    if (self = [super initWithFrame:frame style:style]) {
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[TextFieldCell class] forCellReuseIdentifier:TextField];
        [self registerClass:[ChooseCell2 class] forCellReuseIdentifier:Choose];

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
        return 8;
    }
    return 1;
}

#pragma mark -- tableView
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:TextField forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        NSArray *nameArray = @[@"客户姓名",@"业务编号",@"业务公司",@"汽车经销商",@"用款金额",@"贷款银行",@"账号",@"是否垫资"];
        cell.name = nameArray[indexPath.row];


        NSString *isAdvanceFund;
        if ([self.surveyModel.isAdvanceFund isEqualToString:@"1"]) {
            isAdvanceFund = @"是";
        }else
        {
            isAdvanceFund = @"否";
        }

        NSArray *detailsArray = @[
                                  [NSString stringWithFormat:@"%@",self.surveyModel.customerName],
                                  [NSString stringWithFormat:@"%@",self.surveyModel.code],
                                  [NSString stringWithFormat:@"%@",self.surveyModel.bizCompanyName],
                                  [NSString stringWithFormat:@"%@",self.surveyModel.carDealerName],
                                  [NSString stringWithFormat:@"%.2f ¥",[self.surveyModel.loanAmount floatValue]/1000],
                                  [NSString stringWithFormat:@"%@",self.surveyModel.loanBankName],
                                  [NSString stringWithFormat:@"%@",self.surveyModel.collectionAccountNo],
                                  isAdvanceFund
                                  ];
        cell.TextFidStr = detailsArray[indexPath.row];
        cell.isInput = @"0";
        return cell;
    }
    ChooseCell2 *cell = [tableView dequeueReusableCellWithIdentifier:Choose forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.name = @"征信结果";
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
    return 50;
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
