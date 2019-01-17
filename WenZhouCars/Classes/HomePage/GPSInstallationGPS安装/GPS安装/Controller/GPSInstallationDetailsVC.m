#import "GPSInstallationDetailsVC.h"
#import "GPSInstallationDetailsTableView.h"
#import "AddGPSInstallationVC.h"
#import "WSDatePickerView.h"
@interface GPSInstallationDetailsVC ()<RefreshDelegate,BaseModelDelegate>
{
    NSMutableArray *gpsAzListArray;
    NSInteger isSelect;
    NSString *date;
    NSString *code;
    NSString *gpsDevNo;
    NSString *azLocation;
}
@property (nonatomic , strong)NSArray *dataArray;
@property (nonatomic , strong)GPSInstallationDetailsTableView *tableView;
@end
@implementation GPSInstallationDetailsVC
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"安装回录";
    gpsAzListArray= [NSMutableArray array];
    [self initTableView];
}
- (void)initTableView {
    self.tableView = [[GPSInstallationDetailsTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    self.tableView.backgroundColor = kBackgroundColor;
    self.tableView.model = self.model;
    for (int i = 0; i < self.model.budgetOrderGpsList.count; i ++) {
        [gpsAzListArray addObject:self.model.budgetOrderGpsList[i]];
    }
    self.tableView.peopleAray = gpsAzListArray;
    [self.view addSubview:self.tableView];
}
-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
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
    if (isSelect == 0) {
        code = _dataArray[sid][@"code"];
        gpsDevNo = _dataArray[sid][@"gpsDevNo"];
        self.tableView.GPS = _dataArray[sid][@"gpsDevNo"];
        [self.tableView reloadData];
    }else
    {
        azLocation = dic[@"dkey"];
        self.tableView.location = Str;
        [self.tableView reloadData];
    }
}
-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index selectRowState:(NSString *)state
{
    [gpsAzListArray removeObjectAtIndex:index];
    self.tableView.peopleAray = gpsAzListArray;
    [self.tableView reloadData];
}
-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index
{
    UITextField *textField1 = [self.view viewWithTag:100];
    UITextField *textField2 = [self.view viewWithTag:101];
    if ([BaseModel isBlankString:code] == YES) {
        [TLAlert alertWithInfo:@"请选择GPS"];
        return;
    }
    if ([BaseModel isBlankString:azLocation] == YES) {
        [TLAlert alertWithInfo:@"请选择安装位置"];
        return;
    }
    if ([BaseModel isBlankString:date] == YES) {
        [TLAlert alertWithInfo:@"请选择安装时间"];
        return;
    }
    TLNetworking *http = [TLNetworking new];
    http.code = @"632342";
    http.showView = self.view;
    http.parameters[@"code"] = _model.code;
    http.parameters[@"gpsCode"] = code;
    http.parameters[@"azLocation"] = azLocation;
    http.parameters[@"azDatetime"] = date;
    http.parameters[@"azUser"] = textField1.text;
    http.parameters[@"remark"] = textField2.text;
    http.parameters[@"budgetOrder"] = _model.code;
    http.parameters[@"operator"] = [USERDEFAULTS objectForKey:USER_ID];
    http.parameters[@"updater"] = [USERDEFAULTS objectForKey:USER_ID];
    http.parameters[@"gpsAzList"] = _model.budgetOrderGpsList;
    http.parameters[@"budgetOrderGpsList"] = _model.budgetOrderGpsList;
    [http postWithSuccess:^(id responseObject) {
        [TLAlert alertWithSucces:@"安装成功"];
        NSNotification *notification =[NSNotification notificationWithName:LOADDATAPAGE object:nil userInfo:nil];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSError *error) {
        WGLog(@"%@",error);
    }];
}
@end
