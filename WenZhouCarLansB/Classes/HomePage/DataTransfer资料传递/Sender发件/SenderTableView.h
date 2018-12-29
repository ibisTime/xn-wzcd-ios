//
//  SenderTableView.h
//  CarLoans
//
//  Created by QinBao Zheng on 2018/8/2.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "TLTableView.h"
#import "DataTransferModel.h"
@interface SenderTableView : TLTableView

@property (nonatomic , strong)DataTransferModel *model;

@property (nonatomic , copy)NSString *distributionStr;

@property (nonatomic , copy)NSString *CourierCompanyStr;


@property (nonatomic , copy)NSString *date;

@end
