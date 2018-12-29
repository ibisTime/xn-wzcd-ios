//
//  ADPeopleTableView.h
//  CarLoans
//
//  Created by QinBao Zheng on 2018/7/17.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "TLTableView.h"

@protocol SelectButtonDelegate <NSObject>

-(void)selectButtonClick:(UIButton *)sender;

@end

@interface ADPeopleTableView : TLTableView


@property (nonatomic, assign) id <SelectButtonDelegate> ButtonDelegate;

//    身份证正面
@property (nonatomic , copy)NSString *idNoFront;
//    身份证反面
@property (nonatomic , copy)NSString *idNoReverse;

@property (nonatomic , strong)NSDictionary *dataDic;

@property (nonatomic , assign)NSInteger selectRow;
//    证书
@property (nonatomic , copy)NSString *CerStr;
//    面签
@property (nonatomic , copy)NSString *FaceStr;
//    贷款角色
@property (nonatomic , copy)NSString *loanRole;
//    与借款人关系
@property (nonatomic , copy)NSString *relation;



@end
