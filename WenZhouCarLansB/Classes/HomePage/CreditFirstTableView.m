//
//  CreditFirstTableView.m
//  WenZhouCarLansB
//
//  Created by QinBao Zheng on 2018/9/11.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "CreditFirstTableView.h"

#import "TextFieldCell.h"
#define TextField @"TextFieldCell"
#define TextField1 @"TextFieldCell1"

#import "SelectADPeopleTableViewCell.h"
#define SelectADPeopleTableView @"SelectADPeopleTableViewCell"

#import "SurverCertificateCell.h"
#define SurverCertificate @"SurverCertificateCell"
#import "UsedCarInformationCell.h"
#define UsedCarInformation @"UsedCarInformationCell"

#import "CollectionViewCell.h"
#define CollectionView @"CollectionViewCell"

@interface CreditFirstTableView ()<UITableViewDataSource,UITableViewDelegate,SelectADPeopleDelegate,CustomCollectionDelegate>

@end

@implementation CreditFirstTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {

    if (self = [super initWithFrame:frame style:style]) {
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[TextFieldCell class] forCellReuseIdentifier:TextField];
        [self registerClass:[TextFieldCell class] forCellReuseIdentifier:TextField1];
        [self registerClass:[SelectADPeopleTableViewCell class] forCellReuseIdentifier:SelectADPeopleTableView];
        [self registerClass:[SurverCertificateCell class] forCellReuseIdentifier:SurverCertificate];
        [self registerClass:[UsedCarInformationCell class] forCellReuseIdentifier:UsedCarInformation];
        [self registerClass:[CollectionViewCell class] forCellReuseIdentifier:CollectionView];
        [self registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    }
    return self;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([_surveyDetailsModel.shopWay integerValue] == 1) {
        return 5;
    }else
    {
        return 6;
    }

}

#pragma mark -- 行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    if (section == 0) {
        return 3;
    }
    if ([_surveyDetailsModel.shopWay integerValue] == 1) {
        return 1;
    }else
    {

        return 1;
    }
}

#pragma mark -- tableView
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:TextField forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSArray *nameArray = @[@"银行",@"业务种类",@"贷款金额"];
        cell.name = nameArray[indexPath.row];
        cell.isInput = @"0";
        NSString *shopWay;
        if ([_surveyDetailsModel.shopWay integerValue] == 1) {
            shopWay = @"新车";
        }
        else
        {
            shopWay = @"二手车";
        }
        NSArray *detailsArray = @[
                                  [NSString stringWithFormat:@"%@",_surveyDetailsModel.loanBankName],
                                  [NSString stringWithFormat:@"%@",shopWay],
                                  [NSString stringWithFormat:@"%.2f   ¥",[_surveyDetailsModel.loanAmount floatValue]/1000]
                                  ];
        cell.TextFidStr = detailsArray[indexPath.row];
        return cell;
    }
    if ([_surveyDetailsModel.shopWay integerValue] == 1) {
        //        新车
        if (indexPath.section == 1) {
            TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:TextField forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.name = @"征信人";
            cell.isInput = @"0";
            cell.TextFidStr = @"";
            return cell;
        }
        if (indexPath.section == 2) {
            SelectADPeopleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SelectADPeopleTableView forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.Delegate = self;
            if (self.surveyDetailsModel.creditUserList > 0) {
                cell.model = self.surveyDetailsModel;
            }
            return cell;
        }
        if (indexPath.section == 3) {
            TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:TextField1 forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.name = @"*审核意见";
            cell.nameText = @"必填";
            cell.nameTextField.tag = 1212;
            return cell;
        }
        CollectionViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CollectionView forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.collectDataArray = self.imageArray;
        cell.delegate = self;

        return cell;
    }
    else
    {
        //        二手车
        if (indexPath.section == 1) {
            UsedCarInformationCell *cell = [tableView dequeueReusableCellWithIdentifier:UsedCarInformation forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.name = @"二手车评估报告";
            cell.picArray = @[
                              [NSString stringWithFormat:@"%@",self.surveyDetailsModel.xszFront],
                              [NSString stringWithFormat:@"%@",self.surveyDetailsModel.xszReverse]
                              ];
            return cell;
        }
        if (indexPath.section == 2) {
            TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:TextField forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.name = @"征信人";
            cell.isInput = @"0";
            cell.TextFidStr = @"";
            return cell;
        }
        if (indexPath.section == 3) {
            SelectADPeopleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SelectADPeopleTableView forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.Delegate = self;
            if (self.surveyDetailsModel.creditUserList > 0) {
                cell.model = self.surveyDetailsModel;
            }
            return cell;
        }

        if (indexPath.section == 4) {
            TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:TextField1 forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.name = @"*审核意见";
            cell.nameText = @"必填";

            cell.nameTextField.tag = 1212;
            return cell;
        }

        CollectionViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CollectionView forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.collectDataArray = self.imageArray;
        cell.delegate = self;
        return cell;
    }


}

