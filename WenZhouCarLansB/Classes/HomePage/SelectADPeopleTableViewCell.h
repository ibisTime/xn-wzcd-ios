//
//  SelectADPeopleTableViewCell.h
//  WenZhouCarLansB
//
//  Created by QinBao Zheng on 2018/9/11.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SurveyDetailsModel.h"
@protocol SelectADPeopleDelegate <NSObject>

-(void)SelectADPeopleTableViewCellButton:(UIButton *)sender;

-(void)ChooseButton:(UIButton *)sender;

@end
@interface SelectADPeopleTableViewCell : UITableViewCell


@property (nonatomic, assign) id <SelectADPeopleDelegate> Delegate;

@property (nonatomic , strong)SurveyDetailsModel *model;

@end
