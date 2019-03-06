#import "MakeCardEntryVC.h"
#import "MakeCardEntryTableView.h"
@interface MakeCardEntryVC ()<RefreshDelegate>
@property (nonatomic , strong)MakeCardEntryTableView *tableView;
@end
@implementation MakeCardEntryVC
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTableView];
}
- (void)initTableView {
    self.tableView = [[MakeCardEntryTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    self.tableView.backgroundColor = kBackgroundColor;
    self.tableView.model = self.model;
    [self.view addSubview:self.tableView];
}
-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}
-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index
{
    UITextField *textField1 = [self.view viewWithTag:300];
    UITextField *textField2 = [self.view viewWithTag:301];
    if ([textField1.text isEqualToString:@""]) {
        [TLAlert alertWithInfo:@"请输入卡号"];
        return;
    }
    TLNetworking *http = [TLNetworking new];
    http.code = @"632211";
    http.parameters[@"bankCardNumber"] = textField1.text;
    http.parameters[@"code"] = self.model.code;
    http.parameters[@"makeCardRemark"] = textField2.text;
    http.parameters[@"operator"] = [USERDEFAULTS objectForKey:USER_ID];
    http.showView = self.view;
    [http postWithSuccess:^(id responseObject) {
        [TLAlert alertWithSucces:@"录入成功"];
        NSNotification *notification =[NSNotification notificationWithName:LOADDATAPAGE object:nil userInfo:nil];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSError *error) {
        WGLog(@"%@",error);
    }];
}
-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index selectRowState:(NSString *)state
{
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
