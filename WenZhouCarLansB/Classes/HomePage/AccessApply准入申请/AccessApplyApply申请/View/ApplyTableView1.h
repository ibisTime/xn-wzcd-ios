//
//  ApplyTableView1.h
//  WenZhouCarLansB
//
//  Created by QinBao Zheng on 2018/9/3.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "TLTableView.h"
#import "AccessApplyModel.h"
@interface ApplyTableView1 : TLTableView
@property (nonatomic , strong)AccessApplyModel *model;

@property (nonatomic , copy)NSArray *GPSArray;

@property (nonatomic , copy)NSString *carDealerCode;


@end
