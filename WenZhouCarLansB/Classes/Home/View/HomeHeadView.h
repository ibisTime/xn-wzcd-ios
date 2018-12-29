//
//  HomeHeadView.h
//  CarLoans
//
//  Created by QinBao Zheng on 2018/7/17.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeHeadView : UITableViewHeaderFooterView

@property (nonatomic , strong)NSDictionary *dic;

@property (nonatomic , strong)UIImageView *headImage;

@property (nonatomic , strong)UILabel *nameLabel;

@property (nonatomic , strong)UILabel *introduceLabel;

@end