-(void)appraisalReportBtnClick
{

}

-(void)SelectADPeopleTableViewCellButton:(UIButton *)sender
{
    if ([self.refreshDelegate respondsToSelector:@selector(refreshTableViewButtonClick:button:selectRowAtIndex:)]) {
        [self.refreshDelegate refreshTableViewButtonClick:self button:sender selectRowAtIndex:sender.tag];
    }
}

-(void)ChooseButton:(UIButton *)sender
{
    if ([self.refreshDelegate respondsToSelector:@selector(refreshTableViewButtonClick:button:selectRowAtIndex:selectRowState:)]) {
        [self.refreshDelegate refreshTableViewButtonClick:self button:sender selectRowAtIndex:sender.tag selectRowState:@"choose"];

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

    if ([_surveyDetailsModel.shopWay integerValue] == 1) {
        if (indexPath.section == 2) {
            return 30 + 135 * self.surveyDetailsModel.creditUserList.count + (self.surveyDetailsModel.creditUserList.count - 1) * 10 ;
        }
        if (indexPath.section == 4) {
            float numberToRound;
            int result;
            numberToRound = (self.imageArray.count + 1.0)/3.0;
            result = (int)ceilf(numberToRound);
            return result * ((SCREEN_WIDTH - 50)/3 + 10) + 20;
        }
        return 50;
    }else
    {
        if (indexPath.section == 1) {
            return 50 + SCREEN_WIDTH/3 + 15;
        }
        if (indexPath.section == 3) {
            return 30 + 135 * self.surveyDetailsModel.creditUserList.count + (self.surveyDetailsModel.creditUserList.count - 1) * 10;
        }
        if (indexPath.section == 5) {
            float numberToRound;
            int result;
            numberToRound = (self.imageArray.count + 1.0)/3.0;
            result = (int)ceilf(numberToRound);
            return result * ((SCREEN_WIDTH - 50)/3 + 10) + 20;
        }
        
        return 50;
    }

}

//添加
-(void)CustomCollection:(UICollectionView *)collectionView didSelectRowAtIndexPath:(NSIndexPath *)indexPath str:(NSString *)str
{
    if ([self.refreshDelegate respondsToSelector:@selector(refreshTableViewButtonClick:button:selectRowAtIndex:selectRowState:)]) {
        [self.refreshDelegate refreshTableViewButtonClick:self button:nil selectRowAtIndex:[str integerValue] selectRowState:@"add"];

    }
}

//删除
-(void)UploadImagesBtn:(UIButton *)sender str:(NSString *)str
{
    if ([self.refreshDelegate respondsToSelector:@selector(refreshTableViewButtonClick:button:selectRowAtIndex:selectRowState:)]) {

        [self.refreshDelegate refreshTableViewButtonClick:self button:sender selectRowAtIndex:sender.tag selectRowState:str];
    }

}

#pragma mark -- 区头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return 10;
    }
    if ([_surveyDetailsModel.shopWay integerValue] == 1) {

        if (section == 4) {
            return 50;
        }
    }else
    {
        if (section == 5) {
            return 50;
        }
    }
    return 0.01;
}

