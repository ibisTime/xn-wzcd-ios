//
//  ApplyTableView4.m
//  WenZhouCarLansB
//
//  Created by QinBao Zheng on 2018/9/3.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "ApplyTableView4.h"
#import "ChooseCell.h"
#define ChooseC @"ChooseCell"

#import "TextFieldCell.h"
#define TextField @"TextFieldCell"

#import "InputBoxCell.h"
#define InputBox @"InputBoxCell"
@interface ApplyTableView4 ()<UITableViewDataSource,UITableViewDelegate>


@end
@implementation ApplyTableView4

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
    return 2;
}

#pragma mark -- 行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 3;
}

#pragma mark -- tableView
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.row == 0) {
        NSString *CellIdentifier = [NSString stringWithFormat:@"cell1%ld%ld",indexPath.section,indexPath.row];
        TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[TextFieldCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
            NSArray *detailsArray = @[
                                      [NSString stringWithFormat:@"%@",self.model.emergencyName1],
                                      [NSString stringWithFormat:@"%@",self.model.emergencyName2]
                                      ];
            cell.TextFidStr = detailsArray[indexPath.section];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSArray *nameArray = @[@"*联系人1姓名",@"联系人2姓名"];
        cell.name = nameArray[indexPath.section];
        cell.nameText = @"请输入联系人姓名";
        if (indexPath.section == 0) {
            cell.nameTextField.tag = 44400;
        }else
        {
            cell.nameTextField.tag = 44402;
        }
        return cell;
    }
    if (indexPath.row == 1) {
        ChooseCell *cell = [tableView dequeueReusableCellWithIdentifier:ChooseC forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSArray *nameArray =@[@"*与申请人关系",@"与申请人关系"];
        cell.name = nameArray[indexPath.section];
        if (indexPath.section == 0) {
            cell.details = [NSString stringWithFormat:@"%@",[[BaseModel user]setParentKey:@"emergency_contact_relation" setDkey:self.model.emergencyRelation1]];
        }else
        {
            cell.details = [NSString stringWithFormat:@"%@",[[BaseModel user]setParentKey:@"emergency_contact_relation" setDkey:self.model.emergencyRelation2]];
        }
        
        return cell;
    }

    NSString *CellIdentifier = [NSString stringWithFormat:@"cell1%ld%ld",indexPath.section,indexPath.row];
    TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[TextFieldCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        NSArray *detailsArray = @[
                                  [NSString stringWithFormat:@"%@",self.model.emergencyMobile1],
                                  [NSString stringWithFormat:@"%@",self.model.emergencyMobile2]
                                  ];
        cell.TextFidStr = detailsArray[indexPath.section];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSArray *nameArray = @[@"*手机号码",@"手机号码"];
    cell.name = nameArray[indexPath.section];
    cell.nameText = @"请输入手机号码";
    if (indexPath.section == 0) {
        cell.nameTextField.tag = 44401;
    }else
    {
        cell.nameTextField.tag = 44403;
    }
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
    if (section == 1) {
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
