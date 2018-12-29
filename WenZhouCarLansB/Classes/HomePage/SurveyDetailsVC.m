//
//  SurveyDetailsVC.m
//  CarLoans
//
//  Created by QinBao Zheng on 2018/7/31.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "SurveyDetailsVC.h"
#import "SurveyDetailsTableView.h"

#import "SurveyInformationVC.h"

#import "SurveyDetailsModel.h"

@interface SurveyDetailsVC ()<RefreshDelegate>
@property (nonatomic , strong)SurveyDetailsTableView *tableView;
@property (nonatomic , strong)SurveyDetailsModel *model;
@end

@implementation SurveyDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"征信详情";
    [self initTableView];
    [self loadData];
}

- (void)initTableView {
    self.tableView = [[SurveyDetailsTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    self.tableView.backgroundColor = kBackgroundColor;
//    self.tableView.model = _surveyModel;
    [self.view addSubview:self.tableView];

}

-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index
{
    SurveyInformationVC *vc = [SurveyInformationVC new];
    vc.dataDic = self.model.creditUserList[index - 123];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)loadData
{
    ProjectWeakSelf;
    TLNetworking *http = [TLNetworking new];
    http.code = @"632117";
    http.showView = self.view;
    http.parameters[@"code"] = _code;

    [http postWithSuccess:^(id responseObject) {
        self.model = [SurveyDetailsModel mj_objectWithKeyValues:responseObject[@"data"]];
        weakSelf.tableView.surveyDetailsModel = self.model;
        [weakSelf.tableView reloadData];


    } failure:^(NSError *error) {
        WGLog(@"%@",error);
    }];
}

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
