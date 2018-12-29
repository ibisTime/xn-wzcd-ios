//
//  AccessApplyTableView.h
//  WenZhouCarLansB
//
//  Created by QinBao Zheng on 2018/9/3.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "TLTableView.h"
#import "AccessApplyModel.h"
@interface AccessApplyTableView : TLTableView

@property (nonatomic , strong)NSMutableArray <AccessApplyModel *>*model;

@end
