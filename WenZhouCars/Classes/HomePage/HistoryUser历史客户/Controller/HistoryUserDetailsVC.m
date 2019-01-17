#import "HistoryUserDetailsVC.h"
#import "HistoryUserDetailsTableView.h"
@interface HistoryUserDetailsVC ()<RefreshDelegate>
@property (nonatomic , strong)HistoryUserDetailsTableView *tableView;
@end
@implementation HistoryUserDetailsVC
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTableView];
    self.title= @"详情";
}
- (void)initTableView {
    self.tableView = [[HistoryUserDetailsTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    self.tableView.backgroundColor = kBackgroundColor;
    self.tableView.model = self.model;
    [self.view addSubview:self.tableView];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
