//
//  SurveyPeopleTableViewCell.m
//  CarLoans
//
//  Created by QinBao Zheng on 2018/7/17.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "SurveyPeopleTableViewCell.h"

@implementation SurveyPeopleTableViewCell

-(UILabel *)nameLbl
{
    if (!_nameLbl) {
        _nameLbl = [UILabel labelWithFrame:CGRectMake(15, 0, 100, 40) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(14) textColor:[UIColor blackColor]];
    }
    return _nameLbl;
}

-(UIButton *)photoBtn
{
    if (!_photoBtn) {
        _photoBtn = [UIButton buttonWithTitle:@"" titleColor:[UIColor blackColor] backgroundColor:BackColor titleFont:13];
        _photoBtn.frame = CGRectMake(15, 60, SCREEN_WIDTH - 30, 135);
        [_photoBtn setTitleColor:GaryTextColor forState:(UIControlStateNormal)];
        _photoBtn.tag = 102;
        kViewBorderRadius(_photoBtn, 5, 1, HGColor(230, 230, 230));
    }
    return _photoBtn;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.nameLbl];
        [self addSubview:self.photoBtn];

        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 49, SCREEN_WIDTH, 1)];
        lineView.backgroundColor = LineBackColor;
        [self addSubview:lineView];

        UIView *lineView1 = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_WIDTH/3 + 79, SCREEN_WIDTH, 1)];
        lineView1.backgroundColor = LineBackColor;
        [self addSubview:lineView1];

    }
    return self;
}

-(void)setName:(NSString *)name
{
    _nameLbl.text = name;
}

-(void)setBtnStr:(NSString *)btnStr
{
    [_photoBtn setTitle:btnStr forState:(UIControlStateNormal)];
    [_photoBtn SG_imagePositionStyle:(SGImagePositionStyleTop) spacing:10 imagePositionBlock:^(UIButton *button) {
        [button setImage:[UIImage imageNamed:@"添加"] forState:(UIControlStateNormal)];
    }];
}

