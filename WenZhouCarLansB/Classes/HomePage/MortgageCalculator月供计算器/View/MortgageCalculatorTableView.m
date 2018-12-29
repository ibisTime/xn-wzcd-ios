//
//  MortgageCalculatorTableView.m
//  WenZhouCarLansB
//
//  Created by QinBao Zheng on 2018/9/4.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "MortgageCalculatorTableView.h"
#import "ChooseCell.h"
#define Choose @"ChooseCell"
#import "ChooseCell2.h"
#define Choose2 @"ChooseCell2"
#import "MortgageCalculatorPriceCell.h"
#define MortgageCalculatorPrice @"MortgageCalculatorPriceCell"
#import "TheLoanAmountVCTableViewCell.h"
#define TheLoanAmountVCTableView @"TheLoanAmountVCTableViewCell"
#import "TextFieldCell.h"
#define TextField @"TextFieldCell"
@interface MortgageCalculatorTableView ()<UITableViewDataSource,UITableViewDelegate>

@end
@implementation MortgageCalculatorTableView


-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {

    if (self = [super initWithFrame:frame style:style]) {
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[ChooseCell class] forCellReuseIdentifier:Choose];
        [self registerClass:[ChooseCell2 class] forCellReuseIdentifier:Choose2];
        [self registerClass:[TheLoanAmountVCTableViewCell class] forCellReuseIdentifier:TheLoanAmountVCTableView];
        [self registerClass:[MortgageCalculatorPriceCell class] forCellReuseIdentifier:MortgageCalculatorPrice];
        [self registerClass:[TextFieldCell class] forCellReuseIdentifier:TextField];



    }
    return self;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

#pragma mark -- 行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 2;
    }

    if (section == 2) {
        if ([_bankStr isEqualToString:@"中国银行"]) {
            if ([_feesChargedStr isEqualToString:@"附加费"]) {
                return 3;
            }else
            {
                return 2;
            }
        }else
        {
            return 1;
        }
    }
    return 1;
}

#pragma mark -- tableView
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        ChooseCell *cell = [tableView dequeueReusableCellWithIdentifier:Choose forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSArray *nameArray = @[@"*贷款银行",@"*贷款周期"];
        cell.name = nameArray[indexPath.row];
        if (indexPath.row == 0) {
            cell.details = _bankStr;
        }else
        {
            cell.details = _periodStr;
        }
        return cell;
    }

    if (indexPath.section == 1) {
        TheLoanAmountVCTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TheLoanAmountVCTableView forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    if (indexPath.section == 2) {
        ChooseCell *cell = [tableView dequeueReusableCellWithIdentifier:Choose forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSArray *nameArray = @[@"*利率类型",@"*手续费收取方式",@"*附加费"];
        cell.name = nameArray[indexPath.row];
        if (indexPath.row == 0) {
            cell.details = _interestTypeStr;
        }else if(indexPath.row == 1)
        {
            cell.details = _feesChargedStr;
        }else
        {
            cell.details = _surcharge;
        }
        return cell;
    }
    if (indexPath.section == 3) {
        TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:TextField forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.name = @"*银行利率";
        cell.isInput = @"0";
        cell.nameTextField.text = [NSString stringWithFormat:@"%.2f",[_interestStr floatValue]];

        return cell;
    }
    MortgageCalculatorPriceCell *cell = [tableView dequeueReusableCellWithIdentifier:MortgageCalculatorPrice forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
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
    if (indexPath.section == 4) {
        return 140;
    }
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
    if (section == 4) {
        return 100;
    }
    return 0.01;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{

    if (section == 4) {
        UIView *headView = [[UIView alloc]init];

        UIButton *confirmButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        confirmButton.frame = CGRectMake(20, 10, SCREEN_WIDTH - 40, 50);
        [confirmButton setTitle:@"计算" forState:(UIControlStateNormal)];
        confirmButton.backgroundColor = MainColor;
        kViewRadius(confirmButton, 5);
        confirmButton.titleLabel.font = HGfont(18);
        [confirmButton addTarget:self action:@selector(confirmButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
        [headView addSubview:confirmButton];

        return headView;
    }

    return nil;
}

-(void)confirmButtonClick:(UIButton *)sender
{
    if ([self.refreshDelegate respondsToSelector:@selector(refreshTableViewButtonClick:button:selectRowAtIndex:)]) {

        [self.refreshDelegate refreshTableViewButtonClick:self button:sender selectRowAtIndex:sender.tag];

    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}


@end
