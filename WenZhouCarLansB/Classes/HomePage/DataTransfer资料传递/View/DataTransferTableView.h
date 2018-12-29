//
//  DataTransferTableView.h
//  CarLoans
//
//  Created by QinBao Zheng on 2018/7/30.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "TLTableView.h"
#import "DataTransferModel.h"
@interface DataTransferTableView : TLTableView

@property (nonatomic , strong)NSMutableArray <DataTransferModel *>*model;

@end
