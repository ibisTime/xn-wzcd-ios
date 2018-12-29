//
//  SurverCertificateCell.h
//  CarLoans
//
//  Created by QinBao Zheng on 2018/7/31.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SurverCertificateCell : UITableViewCell

@property (nonatomic , strong)NSArray *photoArray;

@property (nonatomic , strong)NSArray *imageArray;

@property (nonatomic , copy)NSString *name;
@property (nonatomic , strong)UILabel *nameLbl;

@property (nonatomic , strong)UIButton *photoBtn;

@property (nonatomic , strong)NSArray *picArray;

@end
