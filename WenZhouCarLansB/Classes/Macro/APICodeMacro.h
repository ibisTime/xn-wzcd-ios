//
//  APICodeMacro.h
//  YS_iOS
//
//  Created by 蔡卓越 on 2017/6/8.
//  Copyright © 2017年 caizhuoyue. All rights reserved.
//

#ifndef APICodeMacro_h
#define APICodeMacro_h


//研发
#define APPURL @"http://120.26.6.213:2601/forward-service//api"
//测试
//#define APPURL @"http://47.96.161.183:2601/forward-service//api"
//线上
//#define APPURL @"http://39.104.89.43:2601/forward-service/api/"

#define QINIUURL @"http://ounm8iw2d.bkt.clouddn.com/"


//验证码
#define CAPTCHA_CODE @"805950"
//用户
#define USER_REG_CODE @"805041"//注册
#define USER_LOGIN_CODE @"805050"//登录


// ====================   个人中心    ===================
#define VERIFICATION_CODE_CODE @"630090"//发送验证码
#define ModifyPhoneNumberURL @"805061"//修改手机号
#define ChangePasswordURL @"805063"//修改密码
#define TopUpPaymentPassword @"805067"//充值支付密码
#define ModifyTheNicknameURL @"805081"//修改昵称
#define ShippingAddressURL @"805165"//收货地址



//根据ckey查询系统参数
#define USER_CKEY_CVALUE    @"805917"
//七牛图片上传
#define IMG_UPLOAD_CODE @"630091"
//用户信息
#define USER_INFO @"630067"
//AppKind
#define APP_KIND [TLUser user].kind

#endif /* APICodeMacro_h */
