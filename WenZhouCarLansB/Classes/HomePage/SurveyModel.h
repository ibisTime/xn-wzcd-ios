//
//  SurveyModel.h
//  CarLoans
//
//  Created by QinBao Zheng on 2018/7/20.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SurveyModel : NSObject


@property (nonatomic , copy)NSString *curNodeCode;
@property (nonatomic , copy)NSString *teamName;
@property (nonatomic , copy)NSString *opera;
@property (nonatomic , copy)NSString *code;
@property (nonatomic , copy)NSString *updateDatetime;
@property (nonatomic , copy)NSString *saleUserName;
@property (nonatomic , copy)NSString *updaterName;
@property (nonatomic , copy)NSString *idNo;
@property (nonatomic , copy)NSString *operatorName;
@property (nonatomic , copy)NSString *loanAmount;
@property (nonatomic , copy)NSString *loanBankCode;
@property (nonatomic , copy)NSString *isCancel;
@property (nonatomic , copy)NSString *applyDatetime;
@property (nonatomic , copy)NSString *mobile;
@property (nonatomic , copy)NSString *shopWay;
@property (nonatomic , copy)NSString *budgetCode;
@property (nonatomic , copy)NSString *note;
@property (nonatomic , copy)NSString *saleUserId;
@property (nonatomic , copy)NSString *companyName;
@property (nonatomic , copy)NSString *insideJob;
@property (nonatomic , copy)NSString *userName;
@property (nonatomic , copy)NSString *teamCode;
@property (nonatomic , copy)NSString *companyCode;
@property (nonatomic , copy)NSString *loanBankName;
@property (nonatomic , strong)NSDictionary *creditUser;
@property (nonatomic , strong)NSArray *creditUserList;

@end
