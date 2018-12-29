//
//  MakeCardTableView.h
//  WenZhouCarLansB
//
//  Created by QinBao Zheng on 2018/9/4.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "TLTableView.h"
#import "MakeCardModel.h"
@interface MakeCardTableView : TLTableView

@property (nonatomic , strong)NSMutableArray <MakeCardModel *>*model;

@end
