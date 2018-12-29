//
//  InstallationDetailsVC.m
//  CarLoans
//
//  Created by QinBao Zheng on 2018/8/9.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "InstallationDetailsVC.h"
#import "InstallationDetailsTableView.h"
@interface InstallationDetailsVC ()<RefreshDelegate>


@property (nonatomic , strong)InstallationDetailsTableView *tableView;

@end

@implementation InstallationDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"安装详情";
    [self LoadData];

    [self initTableView];
}
- (void)initTableView {
    self.tableView = [[InstallationDetailsTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    self.tableView.model = self.model;
    self.tableView.backgroundColor = kBackgroundColor;
    self.tableView.model = self.model;

    [self.view addSubview:self.tableView];
}

-(void)LoadData
{
    TLNetworking *http = [TLNetworking new];
    http.code = @"632146";
    http.showView = self.view;
    http.parameters[@"code"] = _model.code;
    [http postWithSuccess:^(id responseObject) {

        self.tableView.detailsModel = [GPSInstallationDetailsModel mj_objectWithKeyValues:responseObject[@"data"]];
        [self.tableView reloadData];

    } failure:^(NSError *error) {
        WGLog(@"%@",error);
    }];
}


@end
