//
//  SurveyTableView.h
//  CarLoans
//
//  Created by QinBao Zheng on 2018/7/18.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "TLTableView.h"
#import "SurveyModel.h"


@protocol SurveyDelegate <NSObject>

-(void)selectButtonClick:(NSInteger)index;

@end

@interface SurveyTableView : TLTableView

@property (nonatomic, assign) id <SurveyDelegate> selectDelegate;

@property (nonatomic , strong)NSMutableArray <SurveyModel *>*model;

@end
