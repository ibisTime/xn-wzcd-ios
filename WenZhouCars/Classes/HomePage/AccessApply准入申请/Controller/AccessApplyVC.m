#import "AccessApplyVC.h"
#import "AccessApplyTableView.h"
#import "AccessApplyModel.h"
#import "AccessApplyApplyVC.h"
#import "AccrssApplyDetailsVC.h"
@interface AccessApplyVC ()<RefreshDelegate>
@property (nonatomic, strong)AccessApplyTableView *tableView;
@property (nonatomic , strong)NSMutableArray <AccessApplyModel *>*model;
@end
@implementation AccessApplyVC
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTableView];
    [self LoadData];
    self.title = @"贷前准入";
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
    self.tableView = [[AccessApplyTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    self.tableView.backgroundColor = kBackgroundColor;
    [self.view addSubview:self.tableView];
}
-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AccrssApplyDetailsVC *vc = [AccrssApplyDetailsVC new];
    vc.model = self.model[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index
{
    AccessApplyApplyVC *vc = [AccessApplyApplyVC new];
    vc.model = self.model[index];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index selectRowState:(NSString *)state
{
    if ([state isEqualToString:@"select1"]) {
        AccessApplyApplyVC *vc = [AccessApplyApplyVC new];
        vc.model = self.model[index];
        vc.type = @"2";
        [self.navigationController pushViewController:vc animated:YES];
    }else
    {
        AccessApplyApplyVC *vc = [AccessApplyApplyVC new];
        vc.model = self.model[index];
        vc.type = @"1";
        [self.navigationController pushViewController:vc animated:YES];
    }
}
-(void)LoadData
{
    ProjectWeakSelf;
    TLPageDataHelper *helper = [[TLPageDataHelper alloc] init];
    helper.code = @"632148";
    helper.parameters[@"roleCode"] = [USERDEFAULTS objectForKey:ROLECODE];
    helper.parameters[@"teamCode"] = [USERDEFAULTS objectForKey:TEAMCODE];
    helper.parameters[@"currentUserCompanyCode"] = [USERDEFAULTS objectForKey:USERDATA][@"companyCode"];
    helper.isList = NO;
    helper.isCurrency = YES;
    helper.tableView = self.tableView;
    [helper modelClass:[AccessApplyModel class]];
    [self.tableView addRefreshAction:^{
        [helper refresh:^(NSMutableArray *objs, BOOL stillHave) {
            NSMutableArray <AccessApplyModel *> *shouldDisplayCoins = [[NSMutableArray alloc] init];
            [objs enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                AccessApplyModel *model = (AccessApplyModel *)obj;
                [shouldDisplayCoins addObject:model];
            }];
            weakSelf.model = shouldDisplayCoins;
            weakSelf.tableView.model = shouldDisplayCoins;
            [weakSelf.tableView reloadData_tl];
        } failure:^(NSError *error) {
        }];
    }];
    [self.tableView addLoadMoreAction:^{
        helper.parameters[@"roleCode"] = [USERDEFAULTS objectForKey:ROLECODE];
        helper.parameters[@"teamCode"] = [USERDEFAULTS objectForKey:TEAMCODE];
        helper.parameters[@"currentUserCompanyCode"] = [USERDEFAULTS objectForKey:USERDATA][@"companyCode"];
        [helper loadMore:^(NSMutableArray *objs, BOOL stillHave) {
            NSLog(@" ==== %@",objs);
            NSMutableArray <AccessApplyModel *> *shouldDisplayCoins = [[NSMutableArray alloc] init];
            [objs enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                AccessApplyModel *model = (AccessApplyModel *)obj;
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
