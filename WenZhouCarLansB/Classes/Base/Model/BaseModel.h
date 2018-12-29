//
//  BaseModel.h
//  CarLoans
//
//  Created by QinBao Zheng on 2018/7/17.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BaseModelDelegate <NSObject>

-(void)TheReturnValueStr:(NSString *)Str selectDic:(NSDictionary *)dic selectSid:(NSInteger)sid;

@end

@interface BaseModel : NSObject

@property (nonatomic, assign) id <BaseModelDelegate> ModelDelegate;


//{
//    "errorCode" : "0",
//    "data" : {
//        "roleCode" : "SR20180000000000000NQZY",
//        "departmentCode" : "DP201806060410323124458",
//        "realName" : "郑",
//        "loginName" : "13506537519",
//        "postCode" : "DP201806060410507163022",
//        "mobile" : "13506537519",
//        "type" : "P",
//        "teamCode" : "BT201808021925177095580",
//        "userId" : "U201808021932070617728",
//        "archiveCode" : "RA201808021931082902566",
//        "createDatetime" : "Aug 2, 2018 7:32:07 PM",
//        "updater" : "USYS201800000000001",
//        "companyName" : "乌鲁木齐华途威通汽车销售有限公司",
//        "postName" : "业务员",
//        "companyCode" : "DP201800000000000000001",
//        "status" : "0",
//        "departmentName" : "业务部"
//    },
//    "errorInfo" : "成功"
//}


//驻行人员

//{
//    "errorCode" : "0",
//    "data" : {
//        "roleCode" : "SR20180000000000000ZHRY",
//        "departmentCode" : "DP201806060410323124458",
//        "realName" : "郑",
//        "loginName" : "13506537519",
//        "postCode" : "DP201806060410507163022",
//        "mobile" : "13506537519",
//        "type" : "P",
//        "teamCode" : "BT201808021925177095580",
//        "userId" : "U201808021932070617728",
//        "archiveCode" : "RA201808021931082902566",
//        "createDatetime" : "Aug 2, 2018 7:32:07 PM",
//        "updater" : "USYS201800000000001",
//        "companyName" : "乌鲁木齐华途威通汽车销售有限公司",
//        "postName" : "业务员",
//        "companyCode" : "DP201800000000000000001",
//        "status" : "0",
//        "departmentName" : "业务部"
//    },
//    "errorInfo" : "成功"
//}




+ (instancetype)user;
//是否为需要登录，如果已登录，取出用户信息
- (BOOL)isLogin;
//字符串是否为空
+ (BOOL) isBlankString:(NSString *)string;
+ (NSString*)convertNull:(id)object;

//存储用户信息
- (void)saveUserInfo:(NSDictionary *)userInfo;

- (void)updateUserInfoWithNotification;
//
- (void)CustomBouncedView:(NSMutableArray *)nameArray setState:(NSString *)state;


//选择框数据
-(void )ReturnsParentKeyAnArray:(NSString *)parentKey;
//查找节点
-(NSString *)note:(NSString *)curNodeCode;
//查找角色............
-(NSString *)setParentKey:(NSString *)parentKey setDkey:(NSString *)dkey;


@end
