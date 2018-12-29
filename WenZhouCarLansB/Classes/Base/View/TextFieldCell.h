//
//  TextFieldCell.h
//  CarLoans
//
//  Created by QinBao Zheng on 2018/7/17.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TextFieldCell : UITableViewCell

@property (nonatomic , copy)NSString *isInput;

@property (nonatomic , copy)NSString *name;

@property (nonatomic , copy)NSString *nameText;

@property (nonatomic , copy)NSString *TextFidStr;

@property (nonatomic , strong)UILabel *nameLabel;

@property (nonatomic , strong)UITextField *nameTextField;

@end
