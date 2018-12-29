//
//  HistoryUserDetailsTableView.h
//  CarLoans
//
//  Created by QinBao Zheng on 2018/8/31.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "TLTableView.h"
#import "SettlementAuditModel.h"
@interface HistoryUserDetailsTableView : TLTableView

@property (nonatomic , strong)SettlementAuditModel *model;

@end
