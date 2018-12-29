//
//  AccessApplyTableView.m
//  WenZhouCarLansB
//
//  Created by QinBao Zheng on 2018/9/3.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "AccessApplyTableView.h"
#import "InformationCell.h"
#define Information @"InformationCell"

@interface AccessApplyTableView ()<UITableViewDataSource,UITableViewDelegate>

@end
@implementation AccessApplyTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {

    if (self = [super initWithFrame:frame style:style]) {
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[InformationCell class] forCellReuseIdentifier:Information];

    }
    return self;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

#pragma mark -- 行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return self.model.count;
}

#pragma mark -- tableView
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    InformationCell *cell = [tableView dequeueReusableCellWithIdentifier:Information forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self.model.count > 0) {
        cell.accessApplyModel = self.model[indexPath.row];
    }
    AccessApplyModel *model = self.model[indexPath.row];
    if ([model.curNodeCode isEqualToString:@"002_01"]) {
        [cell.button1 setTitle:@"外单申请" forState:(UIControlStateNormal)];
        cell.button1.hidden = NO;

        [cell.button2 setTitle:@"申请" forState:(UIControlStateNormal)];
        cell.button2.hidden = NO;

    }else
    {
        cell.button1.hidden = YES;
        cell.button2.hidden = YES;
    }
    
    [cell.button1 addTarget:self action:@selector(buttonClick1:) forControlEvents:(UIControlEventTouchUpInside)];
    cell.button1.tag = indexPath.row;
    [cell.button2 addTarget:self action:@selector(buttonClick2:) forControlEvents:(UIControlEventTouchUpInside)];
    cell.button2.tag = indexPath.row;
    return cell;
}

//添加证信人
-(void)buttonClick1:(UIButton *)sender
{

    if ([self.refreshDelegate respondsToSelector:@selector(refreshTableViewButtonClick:button:selectRowAtIndex:selectRowState:)]) {

        [self.refreshDelegate refreshTableViewButtonClick:self button:sender selectRowAtIndex:sender.tag selectRowState:@"select1"];
    }
}

//添加证信人
-(void)buttonClick2:(UIButton *)sender
{

    if ([self.refreshDelegate respondsToSelector:@selector(refreshTableViewButtonClick:button:selectRowAtIndex:selectRowState:)]) {

        [self.refreshDelegate refreshTableViewButtonClick:self button:sender selectRowAtIndex:sender.tag selectRowState:@"select2"];
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
    AccessApplyModel *model = self.model[indexPath.row];
    if ([model.curNodeCode isEqualToString:@"002_01"]) {
        return 330;
    }
    return 280;
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
