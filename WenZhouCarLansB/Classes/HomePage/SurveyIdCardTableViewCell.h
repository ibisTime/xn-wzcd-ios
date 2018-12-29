//
//  SurveyIdCardTableViewCell.h
//  CarLoans
//
//  Created by QinBao Zheng on 2018/7/31.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SurvuyPeopleModel.h"
@interface SurveyIdCardTableViewCell : UITableViewCell

@property (nonatomic , strong)UILabel *nameLbl;

@property (nonatomic , strong)UIButton *photoBtn;

@property (nonatomic , strong)SurvuyPeopleModel *model;



@end
