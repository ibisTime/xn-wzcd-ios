//
//  CustomerInvalidCell.h
//  CarLoans
//
//  Created by QinBao Zheng on 2018/8/1.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomerInvalidModel.h"
#import "SettlementAuditModel.h"
@interface CustomerInvalidCell : UITableViewCell


@property (nonatomic , strong)SettlementAuditModel *settlementAuditModel;
@property (nonatomic , strong)CustomerInvalidModel *model;

@property (nonatomic , strong)UIButton *button;

@property (nonatomic , strong)UILabel *codeLabel;

@property (nonatomic , strong)UILabel *stateLabel;

@property (nonatomic , strong)UILabel *nameLabel;

@property (nonatomic , strong)UILabel *InformationLabel;

@end
