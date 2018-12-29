//
//  InformationCell.h
//  CarLoans
//
//  Created by QinBao Zheng on 2018/7/18.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AccessApplyModel.h"
#import "MakeCardModel.h"
#import "AccessSingleModel.h"
#import "DataTransferModel.h"
@interface InformationCell : UITableViewCell

@property (nonatomic , strong)UIButton *button1;

@property (nonatomic , strong)UIButton *button2;

@property (nonatomic , strong)UILabel *codeLabel;

@property (nonatomic , strong)UILabel *stateLabel;

@property (nonatomic , strong)UILabel *nameLabel;

@property (nonatomic , strong)UILabel *InformationLabel;

@property (nonatomic , strong)AccessApplyModel *accessApplyModel;

@property (nonatomic , strong)MakeCardModel *makeCardModel;

@property (nonatomic , strong)AccessSingleModel *accessSingleModel;

@property (nonatomic , strong)DataTransferModel *dataTransferModel;
@end
