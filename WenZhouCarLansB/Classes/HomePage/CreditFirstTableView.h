//
//  CreditFirstTableView.h
//  WenZhouCarLansB
//
//  Created by QinBao Zheng on 2018/9/11.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "TLTableView.h"
#import "SurveyDetailsModel.h"
@interface CreditFirstTableView : TLTableView

@property (nonatomic , strong)SurveyDetailsModel *surveyDetailsModel;

@property (nonatomic , strong)NSArray *imageArray;

@end
