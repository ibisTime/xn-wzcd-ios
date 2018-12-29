//
//  BankLendingDetailsTableView.h
//  CarLoans
//
//  Created by QinBao Zheng on 2018/8/6.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "TLTableView.h"
#import "AccessSingleModel.h"
@interface BankLendingDetailsTableView : TLTableView

@property (nonatomic , copy)NSString *date;

@property (nonatomic , strong)AccessSingleModel *model;

@end
