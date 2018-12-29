//
//  BankLendingVC.m
//  CarLoans
//
//  Created by QinBao Zheng on 2018/8/6.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "BankLendingVC.h"
#import "BankLendingTableView.h"
#import "AccessSingleModel.h"
#import "BankLendingDetailsVC.h"
#import "SendListOfLendingVC.h"
@interface BankLendingVC ()
<RefreshDelegate>
@property (nonatomic , strong)BankLendingTableView *tableView;

@property (nonatomic , strong)NSMutableArray <AccessSingleModel *>*model;
@end

@implementation BankLendingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"银行放款";
    [self initTableView];
    [self LoadData];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(InfoNotificationAction:) name:LOADDATAPAGE object:nil];
}
#pragma mark -- 接收到通知
- (void)InfoNotificationAction:(NSNotification *)notification
{
    [self LoadData];
}

#pragma mark -- 删除通知
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:LOADDATAPAGE object:nil];
}

- (void)initTableView {
    self.tableView = [[BankLendingTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    self.tableView.backgroundColor = kBackgroundColor;
//    self.tableView.model = self.model;
    [self.view addSubview:self.tableView];
}

-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index
{
    if ([self.model[index].curNodeCode
         isEqualToString:@"007_07"])
    {
        SendListOfLendingVC *vc =[SendListOfLendingVC new];
        vc.model = self.model[index];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else
    {
        BankLendingDetailsVC *vc = [[BankLendingDetailsVC alloc]init];
        vc.model = self.model[index];
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
    NSArray *array = @[@"008_01",@"008_02",@"008_03",@"008_04",@"008_05",@"008_06",@"009_01",@"009_02",@"009_03",@"009_04",@"009_05",@"009_06",@"009_07",@"009_08",@"009_09",@"009_10"];
    helper.parameters[@"pledgeCurNodeCodeList"] = array;
    helper.isList = NO;
    helper.isCurrency = YES;
    helper.tableView = self.tableView;
    [helper modelClass:[AccessSingleModel class]];

    [self.tableView addRefreshAction:^{

        [helper refresh:^(NSMutableArray *objs, BOOL stillHave) {

            //去除没有的币种
            NSMutableArray <AccessSingleModel *> *shouldDisplayCoins = [[NSMutableArray alloc] init];
            [objs enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {

                AccessSingleModel *model = (AccessSingleModel *)obj;
                [shouldDisplayCoins addObject:model];

            }];

            //
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
        NSArray *array = @[@"008_01",@"008_02",@"008_03",@"008_04",@"008_05",@"008_06",@"009_01",@"009_02",@"009_03",@"009_04",@"009_05",@"009_06",@"009_07",@"009_08",@"009_09",@"009_10"];
        helper.parameters[@"pledgeCurNodeCodeList"] = array;
        [helper loadMore:^(NSMutableArray *objs, BOOL stillHave) {
            NSLog(@" ==== %@",objs);
            //去除没有的币种
            NSMutableArray <AccessSingleModel *> *shouldDisplayCoins = [[NSMutableArray alloc] init];
            [objs enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {

                AccessSingleModel *model = (AccessSingleModel *)obj;
                //                if ([[CoinUtil shouldDisplayCoinArray] indexOfObject:currencyModel.currency ] != NSNotFound ) {

                [shouldDisplayCoins addObject:model];
                //                }

            }];

            //
            weakSelf.model = shouldDisplayCoins;
            weakSelf.tableView.model = shouldDisplayCoins;
            [weakSelf.tableView reloadData_tl];

        } failure:^(NSError *error) {
        }];
    }];
    [self.tableView beginRefreshing];
}


@end
