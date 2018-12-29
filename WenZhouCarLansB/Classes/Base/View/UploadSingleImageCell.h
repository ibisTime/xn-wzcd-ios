//
//  UploadSingleImageCell.h
//  WenZhouCarLansB
//
//  Created by QinBao Zheng on 2018/9/3.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UploadSingleImageCell : UITableViewCell

//@property (nonatomic, assign) id <UpLoadButtonDelegate > delegate;

@property (nonatomic , strong)NSString *uploadStr;

@property (nonatomic , strong)UILabel *nameLbl;

@property (nonatomic , strong)UIButton *photoBtn;

@property (nonatomic , strong)NSString *imgStr;

@property (nonatomic , strong)NSString *uploadPhoto;



@end
