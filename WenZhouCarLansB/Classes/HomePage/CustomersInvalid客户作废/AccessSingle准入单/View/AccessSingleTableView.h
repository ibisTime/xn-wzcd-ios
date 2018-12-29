//
//  AccessSingleTableView.h
//  CarLoans
//
//  Created by QinBao Zheng on 2018/7/30.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "TLTableView.h"
#import "AccessSingleModel.h"

@interface AccessSingleTableView : TLTableView

@property (nonatomic , strong)NSMutableArray <AccessSingleModel *>*model;

@end
