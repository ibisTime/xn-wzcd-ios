//
//  SurveyDetailsTableView.h
//  CarLoans
//
//  Created by QinBao Zheng on 2018/7/31.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "TLTableView.h"
#import "SurveyModel.h"
#import "SurveyDetailsModel.h"
@interface SurveyDetailsTableView : TLTableView

//@property (nonatomic , strong)SurveyModel *model;
@property (nonatomic , strong)SurveyDetailsModel *surveyDetailsModel;
@end
