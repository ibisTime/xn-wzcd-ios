//
//  ReceivesAuditTableView.m
//  CarLoans
//
//  Created by QinBao Zheng on 2018/8/8.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "ReceivesAuditTableView.h"


#import "TextFieldCell.h"
#define TextField @"TextFieldCell"
#import "ChooseCell.h"
#define Choose @"ChooseCell"

@interface ReceivesAuditTableView ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation ReceivesAuditTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {

    if (self = [super initWithFrame:frame style:style]) {
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[TextFieldCell class] forCellReuseIdentifier:TextField];
        [self registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        [self registerClass:[ChooseCell class] forCellReuseIdentifier:Choose];

    }
    return self;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 7;
}

#pragma mark -- 行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    if (section == 0) {
        return 4;
    }
    if (section == 5) {
        if ([_model.sendType isEqualToString:@"2"]) {
            return 4;
        }else
        {
            return 2;
        }
    }
    return 1;
}

#pragma mark -- tableView
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:TextField forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        NSArray *nameArray = @[@"客户姓名",@"业务编号",@"发件节点",@"发件收件"];
        cell.name = nameArray[indexPath.row];
        cell.isInput = @"0";
        NSArray *detailsArray = @[
                                  [NSString stringWithFormat:@"%@",_model.userName],
                                  [NSString stringWithFormat:@"%@",_model.code],
                                  [NSString stringWithFormat:@"%@",[[BaseModel user]note:_model.fromNodeCode]],
                                  [NSString stringWithFormat:@"%@",[[BaseModel user]note:_model.toNodeCode]]
                                  ];
        cell.TextFidStr = detailsArray[indexPath.row];
        return cell;
    }
    if (indexPath.section == 1 || indexPath.section == 3) {
        TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:TextField forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        if (indexPath.section == 1) {
            cell.name = @"参考材料清单";
        }else
        {
            cell.name = @"寄送材料清单";
        }
        cell.isInput = @"0";
        return cell;
    }
    if (indexPath.section == 2 || indexPath.section == 4) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        UILabel *nameLabel = [UILabel labelWithFrame:CGRectMake(15, 10, SCREEN_WIDTH - 30, 40) textAligment:(NSTextAlignmentLeft) backgroundColor:BackColor font:HGfont(13) textColor:[UIColor blackColor]];
        if (indexPath.section == 2) {
            nameLabel.text = [NSString stringWithFormat:@"    %@",[BaseModel convertNull:_model.refFileList]];
        }else

        {
            nameLabel.text = [NSString stringWithFormat:@"    %@",[BaseModel convertNull:_model.sendFileList]];
        }
        kViewRadius(nameLabel, 5);
        [cell addSubview:nameLabel];
        return cell;
    }
    if (indexPath.section == 5) {
        TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:TextField forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;


        cell.isInput = @"0";
        NSArray *detailsArray;
        NSArray *nameArray;
        if ([_model.sendType isEqualToString:@"2"]) {
            nameArray = @[@"寄送方式",@"快递公司",@"快递单号",@"发货时间"];

            detailsArray = @[
                             @"快递",
                             [NSString stringWithFormat:@"%@",[[BaseModel user] setParentKey:@"kd_company" setDkey:_model.logisticsCompany]],
                             [NSString stringWithFormat:@"%@",_model.logisticsCode],
                             [NSString stringWithFormat:@"%@",[_model.sendDatetime convertToDetailDate]]
                             ];
        }else
        {
            nameArray = @[@"寄送方式",@"发货时间"];
            detailsArray = @[
                             @"线下",
                             [NSString stringWithFormat:@"%@",[_model.sendDatetime convertToDetailDate]]
                             ];
        }


        cell.name = nameArray[indexPath.row];
        cell.TextFidStr = detailsArray[indexPath.row];
        return cell;
    }
    TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:TextField forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.name = @"备注";
    cell.nameText = @"选填";
    cell.nameTextField.tag = 100;
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
    if (indexPath.section == 2 || indexPath.section == 4) {
        return 60;
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
    if (section == 6) {
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
    if (section == 6) {
        UIView *headView = [[UIView alloc]init];
        UIButton *initiateButton = [UIButton buttonWithTitle:@"收件并审核通过" titleColor:[UIColor whiteColor] backgroundColor:MainColor titleFont:18];
        initiateButton.frame = CGRectMake(15, 30, SCREEN_WIDTH/2 - 30, 50);
        kViewRadius(initiateButton, 5);
        [initiateButton addTarget:self action:@selector(confirmButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
        initiateButton.tag = 0;
        [headView addSubview:initiateButton];

        UIButton *saveButton = [UIButton buttonWithTitle:@"收件待补件" titleColor:[UIColor whiteColor] backgroundColor:MainColor titleFont:18];
        saveButton.frame = CGRectMake(SCREEN_WIDTH/2 + 15, 30, SCREEN_WIDTH/2 - 30, 50);
        kViewRadius(saveButton, 5);
        [saveButton addTarget:self action:@selector(confirmButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
        saveButton.tag = 1;
        [headView addSubview:saveButton];

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
