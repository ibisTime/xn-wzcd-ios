//
//  BankCreditReportVC.m
//  WenZhouCarLansB
//
//  Created by QinBao Zheng on 2018/9/10.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "BankCreditReportVC.h"
#import "BankCreditReportTableView.h"
@interface BankCreditReportVC ()<RefreshDelegate>

@property (nonatomic , strong)BankCreditReportTableView *tableView;

@end

@implementation BankCreditReportVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"征信报告";
    [self initTableView];
}

- (void)initTableView {
    self.tableView = [[BankCreditReportTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    self.tableView.backgroundColor = kBackgroundColor;
    self.tableView.model = [SurvuyPeopleModel mj_objectWithKeyValues:_dataDic];
    [self.view addSubview:self.tableView];
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
