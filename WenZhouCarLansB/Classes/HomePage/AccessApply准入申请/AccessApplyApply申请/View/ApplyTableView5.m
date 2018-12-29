//
//  ApplyTableView5.m
//  WenZhouCarLansB
//
//  Created by QinBao Zheng on 2018/9/3.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "ApplyTableView5.h"
#import "ChooseCell.h"
#define ChooseC @"ChooseCell"

#import "TextFieldCell.h"
#define TextField @"TextFieldCell"

#import "InputBoxCell.h"
#define InputBox @"InputBoxCell"
@interface ApplyTableView5 ()<UITableViewDataSource,UITableViewDelegate>


@end
@implementation ApplyTableView5

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
    return 3;
}

#pragma mark -- 行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 2;
    }
    if (section == 1) {
        return 1;
    }
    return 4;
}

#pragma mark -- tableView
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.section == 0) {
        NSString *CellIdentifier = [NSString stringWithFormat:@"cell1%ld%ld",indexPath.section,indexPath.row];
        TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[TextFieldCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
            NSArray *detailsArray = @[
                                      [NSString stringWithFormat:@"%@",self.model.applyBirthAddress],
                                      [NSString stringWithFormat:@"%@",self.model.applyNowAddress]
                                      ];
            cell.TextFidStr = detailsArray[indexPath.row];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSArray *nameArray = @[@"*申请人户籍地",@"*现住地址"];
        cell.name = nameArray[indexPath.row];
        NSArray *placArray = @[@"请输入申请人户籍地",@"请输入现住地址"];
        cell.nameText = placArray[indexPath.row];
        cell.nameTextField.tag = 55500 + indexPath.row;
        return cell;
    }
    if (indexPath.section == 1) {
        ChooseCell *cell = [tableView dequeueReusableCellWithIdentifier:ChooseC forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.name = @"*现住房屋类型";
        NSString *houseType;
        if ([self.model.houseType isEqualToString:@"0"]) {
            houseType = @"自有";
        }else if([self.model.houseType isEqualToString:@"1"])
        {
            houseType = @"租用";
        }

        cell.details = houseType;
        return cell;
    }
    NSString *CellIdentifier = [NSString stringWithFormat:@"cell1%ld%ld",indexPath.section,indexPath.row];
    TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[TextFieldCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        NSArray *detailsArray = @[
                                  [NSString stringWithFormat:@"%@",self.model.ghBirthAddress],
                                  [NSString stringWithFormat:@"%@",self.model.guarantor1BirthAddress],
                                  [NSString stringWithFormat:@"%@",self.model.guarantor2BirthAddress],
                                  [NSString stringWithFormat:@"%@",self.model.otherNote]
                                  ];
        cell.TextFidStr = detailsArray[indexPath.row];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSArray *nameArray = @[@"共还人户籍地",@"担保人1户籍地",@"担保人2户籍地",@"其他情况说明"];
    cell.name = nameArray[indexPath.row];
    NSArray *placArray = @[@"请输入共还人户籍地",@"请输入担保人1户籍地",@"请输入担保人2户籍地",@"选填其他情况说明"];
    cell.nameText = placArray[indexPath.row];
    cell.nameTextField.tag = 55502 +indexPath.row;
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
    if (section == 2) {
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
