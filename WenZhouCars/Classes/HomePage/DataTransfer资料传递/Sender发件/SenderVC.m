#import "SenderVC.h"
#import "SenderTableView.h"
#import "SelectedListView.h"
#import "WSDatePickerView.h"
@interface SenderVC ()<RefreshDelegate,BaseModelDelegate>
{
    NSString *select;
    NSString *dkey;
}
@property (nonatomic , strong)SenderTableView *tableView;
@end
@implementation SenderVC
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"发件";
    [self initTableView];
}
- (void)initTableView {
    self.tableView = [[SenderTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    self.tableView.backgroundColor = kBackgroundColor;
    self.tableView.model = self.model;
    [self.view addSubview:self.tableView];
}
-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.tableView.distributionStr isEqualToString:@"快递"]) {
        if (indexPath.section == 1) {
            if (indexPath.row == 0) {
                select = @"0";
                BaseModel *model = [BaseModel new];
                model.ModelDelegate = self;
                [model ReturnsParentKeyAnArray:@"send_type"];
            }else
            {
                select = @"1";
                BaseModel *model = [BaseModel new];
                model.ModelDelegate = self;
                [model ReturnsParentKeyAnArray:@"kd_company"];
            }
        }
        if (indexPath.section == 3)
        {
            [self selectTime];
        }
    }
    else
    {
        if (indexPath.section == 1) {
            if (indexPath.row == 0) {
                select = @"0";
                BaseModel *model = [BaseModel new];
                model.ModelDelegate = self;
                [model ReturnsParentKeyAnArray:@"send_type"];
            }else
            {
                [self selectTime];
            }
        }
    }
}
-(void)selectTime
{
    WSDatePickerView *datepicker = [[WSDatePickerView alloc] initWithDateStyle:DateStyleShowYearMonthDayHourMinute CompleteBlock:^(NSDate *selectDate) {
        self.tableView.date = [selectDate stringWithFormat:@"yyyy-MM-dd HH:mm:00"];
        NSLog(@"%@",self.tableView.date);
        [self.tableView reloadData];
    }];
    datepicker.dateLabelColor = MainColor;
    datepicker.datePickerColor = [UIColor blackColor];
    datepicker.doneButtonColor = MainColor;
    [datepicker show];
}
-(void)TheReturnValueStr:(NSString *)Str selectDic:(NSDictionary *)dic selectSid:(NSInteger)sid
{
    if ([select isEqualToString:@"0"]) {
        self.tableView.distributionStr = Str;
        dkey = dic[@"dkey"];
        [self.tableView reloadData];
    }else
    {
        NSLog(@"%@",dic);
        self.tableView.CourierCompanyStr = Str;
        dkey = dic[@"dkey"];
        [self.tableView reloadData];
    }
}
-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index
{
    UITextField *textFid1 = [self.view viewWithTag:100];
    UITextField *textFid2 = [self.view viewWithTag:101];
    if ([self.tableView.date isEqualToString:@""]) {
        [TLAlert alertWithInfo:@"请选择发货时间"];
        return;
    }
    if ([self.tableView.distributionStr isEqualToString:@""]) {
        [TLAlert alertWithInfo:@"请选择寄送方式"];
        return;
    }
    if ([self.tableView.distributionStr isEqualToString:@"快递"]) {
        if ([self.tableView.CourierCompanyStr isEqualToString:@""]) {
            [TLAlert alertWithInfo:@"请选择快递公司"];
            return;
        }
        if ([textFid1.text isEqualToString:@""]) {
            [TLAlert alertWithInfo:@"请输入快递单号"];
            return;
        }
    }
    TLNetworking *http = [TLNetworking new];
    http.code = @"632150";
    http.showView = self.view;
    http.parameters[@"code"] = _model.code;
    NSArray *codeList = @[_model.code];
    http.parameters[@"codeList"] = codeList;
    http.parameters[@"operator"] = [USERDEFAULTS objectForKey:USER_ID];
    http.parameters[@"updater"] = [USERDEFAULTS objectForKey:USER_ID];
    http.parameters[@"sendDatetime"] = self.tableView.date;
    http.parameters[@"sendFileList"] = @"0";
    http.parameters[@"typeList"] = @[@"1",@"3"];
    if ([self.tableView.distributionStr isEqualToString:@"快递"]) {
        http.parameters[@"sendType"] = @"2";
    }else
    {
        http.parameters[@"sendType"] = @"1";
    }
    http.parameters[@"sendNote"] = textFid2.text;
    if ([self.tableView.distributionStr isEqualToString:@"快递"]) {
        http.parameters[@"logisticsCompany"] = dkey;
        http.parameters[@"logisticsCode"] = textFid1.text;
    }
    [http postWithSuccess:^(id responseObject) {
        [TLAlert alertWithSucces:@"发件成功"];
        NSNotification *notification =[NSNotification notificationWithName:LOADDATAPAGE object:nil userInfo:nil];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSError *error) {
        WGLog(@"%@",error);
    }];
}
@end
