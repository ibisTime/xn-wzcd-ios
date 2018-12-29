//
//  GPSClaimsDetailsVC.m
//  CarLoans
//
//  Created by QinBao Zheng on 2018/8/2.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "GPSClaimsDetailsVC.h"
#import "GPSClaimsDetailsTableView.h"

@interface GPSClaimsDetailsVC ()<RefreshDelegate>

@property (nonatomic , strong)GPSClaimsDetailsTableView *tableView;

@end

@implementation GPSClaimsDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"详情";
    [self initTableView];
}

- (void)initTableView {
    self.tableView = [[GPSClaimsDetailsTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    self.tableView.backgroundColor = kBackgroundColor;
    self.tableView.model = self.model;
    [self.view addSubview:self.tableView];
}

-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

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
