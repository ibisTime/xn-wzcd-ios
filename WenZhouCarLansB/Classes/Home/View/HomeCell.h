//
//  HomeCell.h
//  CarLoans
//
//  Created by QinBao Zheng on 2018/7/17.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HomeCellDelegate <NSObject>

-(void)HomeCell:(NSInteger)tag button:(UIButton *)sender;

@end

@interface HomeCell : UITableViewCell

@property (nonatomic , strong)NSDictionary *dic;

@property (nonatomic, assign) id <HomeCellDelegate> HomeDelegate;

@property (nonatomic , assign)NSInteger sectionNum;

@end
