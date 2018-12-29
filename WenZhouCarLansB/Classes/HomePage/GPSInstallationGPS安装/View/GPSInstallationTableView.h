//
//  GPSInstallationTableView.h
//  CarLoans
//
//  Created by QinBao Zheng on 2018/8/3.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "TLTableView.h"
#import "GPSInstallationModel.h"
@interface GPSInstallationTableView : TLTableView

@property (nonatomic , strong)NSMutableArray <GPSInstallationModel *>*model;

@end
