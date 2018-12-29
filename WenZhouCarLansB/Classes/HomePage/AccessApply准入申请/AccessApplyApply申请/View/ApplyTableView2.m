//
//  ApplyTableView2.m
//  WenZhouCarLansB
//
//  Created by QinBao Zheng on 2018/9/3.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "ApplyTableView2.h"
#import "ChooseCell.h"
#define ChooseC @"ChooseCell"

#import "TextFieldCell.h"
#define TextField @"TextFieldCell"

#import "InputBoxCell.h"
#define InputBox @"InputBoxCell"
@interface ApplyTableView2 ()<UITableViewDataSource,UITableViewDelegate>


@end
@implementation ApplyTableView2

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {

    if (self = [super initWithFrame:frame style:style]) {
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[ChooseCell class] forCellReuseIdentifier:ChooseC];
        [self registerClass:[TextFieldCell class] forCellReuseIdentifier:TextField];
        [self registerClass:[InputBoxCell class] forCellReuseIdentifier:InputBox];
    }
    return self;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 14;
}

#pragma mark -- 行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    if (section == 0 || section == 3 || section == 5|| section == 8|| section == 11) {
        return 3;
    }
    if (section == 1 || section == 2 || section == 4 || section == 6 || section == 9 || section == 12) {
        return 2;
    }
    return 1;
}