-(void)setPeopleArray:(NSArray *)peopleArray
{

    NSArray *nameArray = @[@"姓    名:",
                           @"手机号:",
                           @"身份证:",
                           @"角    色:",
                           @"关    系:"];
    for (int i = 0; i < peopleArray.count; i ++ ) {



        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(15, 60 + i % peopleArray.count * 145, SCREEN_WIDTH - 30, 135)];
        backView.backgroundColor = BackColor;
        kViewBorderRadius(backView, 2, 1, HGColor(230, 230, 230));
        [self addSubview:backView];

        for (int j = 0; j < 5; j ++) {
            UILabel *nameLabel = [UILabel labelWithFrame:CGRectMake(15, 10 + j%5*25, 60, 15) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(13) textColor:GaryTextColor];
            nameLabel.text = nameArray[j];
            [backView addSubview:nameLabel];

            UILabel *informationLabel = [[UILabel alloc]initWithFrame:CGRectMake(75, 10+j%5*25, SCREEN_WIDTH - 120, 15) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(13) textColor:TextColor];
            NSArray *detailsArray = @[
                                      [NSString stringWithFormat:@"%@",peopleArray[i][@"userName"]],
                                      [NSString stringWithFormat:@"%@",peopleArray[i][@"mobile"]],
                                      [NSString stringWithFormat:@"%@",peopleArray[i][@"idNo"]],
                                      [[BaseModel user] setParentKey:@"credit_user_loan_role" setDkey:peopleArray[i][@"loanRole"]],
                                      [[BaseModel user] setParentKey:@"credit_user_relation" setDkey:peopleArray[i][@"relation"]]
                                      ];
            informationLabel.text = detailsArray[j];
            [backView addSubview:informationLabel];
        }

        UIButton *backButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        backButton.frame = CGRectMake(15, 60 + i % peopleArray.count * 145, SCREEN_WIDTH - 30, 135);
        [backButton addTarget:self action:@selector(backButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
        backButton.tag = 1234 + i;
        [self addSubview:backButton];



    }

    _photoBtn.frame = CGRectMake(15, 60 + peopleArray.count * 145, SCREEN_WIDTH - 30, 135);
}

-(void)setGPSArray:(NSArray *)GPSArray
{
    NSArray *nameArray = @[@"设备号:",
                           @"位    置:",
                           @"时    间:",
                           @"人    员:"
                           ];
    for (int i = 0; i < GPSArray.count; i ++ ) {

        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(15, 60 + i % GPSArray.count * 145, SCREEN_WIDTH - 30, 135)];
        backView.backgroundColor = BackColor;
        kViewBorderRadius(backView, 2, 1, HGColor(230, 230, 230));
        [self addSubview:backView];

        for (int j = 0; j < 4; j ++) {
            UILabel *nameLabel = [UILabel labelWithFrame:CGRectMake(15, 15 + j%5*30, 60, 15) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(13) textColor:GaryTextColor];
            nameLabel.text = nameArray[j];
            [backView addSubview:nameLabel];

            UILabel *informationLabel = [[UILabel alloc]initWithFrame:CGRectMake(75, 15+j%5*30, SCREEN_WIDTH - 120, 15) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(13) textColor:TextColor];
            NSArray *detailsArray = @[
                                      [NSString stringWithFormat:@"%@",GPSArray[i][@"gpsDevNo"]],
                                      [NSString stringWithFormat:@"%@",GPSArray[i][@"dic"][@"azLocation"]],
                                      [NSString stringWithFormat:@"%@",GPSArray[i][@"dic"][@"azDatetime"]],
                                      [NSString stringWithFormat:@"%@",GPSArray[i][@"dic"][@"azUser"]]
                                      ];
            informationLabel.text = detailsArray[j];
            [backView addSubview:informationLabel];
        }

        UIButton *backButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        backButton.frame = CGRectMake(15, 60 + i % GPSArray.count * 145, SCREEN_WIDTH - 30, 135);
        [backButton addTarget:self action:@selector(backButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
        backButton.tag = 1234 + i;
        [self addSubview:backButton];

        UIButton *deleteBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        deleteBtn.frame = CGRectMake(SCREEN_WIDTH - 45, 60 + i % GPSArray.count * 145, 30, 30);
        [deleteBtn addTarget:self action:@selector(backButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
        deleteBtn.tag = 12345 + i;
        [deleteBtn setImage:HGImage(@"删除") forState:(UIControlStateNormal)];
//        deleteBtn.backgroundColor = [UIColor redColor];
        [self addSubview:deleteBtn];
    }
    _photoBtn.frame = CGRectMake(15, 60 + GPSArray.count * 145, SCREEN_WIDTH - 30, 135);
}

//-(void)setDetalisModel:(GPSInstallationDetailsModel *)detalisModel
//{
//    NSArray *nameArray = @[@"设备号:",
//                           @"位    置:",
//                           @"时    间:",
//                           @"人    员:"
//                           ];
//    for (int i = 0; i < detalisModel.budgetOrderGpsList.count; i ++ ) {
//
//        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(15, 60 + i % detalisModel.budgetOrderGpsList.count * 145, SCREEN_WIDTH - 30, 135)];
//        backView.backgroundColor = BackColor;
//        kViewBorderRadius(backView, 2, 1, HGColor(230, 230, 230));
//        [self addSubview:backView];
//
//        for (int j = 0; j < 4; j ++) {
//            UILabel *nameLabel = [UILabel labelWithFrame:CGRectMake(15, 15 + j%5*30, 60, 15) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(13) textColor:GaryTextColor];
//            nameLabel.text = nameArray[j];
//            [backView addSubview:nameLabel];
//
//            UILabel *informationLabel = [[UILabel alloc]initWithFrame:CGRectMake(75, 15+j%5*30, SCREEN_WIDTH - 120, 15) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(13) textColor:TextColor];
//            NSArray *detailsArray = @[
//                                      [NSString stringWithFormat:@"%@",detalisModel.budgetOrderGpsList[i][@"gpsDevNo"]],
//                                      [NSString stringWithFormat:@"%@",detalisModel.budgetOrderGpsList[i][@"azLocation"]],
//                                      [NSString stringWithFormat:@"%@",detalisModel.budgetOrderGpsList[i][@"azDatetime"]],
//                                      [NSString stringWithFormat:@"%@",detalisModel.budgetOrderGpsList[i][@"azUser"]]
//                                      ];
//            informationLabel.text = detailsArray[j];
//            [backView addSubview:informationLabel];
//        }
//        UIButton *backButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
//        backButton.frame = CGRectMake(15, 60 + i % detalisModel.budgetOrderGpsList.count * 145, SCREEN_WIDTH - 30, 135);
//        [backButton addTarget:self action:@selector(backButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
//        backButton.tag = 1234 + i;
//        [self addSubview:backButton];
//    }
//    _photoBtn.hidden = YES;
//}
//
//-(void)setModel:(GPSInstallationModel *)model
//{
//
//}

-(void)backButtonClick:(UIButton *)sender
{
    [_delegate SurveyPeopleSelectButton:sender];
}

@end
