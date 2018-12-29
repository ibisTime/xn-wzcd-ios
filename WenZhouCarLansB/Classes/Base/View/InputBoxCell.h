//
//  InputBoxCell.h
//  CarLoans
//
//  Created by QinBao Zheng on 2018/7/17.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InputBoxCell : UITableViewCell

@property (nonatomic , copy)NSString *isInput;

@property (nonatomic , copy)NSString *name;

@property (nonatomic , copy)NSString *nameText;

@property (nonatomic , copy)NSString *detailsStr;

@property (nonatomic , strong)UILabel *nameLabel;

@property (nonatomic , strong)UITextField *nameTextField;

@property (nonatomic , strong)UILabel *symbolLabel;

@end
