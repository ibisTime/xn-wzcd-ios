//
//  MortgageCalculatorTableView.h
//  WenZhouCarLansB
//
//  Created by QinBao Zheng on 2018/9/4.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "TLTableView.h"

@interface MortgageCalculatorTableView : TLTableView
//银行
@property (nonatomic , copy)NSString *bankStr;
//期数
@property (nonatomic , copy)NSString *periodStr;
//利率类型
@property (nonatomic , copy)NSString *interestTypeStr;
//手机费收取方式
@property (nonatomic , copy)NSString *feesChargedStr;

@property (nonatomic , copy)NSString *interestStr;
//附加费
@property (nonatomic , copy)NSString *surcharge;

@property (nonatomic , copy)NSString *initialAmount;
@property (nonatomic , copy)NSString *annualAmount;


@end
