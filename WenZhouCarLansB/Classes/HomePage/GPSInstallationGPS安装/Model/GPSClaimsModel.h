//
//  GPSClaimsModel.h
//  CarLoans
//
//  Created by QinBao Zheng on 2018/7/30.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GPSClaimsModel : NSObject

@property (nonatomic , assign)NSInteger status;
@property (nonatomic , copy)NSString *applyUserName;
@property (nonatomic , copy)NSString *applyReason;
@property (nonatomic , copy)NSString *code;
@property (nonatomic , copy)NSString *companyCode;
@property (nonatomic , copy)NSString *applyUser;
@property (nonatomic , copy)NSString *applyCount;
@property (nonatomic , copy)NSString *type;
@property (nonatomic , copy)NSString *companyName;
@property (nonatomic , copy)NSString *applyDatetime;
@property (nonatomic , strong)NSArray *gpsList;
//"status" : "0",
//"applyUserName" : "郑",
//"applyReason" : "tyhhgg",
//"code" : "GA201808011459050585247",
//"companyCode" : "DP201806231737515317492",
//"applyUser" : "U201807161731162594497",
//"applyCount" : 22,
//"type" : "2",
//"companyName" : "温州子公司",
//"applyDatetime" : "Aug 1, 2018 2:59:05 PM"

@end
