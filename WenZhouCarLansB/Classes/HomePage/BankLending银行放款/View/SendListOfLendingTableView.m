//
//  SendListOfLendingTableView.m
//  WenZhouCarLansB
//
//  Created by QinBao Zheng on 2018/9/14.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "SendListOfLendingTableView.h"
#import "TextFieldCell.h"
#define TextField @"TextFieldCell"
#import "UploadSingleImageCell.h"
#define UploadSingleImage @"UploadSingleImageCell"
@interface SendListOfLendingTableView ()<UITableViewDataSource,UITableViewDelegate>

@end
@implementation SendListOfLendingTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {

    if (self = [super initWithFrame:frame style:style]) {
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[TextFieldCell class] forCellReuseIdentifier:TextField];
        [self registerClass:[UploadSingleImageCell class] forCellReuseIdentifier:UploadSingleImage];


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
        return 3;
    }
    return 1;
}

#pragma mark -- tableView
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:TextField forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        NSArray *nameArray = @[@"姓名",@"*对账单日",@"*银行还款日"];
        cell.name = nameArray[indexPath.row];
        if (indexPath.row == 0) {
            cell.TextFidStr = [NSString stringWithFormat:@"%@",self.model.customerName];
        }else
        {
            NSArray *array = @[@"",@"请输入对账单日",@"请输入银行还款日"];
            cell.nameText = array[indexPath.row];

        }
        cell.nameTextField.tag = 1099 + indexPath.row;
        return cell;
    }

    UploadSingleImageCell *cell = [tableView dequeueReusableCellWithIdentifier:UploadSingleImage forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.uploadStr = @"*已放款名单图片";
    [cell.photoBtn addTarget:self action:@selector(photoBtnCick:) forControlEvents:(UIControlEventTouchUpInside)];
    cell.photoBtn.tag = indexPath.row + 100;
    cell.uploadPhoto = _imageData;
    return cell;
}

-(void)photoBtnCick:(UIButton *)sender
{
    if ([self.refreshDelegate respondsToSelector:@selector(refreshTableViewButtonClick:button:selectRowAtIndex:selectRowState:)]) {

        [self.refreshDelegate refreshTableViewButtonClick:self button:sender selectRowAtIndex:sender.tag selectRowState:@"add"];

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
    if (indexPath.section == 1) {
        return SCREEN_WIDTH/3 + 70;
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
        [confirmButton setTitle:@"确认" forState:(UIControlStateNormal)];
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
