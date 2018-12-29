//
//  CarSettledUpdataPhotoCell.h
//  CarLoans
//
//  Created by QinBao Zheng on 2018/8/6.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CarSettledUpdataPhotoDelegate <NSObject>

-(void)CarSettledUpdataPhotoBtn:(UIButton *)sender selectStr:(NSString *)Str;

@end


@interface CarSettledUpdataPhotoCell : UITableViewCell

@property (nonatomic , copy)NSString *selectStr;
@property (nonatomic , copy)NSString *photoStr;

@property (nonatomic , copy)NSString *photoimg;


@property (nonatomic, assign) id <CarSettledUpdataPhotoDelegate> IdCardDelegate;

@property (nonatomic , strong)UIButton *photoBtn;

@end