#pragma mark -- tableView
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.section == 0) {

        TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:TextField forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSArray *nameArray = @[@"申请人姓名",@"共还人姓名",@"担保人"];
        cell.isInput = @"0";
        cell.name = nameArray[indexPath.row];
        cell.nameText = @"";
        NSArray *detailsArray = @[
                                  self.model.customerName,
                                  @"",
                                  @""
                                  ];
        cell.TextFidStr = detailsArray[indexPath.row];
        return cell;
    }
    if (indexPath.section == 1) {

        NSString *CellIdentifier = [NSString stringWithFormat:@"cell1%ld%ld",indexPath.section,indexPath.row];
        TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[TextFieldCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
            if (indexPath.row == 0) {
                cell.TextFidStr = [NSString stringWithFormat:@"%@",self.model.applyUserCompany];
            }else
            {
                cell.TextFidStr = [NSString stringWithFormat:@"%@",self.model.applyUserDuty];
            }
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSArray *nameArray = @[@"*申请人就职单位",@"*申请人职位"];
        cell.name = nameArray[indexPath.row];
        NSArray *placArray = @[@"请输入申请人就职单位",@"请输入申请人职位"];
        cell.nameText = placArray[indexPath.row];

        cell.nameTextField.tag = 22200 + indexPath.row;
        return cell;
    }
    if (indexPath.section == 2) {
        ChooseCell *cell = [tableView dequeueReusableCellWithIdentifier:ChooseC forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSArray *nameArray = @[@"*申请人共还人关系",@"*婚姻状况"];
        cell.name = nameArray[indexPath.row];
        NSArray *detailsArray = @[
                                  [[BaseModel user]setParentKey:@"credit_user_relation" setDkey:self.model.applyUserGhrRelation],
                                  [[BaseModel user]setParentKey:@"marry_state" setDkey:self.model.marryState]
                                  ];
        cell.details = detailsArray[indexPath.row];
        return cell;
    }
    if (indexPath.section == 3) {

        NSString *CellIdentifier = [NSString stringWithFormat:@"cell1%ld%ld",indexPath.section,indexPath.row];
        InputBoxCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[InputBoxCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
            NSArray *detailsArray = @[
                                      [NSString stringWithFormat:@"%.2f",[self.model.applyUserMonthIncome floatValue]/1000],
                                      [NSString stringWithFormat:@"%.2f",[self.model.applyUserSettleInterest floatValue]/1000],
                                      [NSString stringWithFormat:@"%.2f",[self.model.applyUserBalance floatValue]/1000]];
            cell.nameTextField.text = detailsArray[indexPath.row];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSArray *nameArray = @[@"*申请人月收入(元)",@"申请人结息",@"申请人余额"];
        cell.name = nameArray[indexPath.row];
        return cell;
    }
    if (indexPath.section == 4) {
        ChooseCell *cell = [tableView dequeueReusableCellWithIdentifier:ChooseC forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSArray *nameArray = @[@"申请人流水是否提现月收入",@"申请人是否打件"];
        cell.name = nameArray[indexPath.row];

        NSArray *detailsArray = @[
                                  [self WhetherOrNot:self.model.applyUserJourShowIncome],
                                  [self WhetherOrNot:self.model.applyUserJourShowIncome]
                                  ];

        cell.details = detailsArray[indexPath.row];

        return cell;
    }
    if (indexPath.section == 5) {

        NSString *CellIdentifier = [NSString stringWithFormat:@"cell1%ld%ld",indexPath.section,indexPath.row];
        InputBoxCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[InputBoxCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
            NSArray *detailsArray = @[
                                      [NSString stringWithFormat:@"%.2f",[self.model.ghMonthIncome floatValue]/1000],
                                      [NSString stringWithFormat:@"%.2f",[self.model.ghSettleInterest floatValue]/1000],
                                      [NSString stringWithFormat:@"%.2f",[self.model.ghBalance floatValue]/1000]];
            cell.nameTextField.text = detailsArray[indexPath.row];
        }

        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSArray *nameArray = @[@"共还人月收入(元)",@"共还人结息",@"共还人余额"];
        cell.name = nameArray[indexPath.row];
        return cell;
    }
    if (indexPath.section == 6) {
        ChooseCell *cell = [tableView dequeueReusableCellWithIdentifier:ChooseC forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSArray *nameArray = @[@"共还人流水是否提现月收入",@"共还人是否打件"];
        cell.name = nameArray[indexPath.row];

        NSArray *detailsArray = @[
                                  [self WhetherOrNot:self.model.ghJourShowIncome],
                                  [self WhetherOrNot:self.model.ghIsPrint]
                                  ];
        cell.details = detailsArray[indexPath.row];

        return cell;
    }
    if (indexPath.section == 7) {
        TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:TextField forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSArray *nameArray = @[@"担保人1姓名"];
        cell.isInput = @"0";
        cell.name = nameArray[indexPath.row];
        cell.nameText = @"";
        cell.TextFidStr = [NSString stringWithFormat:@"%@",self.model.applyUserCompany];
        return cell;
    }
    if (indexPath.section == 8) {

        NSString *CellIdentifier = [NSString stringWithFormat:@"cell1%ld%ld",indexPath.section,indexPath.row];
        InputBoxCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[InputBoxCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
            NSArray *detailsArray = @[
                                      [NSString stringWithFormat:@"%.2f",[self.model.guarantor1MonthIncome floatValue]/1000],
                                      [NSString stringWithFormat:@"%.2f",[self.model.guarantor1SettleInterest floatValue]/1000],
                                      [NSString stringWithFormat:@"%.2f",[self.model.guarantor1Balance floatValue]/1000]];
            cell.nameTextField.text = detailsArray[indexPath.row];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSArray *nameArray = @[@"担保人1月收入(元)",@"担保人1结息",@"担保人1余额"];
        cell.name = nameArray[indexPath.row];
        return cell;
    }
    if (indexPath.section == 9) {
        ChooseCell *cell = [tableView dequeueReusableCellWithIdentifier:ChooseC forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSArray *nameArray = @[@"担保人1流水是否提现月收入",@"担保人1是否打件"];
        cell.name = nameArray[indexPath.row];

        NSArray *detailsArray = @[
                                  [self WhetherOrNot:self.model.guarantor1JourShowIncome],
                                  [self WhetherOrNot:self.model.guarantor1IsPrint]
                                  ];
        cell.details = detailsArray[indexPath.row];
        return cell;
    }
    if (indexPath.section == 10) {
        TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:TextField forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSArray *nameArray = @[@"担保人2姓名"];
        cell.isInput = @"0";
        cell.name = nameArray[indexPath.row];
        cell.nameText = @"";
        cell.TextFidStr = [NSString stringWithFormat:@"%@",self.model.applyUserCompany];
        return cell;
    }
    if (indexPath.section == 11) {
        NSString *CellIdentifier = [NSString stringWithFormat:@"cell1%ld%ld",indexPath.section,indexPath.row];
        InputBoxCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[InputBoxCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
            NSArray *detailsArray = @[
                                      [NSString stringWithFormat:@"%.2f",[self.model.guarantor2MonthIncome floatValue]/1000],
                                      [NSString stringWithFormat:@"%.2f",[self.model.guarantor2SettleInterest floatValue]/1000],
                                      [NSString stringWithFormat:@"%.2f",[self.model.guarantor2Balance floatValue]/1000]];
            cell.nameTextField.text = detailsArray[indexPath.row];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSArray *nameArray = @[@"担保人2月收入(元)",@"担保人2结息",@"担保人2余额"];
        cell.name = nameArray[indexPath.row];
        return cell;
    }
    if (indexPath.section == 12) {
        ChooseCell *cell = [tableView dequeueReusableCellWithIdentifier:ChooseC forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSArray *nameArray = @[@"担保人2流水是否提现月收入",@"担保人2是否打件"];
        cell.name = nameArray[indexPath.row];
        NSArray *detailsArray = @[
                                  [self WhetherOrNot:self.model.guarantor2JourShowIncome],
                                  [self WhetherOrNot:self.model.guarantor2IsPrint]
                                  ];
        cell.details = detailsArray[indexPath.row];
        return cell;
    }
    NSString *CellIdentifier = [NSString stringWithFormat:@"cell1%ld%ld",indexPath.section,indexPath.row];
    TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[TextFieldCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.TextFidStr = [NSString stringWithFormat:@"%@",self.model.otherIncomeNote];
    }

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSArray *nameArray = @[@"其他收入说明"];
    cell.nameTextField.tag = 22202 + indexPath.row;
    cell.name = nameArray[indexPath.row];
    cell.nameText = @"选填";
    return cell;


}


-(NSString *)WhetherOrNot:(NSString *)str
{
    if ([str isEqualToString:@"1"]) {
        return @"是";
    }else if ([str isEqualToString:@"0"])
    {
        return @"否";
    }else
    {
        return @"";
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

    return 50;
}

#pragma mark -- 区头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if ( section == 3 || section == 5 || section == 7 || section == 10) {
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
