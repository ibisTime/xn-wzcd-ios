//
//  HistoryUserTableView.h
//  CarLoans
//
//  Created by QinBao Zheng on 2018/8/8.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "TLTableView.h"
#import "SettlementAuditModel.h"
@interface HistoryUserTableView : TLTableView

@property (nonatomic , strong)NSMutableArray <SettlementAuditModel *>*model;

@end
