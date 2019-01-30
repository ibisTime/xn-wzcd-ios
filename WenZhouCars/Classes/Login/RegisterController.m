//
//  RegisterController.m
//  WenZhouCars
//
//  Created by shaojianfei on 2019/1/24.
//  Copyright © 2019年 QinBao Zheng. All rights reserved.
//
#import "CustomTextFieldView.h"
#import "SendCodeView.h"
#import "RegisterController.h"
#import "HomeVC.h"
@interface RegisterController ()
{
    CustomTextFieldView *tfView1;
    SendCodeView *codeView;
    CustomTextFieldView *tfView2;
    CustomTextFieldView *tfView3;
    CustomTextFieldView *tfView4;
    CustomTextFieldView *tfView5;

}
@end

@implementation RegisterController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"注册";
    self.view.backgroundColor = BackColor;
    [self TheInterfaceDisplayView];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    self.navigationItem.leftBarButtonItems = @[negativeSpacer, [[UIBarButtonItem alloc] initWithCustomView:self.LeftBackbButton]];
    [self.LeftBackbButton addTarget:self action:@selector(LeftBackbButtonClick) forControlEvents:(UIControlEventTouchUpInside)];
    self.LeftBackbButton.backgroundColor = kNavBarBackgroundColor;
    if ([_state isEqualToString:@"100"]) {
    }
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
-(void)LeftBackbButtonClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)TheInterfaceDisplayView
{
    tfView1 = [[CustomTextFieldView alloc]initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 60)];
    tfView1.nameLabel.text = @"手机号";
    tfView1.nameTextField.placeholder = @"请输入手机号";
    tfView1.nameTextField.keyboardType = UIKeyboardTypePhonePad;
    [self.view addSubview:tfView1];
    codeView = [[SendCodeView alloc]initWithFrame:CGRectMake(0, 70, SCREEN_WIDTH, 60)];
    codeView.nameLabel.text = @"验证码";
    codeView.nameTextField.placeholder = @"请输入验证码";
    [codeView.sendButton addTarget:self action:@selector(sendButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:codeView];
    tfView4 = [[CustomTextFieldView alloc]initWithFrame:CGRectMake(0, 130, SCREEN_WIDTH, 60)];
    tfView4.nameLabel.text = @"身份证号";
    tfView4.nameTextField.placeholder = @"请输入身份证号";
    [self.view addSubview:tfView4];
    tfView5 = [[CustomTextFieldView alloc]initWithFrame:CGRectMake(0, 190, SCREEN_WIDTH, 60)];
    tfView5.nameLabel.text = @"真实姓名";
    tfView5.nameTextField.placeholder = @"请输入真实姓名";
    [self.view addSubview:tfView5];
    tfView2 = [[CustomTextFieldView alloc]initWithFrame:CGRectMake(0, 250, SCREEN_WIDTH, 60)];
    tfView2.nameLabel.text = @"新密码";
    tfView2.nameTextField.secureTextEntry = YES;
    tfView2.nameTextField.placeholder = @"不少于6位";
    [self.view addSubview:tfView2];

    tfView3 = [[CustomTextFieldView alloc]initWithFrame:CGRectMake(0, 310, SCREEN_WIDTH, 60)];
    tfView3.nameLabel.text = @"确认密码";
    tfView3.nameTextField.secureTextEntry = YES;
    tfView3.nameTextField.placeholder = @"不少于6位";
    [self.view addSubview:tfView3];
    UIButton *confirmButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    confirmButton.frame = CGRectMake(20, 400, SCREEN_WIDTH - 40, 50);
    [confirmButton setTitle:@"确认" forState:(UIControlStateNormal)];
    confirmButton.backgroundColor = MainColor;
    kViewRadius(confirmButton, 5);
    confirmButton.titleLabel.font = HGfont(18);
    [confirmButton addTarget:self action:@selector(confirmButtonClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:confirmButton];
}
-(void)confirmButtonClick
{
    if ([tfView1.nameTextField.text isEqualToString:@""]) {
        [TLAlert alertWithInfo:@"请输入手机号"];
        return;
    }
    if ([codeView.nameTextField.text isEqualToString:@""]) {
        [TLAlert alertWithInfo:@"请输入验证码"];
        return;
    }
    if ([tfView4.nameTextField.text isEqualToString:@""]) {
        [TLAlert alertWithInfo:@"请输入身份证号"];
        return;
    }
    if ([tfView5.nameTextField.text isEqualToString:@""]) {
        [TLAlert alertWithInfo:@"请输入真实姓名"];
        return;
    }
    if ([tfView3.nameTextField.text isEqualToString:@""]) {
        [TLAlert alertWithInfo:@"请输入新密码"];
        return;
    }
    if (![tfView3.nameTextField.text isEqualToString:tfView2.nameTextField.text]) {
        [TLAlert alertWithInfo:@"密码不一致"];
        return;
    }
    TLNetworking *http = [TLNetworking new];
    http.code = @"630060";
    http.isShowMsg = YES;
    http.showView = self.view;
    http.parameters[@"type"] = @"i";
    http.parameters[@"mobile"] = tfView1.nameTextField.text;
    http.parameters[@"idNo"] = tfView4.nameTextField.text;
    http.parameters[@"realName"] = tfView5.nameTextField.text;
    http.parameters[@"loginPwd"] = tfView3.nameTextField.text;
    http.parameters[@"smsCaptcha"] = codeView.nameTextField.text;

    
    [http postWithSuccess:^(id responseObject) {
        WGLog(@"%@",responseObject);
        [self goLogin];
    } failure:^(NSError *error) {

    }];
}

- (void)goLogin
{
    TLNetworking *http = [TLNetworking new];
    http.code = @"630051";
    http.showView = self.view;
    http.parameters[@"type"] = @"P";
    http.parameters[@"loginName"] = tfView1.nameTextField.text;
    http.parameters[@"loginPwd"] = tfView3.nameTextField.text;
    [http postWithSuccess:^(id responseObject) {
        WGLog(@"%@",responseObject);
        [USERDEFAULTS setObject:responseObject[@"data"][@"token"] forKey:TOKEN_ID];
        [USERDEFAULTS setObject:responseObject[@"data"][@"userId"] forKey:USER_ID];
        [self updateUserInfoWithNotification];
    } failure:^(NSError *error) {
        WGLog(@"%@",error);
    }];
}
- (void)updateUserInfoWithNotification
{
    TLNetworking *http = [TLNetworking new];
    http.isShowMsg = NO;
    http.code = USER_INFO;
    http.parameters[@"userId"] = [USERDEFAULTS objectForKey:USER_ID];
    http.parameters[@"token"] = [USERDEFAULTS objectForKey:TOKEN_ID];
    [http postWithSuccess:^(id responseObject) {
        HomeVC *vc = [HomeVC new];
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
        UIWindow *window = [[UIApplication sharedApplication] keyWindow];
        window.rootViewController = nav;
        [self setUserInfoWithDict:responseObject[@"data"]];
    } failure:^(NSError *error) {
    }];
}
- (void)setUserInfoWithDict:(NSDictionary *)dict
{
    [USERDEFAULTS setObject:dict forKey:USERDATA];
    [USERDEFAULTS setObject:dict[@"roleCode"] forKey:ROLECODE];
    [USERDEFAULTS setObject:dict[@"postCode"] forKey:ROSTCODE];
    [USERDEFAULTS setObject:dict[@"teamCode"] forKey:TEAMCODE];
}
-(void)sendButtonClick:(UIButton *)sender
{
    if ([tfView1.nameTextField.text isEqualToString:@""]) {
        [TLAlert alertWithInfo:@"请输入手机号"];
        return;
    }
    TLNetworking *http = [TLNetworking new];
    http.code = VERIFICATION_CODE_CODE;
    http.isShowMsg = YES;
    http.showView = self.view;
    http.parameters[@"kind"] = @"B";
    http.parameters[@"mobile"] = tfView1.nameTextField.text;
    http.parameters[@"bizType"] = NEWUSER_REG_CODE;
    [http postWithSuccess:^(id responseObject) {
        WGLog(@"%@",responseObject);
        [self SendVerificationCode:sender];
    } failure:^(NSError *error) {
        WGLog(@"%@",error);
        
    }];
}
-(void)SendVerificationCode:(UIButton *)sender
{
    NSLog(@"123");
    __block NSInteger time = 59;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(_timer, ^{
        if(time <= 0){
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                [sender setTitle:@"获取验证码" forState:UIControlStateNormal];
                sender.userInteractionEnabled = YES;
                sender.backgroundColor = MainColor;
            });
        }else{
            int seconds = time % 60;
            dispatch_async(dispatch_get_main_queue(), ^{
                [sender setTitle:[NSString stringWithFormat:@"%.2d后重发", seconds] forState:UIControlStateNormal];
                sender.userInteractionEnabled = NO;
                sender.backgroundColor = [UIColor grayColor];
            });
            time--;
        }
    });
    dispatch_resume(_timer);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
