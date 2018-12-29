//
//  FinancialEndowmentDetailsVC.m
//  WenZhouCarLansB
//
//  Created by QinBao Zheng on 2018/9/4.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "FinancialEndowmentDetailsVC.h"
#import "FinancialEndowmentDetailsTableView.h"
#import "SurveyDetailsVC.h"
@interface FinancialEndowmentDetailsVC ()<RefreshDelegate>

@property (nonatomic , strong)FinancialEndowmentDetailsTableView *tableView;

@end

@implementation FinancialEndowmentDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initTableView];
    self.title = @"垫资详情";
//    [self loadData];
}

- (void)initTableView {
    self.tableView = [[FinancialEndowmentDetailsTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    self.tableView.backgroundColor = kBackgroundColor;
    self.tableView.surveyModel = self.surveyModel;
    [self.view addSubview:self.tableView];
}

-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        SurveyDetailsVC *vc =[SurveyDetailsVC new];
        vc.code = self.surveyModel.budgetCode;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index
{


}

//-(void)loadData
//{
//    ProjectWeakSelf;
//    TLNetworking *http = [TLNetworking new];
//    http.code = @"632117";
//    http.showView = self.view;
//    http.parameters[@"code"] = _code;
//
//    [http postWithSuccess:^(id responseObject) {
//
//    } failure:^(NSError *error) {
//        WGLog(@"%@",error);
//    }];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
