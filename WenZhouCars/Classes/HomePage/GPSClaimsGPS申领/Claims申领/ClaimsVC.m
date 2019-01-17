#import "ClaimsVC.h"
#import "ClaimsTableView.h"
@interface ClaimsVC ()<RefreshDelegate>
@property (nonatomic , strong)ClaimsTableView *tableView;
@end
@implementation ClaimsVC
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"申领";
    [self initTableView];
}
- (void)initTableView {
    self.tableView = [[ClaimsTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    self.tableView.backgroundColor = kBackgroundColor;
    [self.view addSubview:self.tableView];
}
-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index
{
    UITextField *textFid1 = [self.view viewWithTag:100];
    UITextField *textFid2 = [self.view viewWithTag:101];
    if ([textFid1.text isEqualToString:@""]) {
        [TLAlert alertWithInfo:@"申领个数"];
        return;
    }
    TLNetworking *http = [TLNetworking new];
    http.code = @"632710";
    http.showView = self.view;
    http.parameters[@"applyCount"] = textFid1.text;
    http.parameters[@"applyReason"] = textFid2.text;
    http.parameters[@"applyUser"] = [USERDEFAULTS objectForKey:USER_ID];
    http.parameters[@"type"] = @"1";
    [http postWithSuccess:^(id responseObject) {
        [TLAlert alertWithSucces:@"申领成功"];
        NSNotification *notification =[NSNotification notificationWithName:LOADDATAPAGE object:nil userInfo:nil];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSError *error) {
        WGLog(@"%@",error);
    }];
}
@end
