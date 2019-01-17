#import "GPSClaimsVC.h"
#import "GPSClaimsTableView.h"
#import "GPSClaimsModel.h"
#import "ClaimsVC.h"
#import "GPSClaimsDetailsVC.h"
@interface GPSClaimsVC ()<RefreshDelegate>
@property (nonatomic , strong)NSMutableArray <GPSClaimsModel *>*model;
@property (nonatomic , strong)GPSClaimsTableView *tableView;
@end
@implementation GPSClaimsVC
- (void)viewDidLoad {
    [super viewDidLoad];
    [self navigativeView];
    [self initTableView];
    [self LoadData];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(InfoNotificationAction:) name:LOADDATAPAGE object:nil];
}
#pragma mark -- 接收到通知
- (void)InfoNotificationAction:(NSNotification *)notification{
    [self LoadData];
}
#pragma mark -- 删除通知
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:LOADDATAPAGE object:nil];
}
- (void)initTableView {
    self.tableView = [[GPSClaimsTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    self.tableView.backgroundColor = kBackgroundColor;
    [self.view addSubview:self.tableView];
}
-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GPSClaimsDetailsVC *vc = [GPSClaimsDetailsVC new];
    vc.model = self.model[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)navigativeView
{
    self.title = @"GPS申领";
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = -10;
    self.navigationItem.rightBarButtonItems = @[negativeSpacer, [[UIBarButtonItem alloc] initWithCustomView:self.RightButton]];
    [self.RightButton setTitle:@"申领" forState:(UIControlStateNormal)];
    [self.RightButton addTarget:self action:@selector(rightButtonClick) forControlEvents:(UIControlEventTouchUpInside)];
}
-(void)rightButtonClick
{
    ClaimsVC *vc = [[ClaimsVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)LoadData
{
    ProjectWeakSelf;
    TLPageDataHelper *helper = [[TLPageDataHelper alloc] init];
    helper.code = @"632715";
    helper.parameters[@"teamCode"] = [USERDEFAULTS objectForKey:TEAMCODE];
    helper.isList = NO;
    helper.isCurrency = YES;
    helper.tableView = self.tableView;
    [helper modelClass:[GPSClaimsModel class]];
    [self.tableView addRefreshAction:^{
        [helper refresh:^(NSMutableArray *objs, BOOL stillHave) {
            NSLog(@" ==== %@",objs);
            NSMutableArray <GPSClaimsModel *> *shouldDisplayCoins = [[NSMutableArray alloc] init];
            [objs enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                GPSClaimsModel *model = (GPSClaimsModel *)obj;
                [shouldDisplayCoins addObject:model];
            }];
            weakSelf.model = shouldDisplayCoins;
            weakSelf.tableView.model = shouldDisplayCoins;
            [weakSelf.tableView reloadData_tl];
        } failure:^(NSError *error) {
        }];
    }];
    [self.tableView addLoadMoreAction:^{
        helper.parameters[@"teamCode"] = [USERDEFAULTS objectForKey:TEAMCODE];
        [helper loadMore:^(NSMutableArray *objs, BOOL stillHave) {
            NSLog(@" ==== %@",objs);
            NSMutableArray <GPSClaimsModel *> *shouldDisplayCoins = [[NSMutableArray alloc] init];
            [objs enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                GPSClaimsModel *model = (GPSClaimsModel *)obj;
                [shouldDisplayCoins addObject:model];
            }];
            weakSelf.model = shouldDisplayCoins;
            weakSelf.tableView.model = shouldDisplayCoins;
            [weakSelf.tableView reloadData_tl];
        } failure:^(NSError *error) {
        }];
    }];
    [self.tableView beginRefreshing];
}
@end
