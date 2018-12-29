//
//  UploadIdCardCell.h
//  CarLoans
//
//  Created by QinBao Zheng on 2018/7/17.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UploadIdCardDelegate <NSObject>

-(void)UploadIdCardBtn:(UIButton *)sender;

-(void)SelectButtonClick:(UIButton *)sender;

@end

@interface UploadIdCardCell : UITableViewCell

@property (nonatomic, assign) id <UploadIdCardDelegate> IdCardDelegate;

//    身份证正面
@property (nonatomic , copy)NSString *idNoFront;
//    身份证反面
@property (nonatomic , copy)NSString *idNoReverse;


@property (nonatomic , strong)UILabel *nameLbl;

@property (nonatomic , strong)UIButton *photoBtn;

@property (nonatomic , strong)UIImageView *photoImage;

@end
