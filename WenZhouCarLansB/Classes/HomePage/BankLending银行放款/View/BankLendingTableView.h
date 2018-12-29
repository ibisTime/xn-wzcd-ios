//
//  BankLendingTableView.h
//  CarLoans
//
//  Created by QinBao Zheng on 2018/8/6.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "TLTableView.h"
#import "AccessSingleModel.h"
@interface BankLendingTableView : TLTableView

@property (nonatomic , strong)NSMutableArray <AccessSingleModel *>*model;

@end
