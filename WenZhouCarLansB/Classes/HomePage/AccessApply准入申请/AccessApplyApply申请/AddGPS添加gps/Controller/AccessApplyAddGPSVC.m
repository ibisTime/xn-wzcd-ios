//
//  AccessApplyAddGPSVC.m
//  WenZhouCarLansB
//
//  Created by QinBao Zheng on 2018/9/10.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "AccessApplyAddGPSVC.h"
#import "AccessApplyAddGPSTableView.h"
@interface AccessApplyAddGPSVC ()<RefreshDelegate,BaseModelDelegate>
{
    NSInteger isSelect;
    NSString *code;
    NSString *gpsDevNo;
    NSString *azLocation;
    NSDictionary *gpsDic;
}
@property (nonatomic , strong)AccessApplyAddGPSTableView *tableView;

@property (nonatomic , strong)NSArray *dataArray;

@end

@implementation AccessApplyAddGPSVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"添加GPS";
    [self initTableView];

}

- (void)initTableView {
    self.tableView = [[AccessApplyAddGPSTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    self.tableView.backgroundColor = kBackgroundColor;
    [self.view addSubview:self.tableView];
}

-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    isSelect = indexPath.row;
    if (indexPath.row == 0) {
        TLNetworking *http = [TLNetworking new];
        http.code = @"632707";
        http.showView = self.view;
        http.parameters[@"applyStatus"] = @"2";
        http.parameters[@"companyApplyStatus"] = @"1";
        http.parameters[@"companyCode"] = [USERDEFAULTS objectForKey:USERDATA][@"companyCode"];
        http.parameters[@"useStatus"] = @"0";


        [http postWithSuccess:^(id responseObject) {
            self.dataArray = responseObject[@"data"];
            if (self.dataArray.count == 0) {
                [TLAlert alertWithInfo:@"暂无设备"];
            }
            [self boundData];
        } failure:^(NSError *error) {
            WGLog(@"%@",error);
        }];
    }else
    {
        BaseModel *model = [BaseModel new];
        model.ModelDelegate = self;
        [model ReturnsParentKeyAnArray:@"az_location"];
    }

}


-(void)boundData
{
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *dic in self.dataArray) {
        [array addObject:dic[@"gpsDevNo"]];
        BaseModel *model = [BaseModel new];
        model.ModelDelegate = self;
        [model CustomBouncedView:array setState:@"100"];
    }
}

//弹框代理方法
-(void)TheReturnValueStr:(NSString *)Str selectDic:(NSDictionary *)dic selectSid:(NSInteger)sid
{
    if (isSelect == 0) {
        self.tableView.GPS = _dataArray[sid][@"gpsDevNo"];
        gpsDic = _dataArray[sid];
        [self.tableView reloadData];
    }else
    {
        azLocation = dic[@"dkey"];
        self.tableView.location = Str;
        [self.tableView reloadData];
    }

}
-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index
{
    if ([BaseModel isBlankString:self.tableView.GPS] == YES) {
        [TLAlert alertWithInfo:@"请选择GPS"];
        return;
    }
    if ([BaseModel isBlankString:azLocation] == YES) {
        [TLAlert alertWithInfo:@"请选择安装位置"];
        return;
    }
    NSDictionary *dic = @{@"code":gpsDic[@"code"],
                          @"gpsDevNo":gpsDic[@"gpsDevNo"],
                          @"gpsType":gpsDic[@"gpsType"],
                          @"azLocation":azLocation,
                          @"updater":gpsDic[@"applyUser"]
                                   };
    NSDictionary *dataDic = @{
                              @"dkey":azLocation,
                              @"gps":dic
                            };
    NSNotification *notification =[NSNotification notificationWithName:@"ACCRESSADDGPS" object:nil userInfo:dataDic];
    [[NSNotificationCenter defaultCenter] postNotification:notification];
    [self.navigationController popViewControllerAnimated:YES];

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
