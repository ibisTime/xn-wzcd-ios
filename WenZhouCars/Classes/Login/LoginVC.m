#import "LoginVC.h"
#import "HomeVC.h"
#import "ChangePasswordVC.h"
@interface LoginVC ()
@property (nonatomic , strong)UITextField *mobileTextFd;
@property (nonatomic , strong)UITextField *passWordTextFd;
@property (nonatomic , strong)UIButton *ForgotPasswordButton;
@property (nonatomic , strong)UIButton *loginButton;
@end
@implementation LoginVC
-(UIButton *)ForgotPasswordButton
{
    if (!_ForgotPasswordButton) {
        _ForgotPasswordButton = [UIButton buttonWithTitle:@"忘记密码?" titleColor:GaryTextColor backgroundColor:kClearColor titleFont:12 cornerRadius:0];
        _ForgotPasswordButton.frame = CGRectMake(SCREEN_WIDTH - 95, 310, 80, 20);
        [_ForgotPasswordButton addTarget:self action:@selector(buttonMethodClick:) forControlEvents:(UIControlEventTouchUpInside)];
        _ForgotPasswordButton.tag = 100;
    }
    return _ForgotPasswordButton;
}
-(UIButton *)loginButton
{
    if (!_loginButton) {
        _loginButton = [UIButton buttonWithTitle:@"登录" titleColor:[UIColor whiteColor] backgroundColor:HGColor(210, 210, 210) titleFont:18 cornerRadius:5];
        _loginButton.frame = CGRectMake(20, 380, SCREEN_WIDTH - 40, 50);
        [_loginButton addTarget:self action:@selector(buttonMethodClick:) forControlEvents:(UIControlEventTouchUpInside)];
        _loginButton.tag = 101;
    }
    return _loginButton;
}
-(void)buttonMethodClick:(UIButton *)sender
{
    if (sender.tag == 100) {
        ChangePasswordVC *vc = [ChangePasswordVC new];
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
        vc.state = @"100";
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
        [self presentViewController:nav animated:YES completion:nil];
    }
    else
    {
        if ([_mobileTextFd.text isEqualToString:@""]) {
            [TLAlert alertWithInfo:@"请输入手机号"];
            return;
        }
        if ([_passWordTextFd.text isEqualToString:@""]) {
            [TLAlert alertWithInfo:@"请输入密码"];
            return;
        }
        TLNetworking *http = [TLNetworking new];
        http.code = @"630051";
        http.showView = self.view;
        http.parameters[@"type"] = @"P";
        http.parameters[@"loginName"] = _mobileTextFd.text;
        http.parameters[@"loginPwd"] = _passWordTextFd.text;
        [http postWithSuccess:^(id responseObject) {
            WGLog(@"%@",responseObject);
            [USERDEFAULTS setObject:responseObject[@"data"][@"token"] forKey:TOKEN_ID];
            [USERDEFAULTS setObject:responseObject[@"data"][@"userId"] forKey:USER_ID];
            [self updateUserInfoWithNotification];
        } failure:^(NSError *error) {
            WGLog(@"%@",error);
        }];
    }
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
- (void)viewDidLoad {
    [super viewDidLoad];
    [self customTypeSetUp];
    [self.view addSubview:self.ForgotPasswordButton];
    [self.view addSubview:self.loginButton];
}
-(void)customTypeSetUp
{
    UILabel *nameLabel = [UILabel labelWithFrame:CGRectMake(0, 80, SCREEN_WIDTH , 40) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:HGfont(32) textColor:[UIColor blackColor]];
    nameLabel.text = @"登 录";
    [self.view addSubview:nameLabel];
    _mobileTextFd = [[UITextField alloc]initWithFrame:CGRectMake(15, 170, SCREEN_WIDTH - 30, 40)];
    _mobileTextFd.font = HGfont(18);
    _mobileTextFd.placeholder = @"请输入账号";
    [_mobileTextFd setValue:HGfont(18) forKeyPath:@"_placeholderLabel.font"];
    [_mobileTextFd setValue:GaryTextColor forKeyPath:@"_placeholderLabel.color"];
    [self.view addSubview:_mobileTextFd];
    _passWordTextFd = [[UITextField alloc]initWithFrame:CGRectMake(15, 250, SCREEN_WIDTH - 30, 40)];
    _passWordTextFd.font = HGfont(18);
    _passWordTextFd.placeholder = @"请输入密码";
    _passWordTextFd.secureTextEntry = YES;
    [_passWordTextFd setValue:HGfont(18) forKeyPath:@"_placeholderLabel.font"];
    [_passWordTextFd setValue:GaryTextColor forKeyPath:@"_placeholderLabel.color"];
    [self.view addSubview:_passWordTextFd];
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(15, 219, SCREEN_WIDTH - 30, 1)];
    lineView.backgroundColor = RGB(237.0, 237.0, 237.0);
    [self.view addSubview:lineView];
    UIView *lineView1 = [[UIView alloc]initWithFrame:CGRectMake(15, 299, SCREEN_WIDTH - 30, 1)];
    lineView1.backgroundColor = RGB(237.0, 237.0, 237.0);
    [self.view addSubview:lineView1];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}
@end
