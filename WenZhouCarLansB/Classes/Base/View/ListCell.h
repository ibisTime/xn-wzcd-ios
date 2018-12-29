//
//  ListCell.h
//  WenZhouCarLansB
//
//  Created by QinBao Zheng on 2018/9/3.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SurveyModel.h"
#import "AccessSingleModel.h"
@interface ListCell : UITableViewCell

@property (nonatomic , strong)UIButton *button;

@property (nonatomic , strong)UILabel *codeLabel;

@property (nonatomic , strong)UILabel *stateLabel;

@property (nonatomic , strong)UILabel *nameLabel;

@property (nonatomic , strong)UILabel *InformationLabel;

@property (nonatomic , strong)SurveyModel *surveyModel;

@property (nonatomic , strong)AccessSingleModel *accessSingleModel;

@end
