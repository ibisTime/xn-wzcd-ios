//
//  ApplyCancellationVC.m
//  CarLoans
//
//  Created by QinBao Zheng on 2018/7/30.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "ApplyCancellationVC.h"
#import "ApplyCancellationTableView.h"
#import "AccessSingleVC.h"
#import "AccessSingleModel.h"
@interface ApplyCancellationVC ()<RefreshDelegate>

@property (nonatomic , strong)AccessSingleModel *model;

@property (nonatomic , strong)ApplyCancellationTableView *tableView;

@end

@implementation ApplyCancellationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"申请";
    [self initTableView];
//    [self LoadData];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(InfoNotificationAction:) name:ApplyForCancellation object:nil];
}
#pragma mark -- 接收到通知
- (void)InfoNotificationAction:(NSNotification *)notification{

    _model = notification.userInfo[@"userInfo"];
    self.tableView.model = notification.userInfo[@"userInfo"];

}
#pragma mark -- 删除通知
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:ApplyForCancellation object:nil];
}

- (void)initTableView {
    self.tableView = [[ApplyCancellationTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    self.tableView.backgroundColor = kBackgroundColor;
    [self.view addSubview:self.tableView];
}

-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        AccessSingleVC *vc = [[AccessSingleVC alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index
{

    if ([BaseModel isBlankString:_model.code] == YES) {
        [TLAlert alertWithInfo:@"请选择准入单"];
        return;
    }
    UITextField *textField = [self.view viewWithTag:100];
    if ([textField.text isEqualToString:@""]) {
        [TLAlert alertWithInfo:@"请输入作废原因"];
        return;
    }
    TLNetworking *http = [TLNetworking new];
    http.code = @"632270";
    http.showView = self.view;
    http.parameters[@"code"] = _model.code;
    http.parameters[@"zfReason"] = textField.text;
    http.parameters[@"updater"] = [USERDEFAULTS objectForKey:USERDATA][@"updater"];
    http.parameters[@"operator"] = [USERDEFAULTS objectForKey:USER_ID];

    [http postWithSuccess:^(id responseObject) {
        [TLAlert alertWithSucces:@"提交成功"];
        NSNotification *notification =[NSNotification notificationWithName:LOADDATAPAGE object:nil userInfo:nil];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSError *error) {
        WGLog(@"%@",error);
    }];
}


@end
