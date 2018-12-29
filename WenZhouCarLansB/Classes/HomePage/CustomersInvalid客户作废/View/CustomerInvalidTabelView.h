//
//  CustomerInvalidTabelView.h
//  CarLoans
//
//  Created by QinBao Zheng on 2018/8/1.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "TLTableView.h"
#import "CustomerInvalidModel.h"
@interface CustomerInvalidTabelView : TLTableView
@property (nonatomic , strong)NSMutableArray <CustomerInvalidModel *>*model;
@end
