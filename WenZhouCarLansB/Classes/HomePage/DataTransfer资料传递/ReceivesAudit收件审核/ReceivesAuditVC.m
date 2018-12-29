//
//  ReceivesAuditVC.m
//  CarLoans
//
//  Created by QinBao Zheng on 2018/8/8.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "ReceivesAuditVC.h"
#import "ReceivesAuditTableView.h"

@interface ReceivesAuditVC ()<RefreshDelegate>

@property (nonatomic , strong)ReceivesAuditTableView *tableView;

@end

@implementation ReceivesAuditVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"收件";
    [self initTableView];
}

- (void)initTableView {
    self.tableView = [[ReceivesAuditTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    self.tableView.backgroundColor = kBackgroundColor;
    self.tableView.model = self.model;
    [self.view addSubview:self.tableView];
}

-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index
{
    UITextField *textField = [self.view viewWithTag:100];

    TLNetworking *http = [TLNetworking new];
    if (index == 0) {
        http.code = @"632151";
    }else
    {
        http.code = @"632152";
    }
    http.showView = self.view;
    http.parameters[@"code"] = _model.code;
    http.parameters[@"operator"] = [USERDEFAULTS objectForKey:USER_ID];
    http.parameters[@"updater"] = [USERDEFAULTS objectForKey:USER_ID];
    http.parameters[@"remark"] = textField.text;
    http.parameters[@"codeList"] = @[_model.code];
    [http postWithSuccess:^(id responseObject) {
        [TLAlert alertWithSucces:@"收件成功"];
        NSNotification *notification =[NSNotification notificationWithName:LOADDATAPAGE object:nil userInfo:nil];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
        [self.navigationController popViewControllerAnimated:YES];

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
