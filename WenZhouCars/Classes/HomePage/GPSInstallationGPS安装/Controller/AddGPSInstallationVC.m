#import "AddGPSInstallationVC.h"
#import "AddGPSInstallationTableView.h"
#import "WSDatePickerView.h"
@interface AddGPSInstallationVC ()<RefreshDelegate,BaseModelDelegate>
{
    NSString *date;
    NSString *code;
    NSString *gpsDevNo;
}
@property (nonatomic , strong)AddGPSInstallationTableView *tableView;
@property (nonatomic , strong)NSArray *dataArray;
@end
@implementation AddGPSInstallationVC
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"添加GPS";
    date = @"";
    code = @"";
    [self initTableView];
    NSLog(@"%@",_dataDic);
    if (self.isSelect == 100) {
        date = _dataDic[@"dic"][@"azDatetime"];
        code = _dataDic[@"dic"][@"code"];
        gpsDevNo = _dataDic[@"gpsDevNo"];
        self.tableView.GPS = _dataDic[@"gpsDevNo"];
        self.tableView.date = _dataDic[@"dic"][@"azDatetime"];
        self.tableView.isSelect = self.isSelect;
        self.tableView.Str1 = _dataDic[@"dic"][@"azLocation"];
        self.tableView.Str2 = _dataDic[@"dic"][@"azUser"];
        self.tableView.Str3 = _dataDic[@"dic"][@"remark"];
        [self.tableView reloadData];
    }
}
- (void)initTableView {
    self.tableView = [[AddGPSInstallationTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    self.tableView.backgroundColor = kBackgroundColor;
    [self.view addSubview:self.tableView];
}
-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index
{
    UITextField *textField1 = [self.view viewWithTag:100];
    UITextField *textField2 = [self.view viewWithTag:101];
    UITextField *textField3 = [self.view viewWithTag:102];
    if ([code isEqualToString:@""]) {
        [TLAlert alertWithInfo:@"请选择GPS设备"];
        return;
    }
    if ([textField1.text isEqualToString:@""]) {
        [TLAlert alertWithInfo:@"请输入安装位置"];
        return;
    }
    if ([date isEqualToString:@""]) {
        [TLAlert alertWithInfo:@"请选择安装时间"];
        return;
    }
    if ([textField2.text isEqualToString:@""]) {
        [TLAlert alertWithInfo:@"请输入安装人员"];
        return;
    }
    NSDictionary *data = @{@"code":code,
                           @"azLocation":textField1.text,
                           @"azDatetime":date,
                           @"azUser":textField2.text,
                           @"remark":textField3.text};
    NSDictionary *dic = @{
                          @"dic":data,
                          @"gpsDevNo":gpsDevNo
                        };
    NSNotification *notification =[NSNotification notificationWithName:ADDGPS object:nil userInfo:dic];
    [[NSNotificationCenter defaultCenter] postNotification:notification];
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        TLNetworking *http = [TLNetworking new];
        http.code = @"632707";
        http.showView = self.view;
        http.parameters[@"applyUser"] = [USERDEFAULTS objectForKey:USER_ID];
        http.parameters[@"applyStatus"] = @"1";
        http.parameters[@"useStatus"] = @"0";
        http.parameters[@"operator"] = [USERDEFAULTS objectForKey:USER_ID];
        [http postWithSuccess:^(id responseObject) {
            self.dataArray = responseObject[@"data"];
            if (self.dataArray.count == 0) {
                [TLAlert alertWithInfo:@"暂无设备"];
            }
            [self boundData];
        } failure:^(NSError *error) {
            WGLog(@"%@",error);
        }];
    }
    if (indexPath.section == 2) {
        WSDatePickerView *datepicker = [[WSDatePickerView alloc] initWithDateStyle:DateStyleShowYearMonthDay CompleteBlock:^(NSDate *selectDate) {
            date = [selectDate stringWithFormat:@"yyyy-MM-dd"];
            self.tableView.date = date;
            [self.tableView reloadData];
        }];
        datepicker.dateLabelColor = MainColor;
        datepicker.datePickerColor = [UIColor blackColor];
        datepicker.doneButtonColor = MainColor;
        [datepicker show];
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
-(void)TheReturnValueStr:(NSString *)Str selectDic:(NSDictionary *)dic selectSid:(NSInteger)sid
{
    for (int i = 0; i < self.gpsArray.count; i ++) {
        if (self.isSelect >= 100) {
            if ([_dataDic[@"dic"][@"code"] isEqualToString:self.gpsArray[i][@"code"]]) {
            }else
            {
                if ([self.gpsArray[i][@"code"] isEqualToString:_dataArray[sid][@"code"]]) {
                    [TLAlert alertWithInfo:@"已添加过该GPS设备"];
                    return;
                }
            }
        }else
        {
            if ([self.gpsArray[i][@"code"] isEqualToString:_dataArray[sid][@"code"]]) {
                [TLAlert alertWithInfo:@"已添加过该GPS设备"];
                return;
            }
        }
    }
    code = _dataArray[sid][@"code"];
    gpsDevNo = _dataArray[sid][@"gpsDevNo"];
    self.tableView.GPS = _dataArray[sid][@"gpsDevNo"];
    [self.tableView reloadData];
}
@end
