#import "HistoryUserVC.h"
#import "SettlementAuditModel.h"
#import "HistoryUserTableView.h"
#import "HistoryUserDetailsVC.h"
@interface HistoryUserVC ()<RefreshDelegate>
@property (nonatomic , strong)NSMutableArray <SettlementAuditModel *>*model;
@property (nonatomic , strong)HistoryUserTableView *tableView;
@end
@implementation HistoryUserVC
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"历史客户";
    [self initTableView];
    [self LoadData];
}
- (void)initTableView {
    self.tableView = [[HistoryUserTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    self.tableView.backgroundColor = kBackgroundColor;
    [self.view addSubview:self.tableView];
}
-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HistoryUserDetailsVC *vc = [[HistoryUserDetailsVC alloc]init];
    vc.model = self.model[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)LoadData
{
    ProjectWeakSelf;
    TLPageDataHelper *helper = [[TLPageDataHelper alloc] init];
    helper.code = @"630520";
    NSArray *array = @[@"003_14",@"003_15",@"003_16",@"003_07",@"007_04"];
    helper.parameters[@"curNodeCodeList"] = array;
    helper.parameters[@"refType"] = @"0";
    helper.parameters[@"teamCode"] = [USERDEFAULTS objectForKey:TEAMCODE];
    helper.isList = NO;
    helper.isCurrency = YES;
    helper.tableView = self.tableView;
    [helper modelClass:[SettlementAuditModel class]];
    [self.tableView addRefreshAction:^{
        [helper refresh:^(NSMutableArray *objs, BOOL stillHave) {
            NSLog(@" ==== %@",objs);
            NSMutableArray <SettlementAuditModel *> *shouldDisplayCoins = [[NSMutableArray alloc] init];
            [objs enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                SettlementAuditModel *model = (SettlementAuditModel *)obj;
                [shouldDisplayCoins addObject:model];
            }];
            weakSelf.model = shouldDisplayCoins;
            weakSelf.tableView.model = shouldDisplayCoins;
            [weakSelf.tableView reloadData_tl];
        } failure:^(NSError *error) {
        }];
    }];
    [self.tableView addLoadMoreAction:^{
        NSArray *array = @[@"003_14",@"003_15",@"003_16",@"003_07",@"007_04"];
        helper.parameters[@"curNodeCodeList"] = array;
        helper.parameters[@"refType"] = @"0";
        helper.parameters[@"teamCode"] = [USERDEFAULTS objectForKey:TEAMCODE];
        [helper loadMore:^(NSMutableArray *objs, BOOL stillHave) {
            NSLog(@" ==== %@",objs);
            NSMutableArray <SettlementAuditModel *> *shouldDisplayCoins = [[NSMutableArray alloc] init];
            [objs enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                SettlementAuditModel *model = (SettlementAuditModel *)obj;
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
