//
//  SendListOfLendingTableView.h
//  WenZhouCarLansB
//
//  Created by QinBao Zheng on 2018/9/14.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "TLTableView.h"
#import "AccessSingleModel.h"
@interface SendListOfLendingTableView : TLTableView
@property (nonatomic , strong)AccessSingleModel *model;

@property (nonatomic ,copy)NSString *imageData;

@end
