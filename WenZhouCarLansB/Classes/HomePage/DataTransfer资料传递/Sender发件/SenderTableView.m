//
//  SenderTableView.m
//  CarLoans
//
//  Created by QinBao Zheng on 2018/8/2.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "SenderTableView.h"
#import "TextFieldCell.h"
#define TextField @"TextFieldCell"
#import "ChooseCell.h"
#define Choose @"ChooseCell"

@interface SenderTableView ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation SenderTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {

    if (self = [super initWithFrame:frame style:style]) {
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[TextFieldCell class] forCellReuseIdentifier:TextField];
        [self registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        [self registerClass:[ChooseCell class] forCellReuseIdentifier:Choose];
        self.distributionStr = @"";
        self.date = @"";
        self.CourierCompanyStr = @"";

    }
    return self;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([_distributionStr isEqualToString:@"快递"]) {
        return 5;
    }else
    {
        return 3;
    }
}

#pragma mark -- 行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    if (section == 0) {
        return 3;
    }
    if (section == 1) {
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

        NSArray *nameArray = @[@"客户姓名",@"业务编号",@"材料类型"];
        cell.name = nameArray[indexPath.row];
        cell.isInput = @"0";
        NSArray *detailsArray = @[
                                  [NSString stringWithFormat:@"%@",_model.userName],
                                  [NSString stringWithFormat:@"%@",_model.code],
                                  @""
                                  ];
        cell.TextFidStr = detailsArray[indexPath.row];
        return cell;
    }
    if ([_distributionStr isEqualToString:@"快递"]) {
        if (indexPath.section == 1) {
            ChooseCell *cell = [tableView dequeueReusableCellWithIdentifier:Choose forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            NSArray *nameArray = @[@"寄送方式",@"快递公司"];
            cell.name = nameArray[indexPath.row];
            NSArray *detailsArray = @[_distributionStr,_CourierCompanyStr];
            cell.details = detailsArray[indexPath.row];
            return cell;
        }
        if (indexPath.section == 2) {
            TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:TextField forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.name = @"快递单号";
            cell.nameText = @"请输入快递单号";
            cell.nameTextField.tag = 100;
            return cell;
        }
        if (indexPath.section == 3) {
            ChooseCell *cell = [tableView dequeueReusableCellWithIdentifier:Choose forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.name = @"发货时间";
            cell.details = self.date;
            return cell;
        }
        TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:TextField forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.name = @"发货说明";
        cell.nameText = @"发货说明";
        cell.nameTextField.tag = 101;
        return cell;
    }else
    {
        if (indexPath.section == 1) {
            ChooseCell *cell = [tableView dequeueReusableCellWithIdentifier:Choose forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            NSArray *nameArray = @[@"寄送方式",@"发货时间"];
            cell.name = nameArray[indexPath.row];
            NSArray *detailsArray = @[_distributionStr,_date];
            cell.details = detailsArray[indexPath.row];
            return cell;
        }
        TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:TextField forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.name = @"发货说明";
        cell.nameText = @"发货说明";
        cell.nameTextField.tag = 101;
        return cell;
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
    if (section == 1) {
        return 10;
    }
    return 0.01;
}

#pragma mark -- 区尾高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if ([_distributionStr isEqualToString:@"快递"]) {
        if (section == 4) {
            return 100;
        }
    }else
    {
        if (section == 2) {
            return 100;
        }
    }

    return 0.01;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if ([_distributionStr isEqualToString:@"快递"]) {
        if (section == 4) {
            UIView *headView = [[UIView alloc]init];

            UIButton *confirmButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
            confirmButton.frame = CGRectMake(20, 30, SCREEN_WIDTH - 40, 50);
            [confirmButton setTitle:@"确认" forState:(UIControlStateNormal)];
            confirmButton.backgroundColor = MainColor;
            kViewRadius(confirmButton, 5);
            confirmButton.titleLabel.font = HGfont(18);
            [confirmButton addTarget:self action:@selector(confirmButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
            [headView addSubview:confirmButton];

            return headView;
        }
    }else
    {
        if (section == 2) {
            UIView *headView = [[UIView alloc]init];

            UIButton *confirmButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
            confirmButton.frame = CGRectMake(20, 30, SCREEN_WIDTH - 40, 50);
            [confirmButton setTitle:@"确认" forState:(UIControlStateNormal)];
            confirmButton.backgroundColor = MainColor;
            kViewRadius(confirmButton, 5);
            confirmButton.titleLabel.font = HGfont(18);
            [confirmButton addTarget:self action:@selector(confirmButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
            [headView addSubview:confirmButton];

            return headView;
        }
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
