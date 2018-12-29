//
//  CreditReportingPersonInformationCell.h
//  CarLoans
//
//  Created by QinBao Zheng on 2018/7/31.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SurveyDetailsModel.h"
@protocol CreditReportingPersonInformationDelegate <NSObject>

-(void)CreditReportingPersonInformationButton:(UIButton *)sender;

@end

@interface CreditReportingPersonInformationCell : UITableViewCell

@property (nonatomic, assign) id <CreditReportingPersonInformationDelegate> Delegate;

@property (nonatomic , strong)SurveyDetailsModel *model;

@end
