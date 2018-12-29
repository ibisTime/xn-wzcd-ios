//
//  InvoiceNotMatchTableView.h
//  WenZhouCarLansB
//
//  Created by QinBao Zheng on 2018/9/13.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "TLTableView.h"
#import "AccessApplyModel.h"
@interface InvoiceNotMatchTableView : TLTableView

@property (nonatomic , strong)NSMutableArray <AccessApplyModel *>*model;
@end
