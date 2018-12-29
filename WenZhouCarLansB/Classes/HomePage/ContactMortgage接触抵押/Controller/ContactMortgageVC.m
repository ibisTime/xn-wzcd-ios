//
//  ContactMortgageVC.m
//  WenZhouCarLansB
//
//  Created by QinBao Zheng on 2018/9/13.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "ContactMortgageVC.h"

#import "SettlementAuditModel.h"
#import "HistoryUserTableView.h"
#import "HistoryUserDetailsVC.h"
@interface ContactMortgageVC ()<RefreshDelegate>

@property (nonatomic , strong)NSMutableArray <SettlementAuditModel *>*model;
@property (nonatomic , strong)HistoryUserTableView *tableView;

@end

@implementation ContactMortgageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"接触抵押";
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
    helper.parameters[@"curNodeCodeList"] = @[@"020_02",@"020_03",@"020_04",@"020_05",@"020_06",@"020_07",@"020_08",@"020_09"];
    helper.parameters[@"teamCode"] = [USERDEFAULTS objectForKey:TEAMCODE];
    helper.parameters[@"roleCode"] = [USERDEFAULTS objectForKey:ROLECODE];
    helper.isList = NO;
    helper.isCurrency = YES;
    helper.tableView = self.tableView;
    [helper modelClass:[SettlementAuditModel class]];

    [self.tableView addRefreshAction:^{

        [helper refresh:^(NSMutableArray *objs, BOOL stillHave) {

            //去除没有的币种
            NSLog(@" ==== %@",objs);

            NSMutableArray <SettlementAuditModel *> *shouldDisplayCoins = [[NSMutableArray alloc] init];
            [objs enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {

                SettlementAuditModel *model = (SettlementAuditModel *)obj;
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

        helper.parameters[@"curNodeCodeList"] = @[@"020_02",@"020_03",@"020_04",@"020_05",@"020_06",@"020_07",@"020_08",@"020_09"];
        helper.parameters[@"teamCode"] = [USERDEFAULTS objectForKey:TEAMCODE];
        helper.parameters[@"roleCode"] = [USERDEFAULTS objectForKey:ROLECODE];
        [helper loadMore:^(NSMutableArray *objs, BOOL stillHave) {
            NSLog(@" ==== %@",objs);
            //去除没有的币种
            NSMutableArray <SettlementAuditModel *> *shouldDisplayCoins = [[NSMutableArray alloc] init];
            [objs enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {

                SettlementAuditModel *model = (SettlementAuditModel *)obj;
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
