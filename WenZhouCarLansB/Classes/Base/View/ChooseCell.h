//
//  ChooseCell.h
//  CarLoans
//
//  Created by QinBao Zheng on 2018/7/17.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChooseCell : UITableViewCell

@property (nonatomic , copy)NSString *name;

@property (nonatomic , strong)UILabel *nameLabel;

@property (nonatomic , strong)UILabel *detailsLabel;

@property (nonatomic , strong)UIImageView *xiaImage;

@property (nonatomic , copy)NSString *details;

@end
