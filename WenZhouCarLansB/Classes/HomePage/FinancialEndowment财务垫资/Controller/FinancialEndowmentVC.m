//
//  FinancialEndowmentVC.m
//  WenZhouCarLansB
//
//  Created by QinBao Zheng on 2018/9/4.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "FinancialEndowmentVC.h"
#import "AccessApplyTableView.h"
#import "AccessApplyModel.h"
#import "FinancialEndowmentDetailsVC.h"

@interface FinancialEndowmentVC ()<RefreshDelegate>

@property (nonatomic, strong)AccessApplyTableView *tableView;

@property (nonatomic , strong)NSMutableArray <AccessApplyModel *>*model;

@end

@implementation FinancialEndowmentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initTableView];
    [self LoadData];
    self.title = @"财务垫资";
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
    FinancialEndowmentDetailsVC *vc = [[FinancialEndowmentDetailsVC alloc]init];
    vc.surveyModel = _model[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index
{


}

-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index selectRowState:(NSString *)state
{

}



-(void)LoadData
{

    ProjectWeakSelf;

    TLPageDataHelper *helper = [[TLPageDataHelper alloc] init];
    helper.code = @"632185";
    helper.parameters[@"roleCode"] = [USERDEFAULTS objectForKey:ROLECODE];
    helper.parameters[@"teamCode"] = [USERDEFAULTS objectForKey:TEAMCODE];
    NSArray *array = @[@"003_04",@"003_05",@"003_07",@"004_04",@"004_05",@"004_06",@"004_08"];
    helper.parameters[@"curNodeCodeList"] = array;
    helper.parameters[@"currentUserCompanyCode"] = [USERDEFAULTS objectForKey:USERDATA][@"companyCode"];
    helper.isList = NO;
    helper.isCurrency = YES;
    helper.tableView = self.tableView;
    [helper modelClass:[AccessApplyModel class]];

    [self.tableView addRefreshAction:^{

        [helper refresh:^(NSMutableArray *objs, BOOL stillHave) {

            //去除没有的币种
            NSLog(@" ==== %@",objs);

            NSMutableArray <AccessApplyModel *> *shouldDisplayCoins = [[NSMutableArray alloc] init];
            [objs enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {

                AccessApplyModel *model = (AccessApplyModel *)obj;
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
        NSArray *array = @[@"003_04",@"003_05",@"003_07",@"004_04",@"004_05",@"004_06",@"004_08"];
        helper.parameters[@"curNodeCodeList"] = array;
        helper.parameters[@"currentUserCompanyCode"] = [USERDEFAULTS objectForKey:USERDATA][@"companyCode"];

        [helper loadMore:^(NSMutableArray *objs, BOOL stillHave) {
            NSLog(@" ==== %@",objs);
            //去除没有的币种
            NSMutableArray <AccessApplyModel *> *shouldDisplayCoins = [[NSMutableArray alloc] init];
            [objs enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {

                AccessApplyModel *model = (AccessApplyModel *)obj;
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
