//
//  SurveyDetailsModel.h
//  CarLoans
//
//  Created by QinBao Zheng on 2018/7/31.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SurveyDetailsModel : NSObject
@property (nonatomic , copy)NSString *xszReverse;
@property (nonatomic , copy)NSString *xszFront;
@property (nonatomic , copy)NSString *shopWay;
@property (nonatomic , copy)NSString *loanBankName;
@property (nonatomic , copy)NSString *secondCarReport;
@property (nonatomic , copy)NSString *companyName;
@property (nonatomic , copy)NSString *note;
@property (nonatomic , copy)NSString *mobile;
@property (nonatomic , copy)NSString *loanBankCode;
@property (nonatomic , copy)NSString *loanAmount;
@property (nonatomic , copy)NSString *teamCode;
@property (nonatomic , copy)NSString *code;
@property (nonatomic , copy)NSString *saleUserId;
@property (nonatomic , strong)NSArray *creditUserList;
@property (nonatomic , copy)NSString *userName;
@property (nonatomic , copy)NSString *idNo;

@property (nonatomic , copy)NSString *curNodeCode;
@property (nonatomic , copy)NSString *companyCode;
@property (nonatomic , copy)NSString *budgetCode;
@property (nonatomic , copy)NSString *applyDatetime;



@end
