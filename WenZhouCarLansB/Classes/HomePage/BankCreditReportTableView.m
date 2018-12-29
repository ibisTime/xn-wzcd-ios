//
//  BankCreditReportTableView.m
//  WenZhouCarLansB
//
//  Created by QinBao Zheng on 2018/9/10.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "BankCreditReportTableView.h"


#import "TextFieldCell.h"
#define TextField @"TextFieldCell"
#import "InputBoxCell.h"
#define InputBox @"InputBoxCell"

@interface BankCreditReportTableView ()<UITableViewDataSource,UITableViewDelegate>


@end

@implementation BankCreditReportTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {

    if (self = [super initWithFrame:frame style:style]) {
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[TextFieldCell class] forCellReuseIdentifier:TextField];
        [self registerClass:[InputBoxCell class] forCellReuseIdentifier:InputBox];

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

    if (section == 0 || section == 1 || section == 2) {
        return 6;
    }
    return 3;
}

#pragma mark -- tableView
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:TextField forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.isInput = @"0";
            cell.name = @"笔数";
            cell.nameTextField.text = self.model.dkdyCount;
            return cell;
        }
        if (indexPath.row == 1) {
            InputBoxCell *cell = [tableView dequeueReusableCellWithIdentifier:InputBox forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.name = @"贷款余额";
            cell.isInput = @"0";
            cell.nameTextField.text = [NSString stringWithFormat:@"%.2f",[self.model.dkdyAmount floatValue]/1000];
            return cell;
        }
        if (indexPath.row == 2) {
            TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:TextField forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.isInput = @"0";
            cell.name = @"近两年逾期次数";
            cell.nameTextField.text = self.model.dkdy2YearOverTimes;
            return cell;
        }
        if (indexPath.row == 3 || indexPath.row == 4 || indexPath.row == 5) {
            InputBoxCell *cell = [tableView dequeueReusableCellWithIdentifier:InputBox forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            NSArray *nameArray = @[@"最高逾期金额",@"当前逾期金额",@"近6个月平均月还款额"];
            cell.name = nameArray[indexPath.row - 3];
            cell.isInput = @"0";
            NSArray *detailsArray =
                     @[[NSString stringWithFormat:@"%.2f",[self.model.dkdyMaxOverAmount floatValue]/1000],
                       [NSString stringWithFormat:@"%.2f",[self.model.dkdyCurrentOverAmount floatValue]/1000],
                       [NSString stringWithFormat:@"%.2f",[self.model.dkdy6MonthAvgAmount floatValue]/1000]];
            cell.nameTextField.text = detailsArray[indexPath.row - 3];
            return cell;
        }

    }
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:TextField forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.isInput = @"0";
            cell.name = @"未结清贷款笔数";
            cell.nameTextField.text = self.model.dkdyCount;
            return cell;
        }
        if (indexPath.row == 1) {
            InputBoxCell *cell = [tableView dequeueReusableCellWithIdentifier:InputBox forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.name = @"未结清贷款余额";
            cell.isInput = @"0";
            cell.nameTextField.text = [NSString stringWithFormat:@"%.2f",[self.model.hkxyUnsettleAmount floatValue]/1000];
            return cell;
        }
        if (indexPath.row == 2) {
            TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:TextField forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.isInput = @"0";
            cell.name = @"近两年逾期次数";
            cell.nameTextField.text = self.model.hkxy2YearOverTimes;
            return cell;
        }
        if (indexPath.row == 3 || indexPath.row == 4 || indexPath.row == 5) {
            InputBoxCell *cell = [tableView dequeueReusableCellWithIdentifier:InputBox forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            NSArray *nameArray = @[@"单月最高逾期金额",@"当前逾期金额",@"近6个月平均月还款额"];
            cell.name = nameArray[indexPath.row - 3];
            cell.isInput = @"0";
            NSArray *detailsArray =
            @[[NSString stringWithFormat:@"%.2f",[self.model.hkxyMonthMaxOverAmount floatValue]/1000],
              [NSString stringWithFormat:@"%.2f",[self.model.hkxyCurrentOverAmount floatValue]/1000],
              [NSString stringWithFormat:@"%.2f",[self.model.hkxyMonthMaxOverAmount floatValue]/1000]];
            cell.nameTextField.text = detailsArray[indexPath.row - 3];
            return cell;
        }

    }
    if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:TextField forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.isInput = @"0";
            cell.name = @"张数";
            cell.nameTextField.text = self.model.xykCount;
            return cell;
        }
        if (indexPath.row == 1 || indexPath.row == 2) {
            InputBoxCell *cell = [tableView dequeueReusableCellWithIdentifier:InputBox forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            NSArray *nameArray = @[@"授信总额",@"近6个月使用额"];
            cell.name = nameArray[indexPath.row - 1];
            cell.isInput = @"0";
            NSArray *detailsArray = @[
                                      [NSString stringWithFormat:@"%.2f",[self.model.xykCreditAmount floatValue]/1000],
                                      [NSString stringWithFormat:@"%.2f",[self.model.xyk6MonthUseAmount floatValue]/1000]];
            cell.nameTextField.text = detailsArray[indexPath.row - 1];
            return cell;
        }
        if (indexPath.row == 3) {
            TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:TextField forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.isInput = @"0";
            cell.name = @"近两年逾期次数";
            cell.nameTextField.text = self.model.xyk2YearOverTimes;
            return cell;
        }
        if (indexPath.row == 4 || indexPath.row == 5) {
            InputBoxCell *cell = [tableView dequeueReusableCellWithIdentifier:InputBox forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            NSArray *nameArray = @[@"单月最高逾期金额",@"当前逾期金额"];
            cell.name = nameArray[indexPath.row - 4];
            cell.isInput = @"0";
            NSArray *detailsArray =
            @[[NSString stringWithFormat:@"%.2f",[self.model.xykMonthMaxOverAmount floatValue]/1000],
              [NSString stringWithFormat:@"%.2f",[self.model.xykCurrentOverAmount floatValue]/1000]
              ];
            cell.nameTextField.text = detailsArray[indexPath.row - 4];
            return cell;
        }

    }
    if (indexPath.row == 0) {
        TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:TextField forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.isInput = @"0";
        cell.name = @"笔数";
        cell.nameTextField.text = self.model.outGuaranteesCount;
        return cell;
    }
    if (indexPath.row == 1) {
        InputBoxCell *cell = [tableView dequeueReusableCellWithIdentifier:InputBox forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.isInput = @"0";
        cell.name = @"余额";
        cell.nameTextField.text = [NSString stringWithFormat:@"%.2f",[self.model.outGuaranteesAmount floatValue]/1000];
        return cell;
    }
    TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:TextField forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.isInput = @"0";
    cell.name = @"备注";
    cell.nameTextField.text = self.model.outGuaranteesRemark;
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
    return 45;
}

#pragma mark -- 区尾高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{

    UIView *headView = [[UIView alloc]init];
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 35)];
    backView.backgroundColor = [UIColor whiteColor];
    [headView addSubview:backView];

    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(15, 10, 4, 15)];
    lineView.backgroundColor = MainColor;
    [backView addSubview:lineView];
    UILabel *headLabel = [UILabel labelWithFrame:CGRectMake(30, 0, SCREEN_WIDTH - 45, 35) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(15) textColor:[UIColor blackColor]];
    [backView addSubview:headLabel];
    //    headView.
    NSArray *nameArray = @[@"贷款抵押",@"贷款信用",@"信用卡",@"备注"];
    headLabel.text = nameArray[section];


    UIView *lineView1 = [[UIView alloc]initWithFrame:CGRectMake(0, 34, SCREEN_WIDTH, 1)];
    lineView1.backgroundColor = LineBackColor;
    [backView addSubview:lineView1];

    return headView;


}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{


    return nil;
}



@end
