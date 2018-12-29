//
//  MakeCardEntryTableView.m
//  WenZhouCarLansB
//
//  Created by QinBao Zheng on 2018/9/4.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "MakeCardEntryTableView.h"
#import "TextFieldCell.h"
#define TextField @"TextFieldCell"

@interface MakeCardEntryTableView ()<UITableViewDataSource,UITableViewDelegate>

@end
@implementation MakeCardEntryTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {

    if (self = [super initWithFrame:frame style:style]) {
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[TextFieldCell class] forCellReuseIdentifier:TextField];

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
        return 5;
    }
    return 2;
}

#pragma mark -- tableView
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:TextField forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSArray *nameArray = @[@"客户经验",@"业务编号",@"业务公司",@"贷款金额",@"贷款银行"];
        cell.name = nameArray[indexPath.row];
        cell.isInput = @"0";
        NSArray *detailsArray = @[
                                  [NSString stringWithFormat:@"%@",self.model.customerName],
                                  [NSString stringWithFormat:@"%@",self.model.code],
                                  [NSString stringWithFormat:@"%@",self.model.companyName],
                                  [NSString stringWithFormat:@"%.2f ¥",[self.model.loanAmount floatValue]/1000],
                                  [NSString stringWithFormat:@"%@",self.model.loanBankName],
                                  ];
        cell.TextFidStr = detailsArray[indexPath.row];
        return cell;
    }

    TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:TextField forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSArray *nameArray = @[@"卡号",@"备注"];
    cell.name = nameArray[indexPath.row];
    NSArray *placArray = @[@"请输入卡号",@"选填"];
    cell.nameText = placArray[indexPath.row];
    cell.nameTextField.tag = 300 + indexPath.row;
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
    if (section == 1) {
        return 100;
    }
    return 0.01;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{

    if (section == 1) {
        UIView *headView = [[UIView alloc]init];

        UIButton *confirmButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        confirmButton.frame = CGRectMake(20, 30, SCREEN_WIDTH - 40, 50);
        [confirmButton setTitle:@"录入" forState:(UIControlStateNormal)];
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

@end
