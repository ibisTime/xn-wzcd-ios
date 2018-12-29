//
//  IconView.h
//  CarLoans
//
//  Created by QinBao Zheng on 2018/7/17.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IconView : UIView

@property (nonatomic , strong)UIImage *image;

@property (nonatomic , copy)NSString *nameStr;

@property (nonatomic , copy)NSString *numberStr;

@property (nonatomic , strong)UIButton *backButton;

@property (nonatomic , strong)UIImageView *iconImage;

@property (nonatomic , strong)UILabel *numberLabel;

@property (nonatomic , strong)UILabel *nameLabel;

@end
