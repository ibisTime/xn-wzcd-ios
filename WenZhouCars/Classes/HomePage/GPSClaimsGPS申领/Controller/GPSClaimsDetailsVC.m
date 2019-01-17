#import "GPSClaimsDetailsVC.h"
#import "GPSClaimsDetailsTableView.h"
@interface GPSClaimsDetailsVC ()<RefreshDelegate>
@property (nonatomic , strong)GPSClaimsDetailsTableView *tableView;
@end
@implementation GPSClaimsDetailsVC
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"详情";
    [self initTableView];
}
- (void)initTableView {
    self.tableView = [[GPSClaimsDetailsTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    self.tableView.backgroundColor = kBackgroundColor;
    self.tableView.model = self.model;
    [self.view addSubview:self.tableView];
}
-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}
@end
