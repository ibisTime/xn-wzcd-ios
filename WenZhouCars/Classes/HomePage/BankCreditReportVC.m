#import "BankCreditReportVC.h"
#import "BankCreditReportTableView.h"
@interface BankCreditReportVC ()<RefreshDelegate>
@property (nonatomic , strong)BankCreditReportTableView *tableView;
@end
@implementation BankCreditReportVC
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"征信报告";
    [self initTableView];
}
- (void)initTableView {
    self.tableView = [[BankCreditReportTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    self.tableView.backgroundColor = kBackgroundColor;
    self.tableView.model = [SurvuyPeopleModel mj_objectWithKeyValues:_dataDic];
    [self.view addSubview:self.tableView];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
