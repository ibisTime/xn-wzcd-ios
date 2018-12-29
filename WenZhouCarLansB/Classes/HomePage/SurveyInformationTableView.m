//
//  SurveyInformationTableView.m
//  CarLoans
//
//  Created by QinBao Zheng on 2018/7/31.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "SurveyInformationTableView.h"
#import "TextFieldCell.h"
#define TextField @"TextFieldCell"
#import "SurveyIdCardTableViewCell.h"
#define SurveyIdCardTableView @"SurveyIdCardTableViewCell"
#import "SurverCertificateCell.h"
#define SurverCertificate @"SurverCertificateCell"
#import "UploadSingleImageCell.h"
#define UploadSingleImage @"UploadSingleImageCell"
@interface SurveyInformationTableView ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation SurveyInformationTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {

    if (self = [super initWithFrame:frame style:style]) {
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[TextFieldCell class] forCellReuseIdentifier:TextField];
        [self registerClass:[SurveyIdCardTableViewCell class] forCellReuseIdentifier:SurveyIdCardTableView];
        [self registerClass:[SurverCertificateCell class] forCellReuseIdentifier:SurverCertificate];
        [self registerClass:[UploadSingleImageCell class] forCellReuseIdentifier:UploadSingleImage];



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

    if (section == 1) {
        return 5;
    }
    if (section == 2) {
        return 2;
    }
    return 1;
}

#pragma mark -- tableView
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        SurveyIdCardTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SurveyIdCardTableView forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = _model;
        cell.nameLbl.text = @"身份证";
        return cell;
    }
    if (indexPath.section == 1) {
        TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:TextField forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSArray *nameArray = @[@"姓名",@"手机号",@"贷款角色",@"与借款人关系",@"身份证号"];
        cell.name = nameArray[indexPath.row];
        cell.isInput = @"0";
        NSArray *detailsArray = @[
                 [NSString stringWithFormat:@"%@",_model.userName],
                 [NSString stringWithFormat:@"%@",_model.mobile],
                 [[BaseModel user] setParentKey:@"credit_user_loan_role" setDkey:_model.loanRole],
                 [[BaseModel user] setParentKey:@"credit_user_relation" setDkey:_model.relation],
                 [NSString stringWithFormat:@"%@",_model.idNo]
                 ];
        cell.TextFidStr = detailsArray[indexPath.row];
        return cell;
    }

    UploadSingleImageCell *cell = [tableView dequeueReusableCellWithIdentifier:UploadSingleImage forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSArray *nameArray = @[@"证书查询授权书",@"面签照片"];
    cell.nameLbl.text=nameArray[indexPath.row];
    NSArray *array = @[_model.authPdf,_model.interviewPic];
    cell.imgStr = array[indexPath.row];
    return cell;
}

-(void)CreditReportingPersonInformationButton:(UIButton *)sender
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
    if (indexPath.section == 0 || indexPath.section == 2) {
        return SCREEN_WIDTH/3 + 70;
    }
//    if (indexPath.section == 2) {
//        if (indexPath.row == 0) {
//            if (_model.pics1.count == 0) {
//                return 50;
//            }else
//            {
//                UIButton *button = [self viewWithTag:_model.pics1.count - 1 + 10000];
//                return button.frame.origin.y + 10 + button.frame.size.height + 15;
//            }
//        }else
//        {
//            if (_model.pics2.count == 0) {
//                return 50;
//            }else
//            {
//                UIButton *button = [self viewWithTag:_model.pics2.count - 1 + 10000];
//                return button.frame.origin.y + 10 + button.frame.size.height + 15;
//            }
//        }
//    }
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