#pragma mark -- 区尾高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if ([_surveyDetailsModel.shopWay integerValue] == 1) {

        if (section == 4) {
            return 100;
        }
    }else
    {
        if (section == 5) {
            return 100;
        }
    }
    return 0.01;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{

    if ([_surveyDetailsModel.shopWay integerValue] == 1) {

        if (section == 4) {
            UIView *headView = [[UIView alloc]init];

            UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
            backView.backgroundColor = [UIColor whiteColor];
            [headView addSubview:backView];

            UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
            lineView.backgroundColor = LineBackColor;
            [headView addSubview:lineView];
            UILabel *nameLabel = [UILabel labelWithFrame:CGRectMake(15, 0, SCREEN_WIDTH, 50) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(14) textColor:[UIColor blackColor]];
            nameLabel.text = @"附件";
            [headView addSubview:nameLabel];

            return headView;
        }
    }else
    {
        if (section == 5) {
            UIView *headView = [[UIView alloc]init];

            UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
            backView.backgroundColor = [UIColor whiteColor];
            [headView addSubview:backView];

            UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
            lineView.backgroundColor = LineBackColor;
            [headView addSubview:lineView];
            UILabel *nameLabel = [UILabel labelWithFrame:CGRectMake(15, 0, SCREEN_WIDTH, 50) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(14) textColor:[UIColor blackColor]];
            nameLabel.text = @"附件";
            [headView addSubview:nameLabel];

            return headView;
        }
    }
    return nil;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{

    if ([_surveyDetailsModel.shopWay integerValue] == 1) {

        if (section == 4) {
            UIView *headView = [[UIView alloc]init];


            UIButton *initiateButton = [UIButton buttonWithTitle:@"通过" titleColor:[UIColor whiteColor] backgroundColor:MainColor titleFont:18];
            initiateButton.frame = CGRectMake(15, 30, SCREEN_WIDTH/2 - 30, 50);
            kViewRadius(initiateButton, 5);
            [initiateButton addTarget:self action:@selector(confirmButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
            initiateButton.tag = 10000;
            [headView addSubview:initiateButton];

            UIButton *initiateButton1 = [UIButton buttonWithTitle:@"不通过" titleColor:[UIColor whiteColor] backgroundColor:MainColor titleFont:18];
            initiateButton1.frame = CGRectMake(SCREEN_WIDTH/2 +  15, 30, SCREEN_WIDTH/2 - 30, 50);
            kViewRadius(initiateButton1, 5);
            [initiateButton1 addTarget:self action:@selector(confirmButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
            initiateButton1.tag = 10001;
            [headView addSubview:initiateButton1];


            return headView;
        }
    }else
    {
        if (section == 5) {
            UIView *headView = [[UIView alloc]init];


            UIButton *initiateButton = [UIButton buttonWithTitle:@"通过" titleColor:[UIColor whiteColor] backgroundColor:MainColor titleFont:18];
            initiateButton.frame = CGRectMake(15, 30, SCREEN_WIDTH/2 - 30, 50);
            kViewRadius(initiateButton, 5);
            [initiateButton addTarget:self action:@selector(confirmButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
            initiateButton.tag = 10000;
            [headView addSubview:initiateButton];

            UIButton *initiateButton1 = [UIButton buttonWithTitle:@"不通过" titleColor:[UIColor whiteColor] backgroundColor:MainColor titleFont:18];
            initiateButton1.frame = CGRectMake(SCREEN_WIDTH/2 +  15, 30, SCREEN_WIDTH/2 - 30, 50);
            kViewRadius(initiateButton1, 5);
            [initiateButton1 addTarget:self action:@selector(confirmButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
            initiateButton1.tag = 10001;
            [headView addSubview:initiateButton1];


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
