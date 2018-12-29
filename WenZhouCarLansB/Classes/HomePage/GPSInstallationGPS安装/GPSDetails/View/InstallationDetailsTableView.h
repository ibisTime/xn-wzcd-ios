//
//  InstallationDetailsTableView.h
//  CarLoans
//
//  Created by QinBao Zheng on 2018/8/9.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "TLTableView.h"
#import "GPSInstallationModel.h"
#import "GPSInstallationDetailsModel.h"
@interface InstallationDetailsTableView : TLTableView

@property (nonatomic , strong)GPSInstallationModel *model;

@property (nonatomic , strong)GPSInstallationDetailsModel *detailsModel;

@end
