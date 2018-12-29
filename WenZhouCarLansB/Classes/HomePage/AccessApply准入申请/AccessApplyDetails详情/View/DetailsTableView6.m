//
//  DetailsTableView6.m
//  WenZhouCarLansB
//
//  Created by QinBao Zheng on 2018/9/11.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "DetailsTableView6.h"

#define ChooseC @"ChooseCell"

#import "TextFieldCell.h"
#define TextField @"TextFieldCell"

#import "InputBoxCell.h"
#define InputBox @"InputBoxCell"
@interface DetailsTableView6 ()<UITableViewDataSource,UITableViewDelegate>


@end
@implementation DetailsTableView6

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {

    if (self = [super initWithFrame:frame style:style]) {
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[TextFieldCell class] forCellReuseIdentifier:ChooseC];
        [self registerClass:[TextFieldCell class] forCellReuseIdentifier:TextField];
        [self registerClass:[InputBoxCell class] forCellReuseIdentifier:InputBox];
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
    if (section == 4) {
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
        NSArray *nameArray = @[@"*油补公里数"];
        cell.name = nameArray[indexPath.row];
        cell.isInput = @"0";
        cell.TextFidStr = self.model.oilSubsidyKil;
        cell.nameTextField.tag = 66600;
        return cell;
    }
    if (indexPath.section == 1) {
        InputBoxCell *cell = [tableView dequeueReusableCellWithIdentifier:InputBox forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.name = @"油补";
        cell.detailsStr = [NSString stringWithFormat:@"%.2f",[self.model.oilSubsidy floatValue]/1000];
        cell.nameTextField.tag = 66601;
        cell.isInput = @"0";
        return cell;
    }
    if (indexPath.section ==2) {
        TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:ChooseC forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.name = @"*我司续保";
        cell.isInput = @"0";
        cell.TextFidStr = [self WhetherOrNot:self.model.isPlatInsure];
        return cell;
    }
    if (indexPath.section == 3) {
        InputBoxCell *cell = [tableView dequeueReusableCellWithIdentifier:InputBox forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.name = @"GPS提成";
        cell.nameTextField.tag = 66602;
        cell.isInput = @"0";
        cell.detailsStr = [NSString stringWithFormat:@"%.2f",[self.model.gpsDeduct floatValue]/1000];
        return cell;
    }
    TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:ChooseC forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSArray *nameArray = @[@"GPS收费方式",@"收客户手续费收取方式"];
    cell.name = nameArray[indexPath.row];
    cell.isInput = @"0";
    NSArray *detailsArray = @[
                              [[BaseModel user]setParentKey:@"gps_fee_way" setDkey:self.model.gpsFeeWay],
                              [[BaseModel user]setParentKey:@"fee_way" setDkey:self.model.bocFeeWay]
                              ];
    cell.TextFidStr = detailsArray[indexPath.row];
    return cell;


}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.refreshDelegate respondsToSelector:@selector(refreshTableView:didSelectRowAtIndexPath:)]) {
        [self.refreshDelegate refreshTableView:self didSelectRowAtIndexPath:indexPath];
    }
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
