//
//  GPSClaimsCell.h
//  CarLoans
//
//  Created by QinBao Zheng on 2018/7/30.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GPSClaimsModel.h"
#import "GPSInstallationModel.h"
@interface GPSClaimsCell : UITableViewCell

@property (nonatomic , strong)GPSClaimsModel *gpsclaimsModel;
@property (nonatomic , strong)GPSInstallationModel *gpsInstallationModel;

@property (nonatomic , strong)UIButton *button;
@property (nonatomic , strong)UIButton *button1;

@property (nonatomic , strong)UILabel *codeLabel;

@property (nonatomic , strong)UILabel *stateLabel;

@property (nonatomic , strong)UILabel *nameLabel;

@property (nonatomic , strong)UILabel *InformationLabel;

@end
