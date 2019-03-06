#import "HomeVC.h"
#import "HomeTbView.h"
#import "SurveyTGVC.h"
#import "AccessApplyVC.h"
#import "FinancialEndowmentVC.h"
#import "MakeCardVC.h"
#import "ProtectUsVC.h"
#import "InvoiceNotMatchVC.h"
#import "CustomerInvalidVC.h"
#import "GPSClaimsVC.h"
#import "GPSInstallationVC.h"
#import "HistoryUserVC.h"
#import "MortgageCalculatorVC.h"
#import "DataTransferVC.h"
#import "SGQRCodeScanningVC.h"
#import "BankLendingVC.h"
#import "ContactMortgageVC.h"
#import "HomeZHRYTbView.h"
@interface HomeVC ()<RefreshDelegate>
{
}
@property (nonatomic , strong)HomeTbView *tableView;
@property (nonatomic , strong)HomeZHRYTbView *zhryTableView;
@property (nonatomic , strong)NSDictionary *dataDic;
@end
@implementation HomeVC
- (void)viewDidLoad {
    [super viewDidLoad];
    [self navigativeView];
    [self initTableView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(InfoNotificationAction:) name:@"SweepCodeReceipt" object:nil];
}
#pragma mark -- 接收到通知
- (void)InfoNotificationAction:(NSNotification *)notification{
    NSDictionary *dataDic = notification.userInfo;
    if ([dataDic[@"first"] isEqualToString:@"2"]) {
        [TLAlert alertWithTitle:@"GPS收件" msg:nil confirmMsg:@"收件待补件" cancleMsg:@"收件并审核" cancle:^(UIAlertAction *action) {
            [TLAlert alertWithTitle:@"备注" msg:@"" confirmMsg:@"确认" cancleMsg:@"取消" placeHolder:@"请输入备注" maker:self cancle:^(UIAlertAction *action) {
            } confirm:^(UIAlertAction *action, UITextField *textField) {
                if ([textField.text isEqualToString:@""]) {
                    [TLAlert alertWithInfo:@"请输入备注"];
                }else
                {
                    [self ReceiptToPatchSetDic:dataDic textField:textField.text];
                }
            }];
        } confirm:^(UIAlertAction *action) {
            [self Receipt:dataDic];
        }];
    }else
    {
        [TLAlert alertWithTitle:@"资料收件" msg:nil confirmMsg:@"确认" cancleMsg:@"取消" cancle:^(UIAlertAction *action) {
        } confirm:^(UIAlertAction *action) {
            [self Receipt:dataDic];
        }];
    }
}
-(void)ReceiptToPatchSetDic:(NSDictionary *)dataDic textField:(NSString *)str;
{
    TLNetworking *http = [TLNetworking new];
    http.code = @"632152";
    http.showView = self.view;
    http.parameters[@"codeList"] = @[dataDic[@"codeList"]];
    http.parameters[@"supplementReason"] = @[dataDic[@"codeList"]];
    http.parameters[@"operator"] = [USERDEFAULTS objectForKey:USER_ID];
    [http postWithSuccess:^(id responseObject) {
        [TLAlert alertWithSucces:@"收件成功"];
    } failure:^(NSError *error) {
        WGLog(@"%@",error);
    }];
}
-(void)Receipt:(NSDictionary *)dataDic
{
    TLNetworking *http = [TLNetworking new];
    http.code = @"632151";
    http.showView = self.view;
    http.parameters[@"codeList"] = @[dataDic[@"codeList"]];
    http.parameters[@"operator"] = [USERDEFAULTS objectForKey:USER_ID];
    [http postWithSuccess:^(id responseObject) {
        [TLAlert alertWithSucces:@"收件成功"];
    } failure:^(NSError *error) {
        WGLog(@"%@",error);
    }];
}
#pragma mark -- 删除通知
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"SweepCodeReceipt" object:nil];
}
- (void)initTableView {
    self.tableView = [[HomeTbView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    self.tableView.backgroundColor = kBackgroundColor;
    [self.view addSubview:self.tableView];
    self.zhryTableView = [[HomeZHRYTbView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.zhryTableView.refreshDelegate = self;
    self.zhryTableView.hidden = YES;
    self.zhryTableView.backgroundColor = kBackgroundColor;
    [self.view addSubview:self.zhryTableView];
}
-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index
{
    if (refreshTableview == self.tableView) {
        switch (index) {
            case 100:
            {
                SurveyTGVC *vc = [SurveyTGVC new];
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 101:
            {
                AccessApplyVC *vc = [AccessApplyVC new];
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 102:
            {
                FinancialEndowmentVC *vc = [FinancialEndowmentVC new];
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 1000:
            {
                MakeCardVC *vc = [MakeCardVC new];
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 1001:
            {
                ProtectUsVC *vc = [ProtectUsVC new];
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 1002:
            {
                InvoiceNotMatchVC *vc = [InvoiceNotMatchVC new];
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 1003:
            {
                CustomerInvalidVC *vc = [CustomerInvalidVC new];
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 1004:
            {
                GPSClaimsVC *vc = [GPSClaimsVC new];
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 1005:
            {
                GPSInstallationVC *vc= [GPSInstallationVC new];
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 1006:
            {
                HistoryUserVC *vc = [HistoryUserVC new];
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 1007:
            {
                MortgageCalculatorVC *vc = [MortgageCalculatorVC new];
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 10000:
            {
                DataTransferVC *vc = [DataTransferVC new];
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 10001:
            {
                SGQRCodeScanningVC *vc = [SGQRCodeScanningVC new];
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            default:
                break;
        }
    }
    else
    {
        switch (index) {
            case 100:
            {
                SurveyTGVC *vc = [SurveyTGVC new];
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 101:
            {
                AccessApplyVC *vc = [AccessApplyVC new];
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 102:
            {
                BankLendingVC *vc= [BankLendingVC new];
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 1000:
            {
                ContactMortgageVC *vc= [ContactMortgageVC new];
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 1001:
            {
                MortgageCalculatorVC *vc = [MortgageCalculatorVC new];
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 10000:
            {
                DataTransferVC *vc = [DataTransferVC new];
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            default:
                break;
        }
    }
}
-(void)navigativeView
{
    self.title = @"车贷";
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = -10;
    self.navigationItem.rightBarButtonItems = @[negativeSpacer, [[UIBarButtonItem alloc] initWithCustomView:self.RightButton]];
    [self.RightButton setTitle:@"切换账号" forState:(UIControlStateNormal)];
    [self.RightButton addTarget:self action:@selector(rightButtonClick) forControlEvents:(UIControlEventTouchUpInside)];
}
-(void)rightButtonClick
{
    [TLAlert alertWithTitle:@"提示" msg:@"是否退出登录" confirmMsg:@"取消" cancleMsg:@"确认" cancle:^(UIAlertAction *action) {
        LoginVC *vc = [[LoginVC alloc]init];
        UIWindow *window = [[UIApplication sharedApplication] keyWindow];
        [USERDEFAULTS removeObjectForKey:USER_ID];
        [USERDEFAULTS removeObjectForKey:TOKEN_ID];
        window.rootViewController = vc;
    } confirm:^(UIAlertAction *action) {
    }];
}
-(void)viewWillAppear:(BOOL)animated
{
    [self updateUserInfoWithNotification];
    [self loadData];
}
- (void)updateUserInfoWithNotification
{
    TLNetworking *http = [TLNetworking new];
    http.isShowMsg = NO;
    http.code = USER_INFO;
    http.parameters[@"userId"] = [USERDEFAULTS objectForKey:USER_ID];
    [http postWithSuccess:^(id responseObject) {
        self.dataDic =  responseObject[@"data"];
        self.tableView.dic = self.dataDic;
        self.zhryTableView.dic = self.dataDic;
        [self setUserInfoWithDict:responseObject[@"data"]];
        [self RedDotPromptDic:responseObject[@"data"]];
        if ([responseObject[@"data"][@"roleCode"] isEqualToString:@"SR20180000000000000ZHRY"]) {
            self.tableView.hidden = YES;
            self.zhryTableView.hidden = NO;
        }else
        {
            self.tableView.hidden = NO;
            self.zhryTableView.hidden = YES;
        }
    } failure:^(NSError *error) {
    }];
}
-(void)RedDotPromptDic:(NSDictionary *)dict
{
    TLNetworking *http = [TLNetworking new];
    http.isShowMsg = NO;
    http.code = @"632912";
    http.parameters[@"roleCode"] = dict[@"roleCode"];
    http.parameters[@"teamCode"] = dict[@"teamCode"];
    [http postWithSuccess:^(id responseObject) {
        self.tableView.RedDotDic = responseObject[@"data"];
        [self.tableView reloadData];
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)loadData
{
    TLNetworking *http = [TLNetworking new];
    http.isShowMsg = NO;
    http.code = @"630147";
    [http postWithSuccess:^(id responseObject) {
        [USERDEFAULTS setObject:responseObject[@"data"] forKey:NODE];
    } failure:^(NSError *error) {
    }];
    
    TLNetworking *http1 = [TLNetworking new];
    http1.isShowMsg = NO;
    http1.code = @"630036";
    [http1 postWithSuccess:^(id responseObject) {
        [USERDEFAULTS setObject:responseObject[@"data"] forKey:BOUNCEDDATA];
    } failure:^(NSError *error) {
    }];
}
@end
