//
//  GPSInvalidTableView.h
//  WenZhouCarLansB
//
//  Created by QinBao Zheng on 2018/9/5.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "TLTableView.h"
#import "GPSInstallationModel.h"

@interface GPSInvalidTableView : TLTableView

@property (nonatomic , strong)GPSInstallationModel *model;

@property (nonatomic , copy)NSString *GPS;

@end
