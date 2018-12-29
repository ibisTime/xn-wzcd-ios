//
//  SurveyTableView.m
//  CarLoans
//
//  Created by QinBao Zheng on 2018/7/18.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "SurveyTableView.h"
#import "ListCell.h"
#define List @"ListCell"
#import "SurveyACreditVC.h"

@interface SurveyTableView ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation SurveyTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {

    if (self = [super initWithFrame:frame style:style]) {
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[ListCell class] forCellReuseIdentifier:List];

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
    ListCell *cell = [tableView dequeueReusableCellWithIdentifier:List forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self.model.count > 0) {
        cell.surveyModel = self.model[indexPath.row];
    }
    if ([self.model[indexPath.row].curNodeCode isEqualToString:@"001_03"]) {
        [cell.button setTitle:@"征信初审" forState:(UIControlStateNormal)];
        cell.button.hidden = NO;
    }else{
        cell.button.hidden = YES;
    }
//    SurveyModel *model = self.model[indexPath.row];
//    if ([model.curNodeCode isEqualToString:@"001_05"] || [model.curNodeCode isEqualToString:@"001_01"] || [model.curNodeCode isEqualToString:@"001_07"]) {
//        [cell.button setTitle:@"修改征信信息" forState:(UIControlStateNormal)];
//        cell.button.hidden = NO;
//    }else if ([model.curNodeCode isEqualToString:@"001_02"]) {
//        [cell.button setTitle:@"撤回" forState:(UIControlStateNormal)];
//        cell.button.hidden = NO;
//    }else
//    {
//        cell.button.hidden = YES;
//    }
    [cell.button addTarget:self action:@selector(buttonClick:) forControlEvents:(UIControlEventTouchUpInside)];
    cell.button.tag = indexPath.row;
    return cell;
}

//添加证信人
-(void)buttonClick:(UIButton *)sender
{

    if ([self.refreshDelegate respondsToSelector:@selector(refreshTableViewButtonClick:button:selectRowAtIndex:)]) {

        [self.refreshDelegate refreshTableViewButtonClick:self button:sender selectRowAtIndex:sender.tag];
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
    if ([self.model[indexPath.row].curNodeCode isEqualToString:@"001_03"])
    {
        return 295;
    }
    return 245;
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
