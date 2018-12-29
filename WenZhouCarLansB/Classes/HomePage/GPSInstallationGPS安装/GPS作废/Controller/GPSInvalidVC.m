//
//  GPSInvalidVC.m
//  WenZhouCarLansB
//
//  Created by QinBao Zheng on 2018/9/5.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "GPSInvalidVC.h"
#import "GPSInvalidTableView.h"
@interface GPSInvalidVC ()<RefreshDelegate,BaseModelDelegate>
{
    NSString *code;
    NSString *gpsDevNo;

}
@property (nonatomic , strong)GPSInvalidTableView *tableView;
@property (nonatomic , strong)NSArray *dataArray;

@end

@implementation GPSInvalidVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initTableView];
    self.title = @"回收作废";
}

- (void)initTableView {
    self.tableView = [[GPSInvalidTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    self.tableView.backgroundColor = kBackgroundColor;
    self.tableView.model = self.model;
    [self.view addSubview:self.tableView];
}

-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {


            TLNetworking *http = [TLNetworking new];
            http.code = @"632707";
            http.showView = self.view;
            http.parameters[@"applyStatus"] = @"2";
            http.parameters[@"companyApplyStatus"] = @"1";
            http.parameters[@"companyCode"] = [USERDEFAULTS objectForKey:USERDATA][@"companyCode"];
            http.parameters[@"useStatus"] = @"1";
            http.parameters[@"bizCode"] = _model.code;


            [http postWithSuccess:^(id responseObject) {
                self.dataArray = responseObject[@"data"];
                if (self.dataArray.count == 0) {
                    [TLAlert alertWithInfo:@"暂无设备"];
                }
                NSMutableArray *array = [NSMutableArray array];
                for (NSDictionary *dic in self.dataArray) {
                    [array addObject:dic[@"gpsDevNo"]];
                    BaseModel *model = [BaseModel new];
                    model.ModelDelegate = self;
                    [model CustomBouncedView:array setState:@"100"];
                }

            } failure:^(NSError *error) {
                WGLog(@"%@",error);
            }];


    }
}

-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index
{
    UITextField *textField1 = [self.view viewWithTag:100];
    if ([BaseModel isBlankString:code] == YES) {
        [TLAlert alertWithInfo:@"请选择GPS"];
        return;
    }

    
    TLNetworking *http = [TLNetworking new];
    http.code = @"632343";
    http.showView = self.view;
    http.parameters[@"code"] = code;
    http.parameters[@"Gpscode"] = code;
    http.parameters[@"budgetOrderGpsList"] = _model.budgetOrderGpsList;
    http.parameters[@"remark"] = textField1.text;
    http.parameters[@"operator"] = [USERDEFAULTS objectForKey:USER_ID];
    http.parameters[@"updater"] = [USERDEFAULTS objectForKey:USER_ID];

    [http postWithSuccess:^(id responseObject) {
        [TLAlert alertWithSucces:@"作废成功"];
        NSNotification *notification =[NSNotification notificationWithName:LOADDATAPAGE object:nil userInfo:nil];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
        [self.navigationController popViewControllerAnimated:YES];

    } failure:^(NSError *error) {
        WGLog(@"%@",error);
    }];

}

-(void)TheReturnValueStr:(NSString *)Str selectDic:(NSDictionary *)dic selectSid:(NSInteger)sid
{
    code = self.dataArray[sid][@"code"];
    NSLog(@"%@",code);
    gpsDevNo = self.dataArray[sid][@"gpsDevNo"];
    self.tableView.GPS = self.dataArray[sid][@"gpsDevNo"];
    [self.tableView reloadData];
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
