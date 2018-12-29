//
//  AccessApplyApplyVC.m
//  WenZhouCarLansB
//
//  Created by QinBao Zheng on 2018/9/3.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "AccessApplyApplyVC.h"
#import "SelectedListView.h"
#import "LEEAlert.h"
#import "ApplyTableView1.h"
#import "ApplyTableView2.h"
#import "ApplyTableView3.h"
#import "ApplyTableView4.h"
#import "ApplyTableView5.h"
#import "ApplyTableView6.h"
#import "ApplyTableView7.h"
#import "ApplyTableView8.h"
#import "ApplyTableView9.h"
#import "ApplyTableView10.h"
#import "AccessApplyAddGPSVC.h"
@interface AccessApplyApplyVC ()<UIScrollViewDelegate,RefreshDelegate,BaseModelDelegate>
{
    NSInteger selectTableViewTag;
    NSInteger selectSection;
//银行数组
    NSArray *bankRateListArray;

    NSInteger selectCell;

    NSIndexPath *ReloadIndexPath;

}

@property (nonatomic, assign)NSInteger currentPages;
@property (nonatomic, assign)NSInteger selectRow;
@property (nonatomic, strong)UIScrollView *scroll;
@property (nonatomic, strong)NSArray *dvalueArray;
@property (nonatomic, strong)UIButton *titleBtn;
//汽车仅销售
@property (nonatomic , strong)NSArray *AfterSalesArray;

@property (nonatomic, strong)ApplyTableView1 *tableView1;
@property (nonatomic, strong)ApplyTableView2 *tableView2;
@property (nonatomic, strong)ApplyTableView3 *tableView3;
@property (nonatomic, strong)ApplyTableView4 *tableView4;
@property (nonatomic, strong)ApplyTableView5 *tableView5;
@property (nonatomic, strong)ApplyTableView6 *tableView6;
@property (nonatomic, strong)ApplyTableView7 *tableView7;
@property (nonatomic, strong)ApplyTableView8 *tableView8;
@property (nonatomic, strong)ApplyTableView9 *tableView9;
@property (nonatomic, strong)ApplyTableView10 *tableView10;

@property (nonatomic , strong)NSMutableArray *gpsArray;

@property (nonatomic , strong)TLImagePicker *imagePicker;

@end

@implementation AccessApplyApplyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.dvalueArray = @[@"预算单申请",@"职业与收入情况",@"资产情况",@"紧急联系人",@"其他情况",@"费用情况",@"贷款材料",@"家访材料",@"企业照片",@"其他材料"];
    self.gpsArray = [NSMutableArray array];
    [self navigativeView];
    [self initScrollView];
    [self initTableView1];
    [self initTableView2];
    [self initTableView3];
    [self initTableView4];
    [self initTableView5];
    [self initTableView6];
    [self initTableView7];
    [self initTableView8];
    [self initTableView9];
    [self initTableView10];

    bankRateListArray = self.model.bankSubbranch[@"bank"][@"bankRateList"];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(InfoNotificationAction:) name:@"ACCRESSADDGPS" object:nil];

    [self.gpsArray addObjectsFromArray:self.model.budgetOrderGpsList];
    self.tableView1.GPSArray = self.gpsArray;
    NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:17];
    [self.tableView1 reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
}
#pragma mark -- 接收到通知
- (void)InfoNotificationAction:(NSNotification *)notification{
    [self.gpsArray addObject:notification.userInfo[@"gps"]];
    self.tableView1.GPSArray = self.gpsArray;
    NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:17];
    [self.tableView1 reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark -- 删除通知
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"ACCRESSADDGPS" object:nil];
}

-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    ReloadIndexPath = [NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section]; //刷新第0段第2行
    BaseModel *model = [BaseModel new];
    model.ModelDelegate = self;
    switch (refreshTableview.tag - 100) {
        case 0:
        {
            if (indexPath.section == 1) {
                selectCell = 0;
                [model ReturnsParentKeyAnArray:@"gps_apply_type"];
            }
            if (indexPath.section == 2) {
                selectCell = 101;
                if (_AfterSalesArray.count > 0) {
                    BaseModel *model = [BaseModel new];
                    model.ModelDelegate = self;
                    NSMutableArray *array = [NSMutableArray array];
                    for (int i = 0; i < _AfterSalesArray.count; i ++) {
                        [array addObject:_AfterSalesArray[i][@"fullName"]];
                    }
                    [model CustomBouncedView:array setState:@"100"];
                }else
                {
//                    经销售请求
                    TLNetworking *http = [TLNetworking new];
                    http.isShowMsg = YES;
                    http.code = @"632067";
                    http.parameters[@"curNodeCode"] = @"006_03";
                    [http postWithSuccess:^(id responseObject) {
                        _AfterSalesArray = responseObject[@"data"];
                        BaseModel *model = [BaseModel new];
                        model.ModelDelegate = self;
                        NSMutableArray *array = [NSMutableArray array];
                        for (int i = 0; i < _AfterSalesArray.count; i ++) {
                            [array addObject:_AfterSalesArray[i][@"fullName"]];
                        }
                        [model CustomBouncedView:array setState:@"100"];
                    } failure:^(NSError *error) {

                    }];
                }
            }
            if (indexPath.section == 6) {
                selectCell = 1;
                NSMutableArray *array = [NSMutableArray array];
                for (int i = 0; i < bankRateListArray.count; i ++) {
                    [array addObject:[NSString stringWithFormat:@"%@期",bankRateListArray[i][@"period"]]];
                }
                NSLog(@"%@",bankRateListArray);
                [model CustomBouncedView:array setState:@"100"];
            }
            if (indexPath.section == 9) {
                selectCell = 2;
                [model ReturnsParentKeyAnArray:@"rate_type"];
            }
            if (indexPath.section == 13) {
                selectCell = 100;
                [self chooseWhetherOrNot:model];
            }
        }
            break;
        case 1:
        {
            if (indexPath.section == 2) {
                if (indexPath.row == 0) {
                    selectCell = 3;
                    [model ReturnsParentKeyAnArray:@"credit_user_relation"];
                }
                if (indexPath.row == 1) {
                    selectCell = 4;
                    [model ReturnsParentKeyAnArray:@"marry_state"];
                }
            }
            if (indexPath.section == 4) {
                if (indexPath.row == 0) {
                    selectCell = 5;
                    [self chooseWhetherOrNot:model];
                }
                if (indexPath.row == 1) {
                    selectCell = 6;
                     [self chooseWhetherOrNot:model];
                }
            }
            if (indexPath.section == 6 ) {
                if (indexPath.row == 0) {
                    selectCell = 7;
                    [self chooseWhetherOrNot:model];
                }
                if (indexPath.row == 1) {
                    selectCell = 8;
                    [self chooseWhetherOrNot:model];
                }
            }
            if (indexPath.section == 9) {
                if (indexPath.row == 0) {
                    selectCell = 9;
                    [self chooseWhetherOrNot:model];
                }
                if (indexPath.row == 1) {
                    selectCell = 10;
                    [self chooseWhetherOrNot:model];
                }
            }
            if (indexPath.section == 12) {
                if (indexPath.row == 0) {
                    selectCell = 11;
                    [self chooseWhetherOrNot:model];
                }
                if (indexPath.row == 1) {
                    selectCell = 12;
                    [self chooseWhetherOrNot:model];
                }
            }
        }
            break;
        case 2:
        {
            if (indexPath.section == 0) {
                selectCell = 13;
                [self chooseWithOrWithout:model];
            }
            if (indexPath.section == 1) {
                selectCell = 14;
                [self chooseWithOrWithout:model];
            }
            if (indexPath.section == 2) {
                selectCell = 15;
                [self chooseWithOrWithout:model];
            }
            if (indexPath.section == 3) {
                selectCell = 16;
                NSMutableArray *array = [NSMutableArray array];
                [array addObjectsFromArray:@[@"自有",@"租用",@"无"]];
                [model CustomBouncedView:array setState:@"100"];
            }
            if (indexPath.section == 4) {
                selectCell = 17;
                [self chooseWithOrWithout:model];
            }
        }
            break;
        case 3:
        {
            if (indexPath.section == 0) {
                if (indexPath.row == 1) {
                    selectCell = 18;
                    [model ReturnsParentKeyAnArray:@"emergency_contact_relation"];
                }
            }
            if (indexPath.section == 1) {
                if (indexPath.row == 1) {
                    selectCell = 19;
                    [model ReturnsParentKeyAnArray:@"emergency_contact_relation"];
                }
            }
        }
            break;
        case 4:
        {
            if (indexPath.section == 1) {
                selectCell = 20;
                NSMutableArray *array = [NSMutableArray array];
                [array addObjectsFromArray:@[@"自有",@"租用"]];
                [model CustomBouncedView:array setState:@"100"];
            }
        }
            break;
        case 5:
        {
            if (indexPath.section == 2) {
                selectCell = 21;
                [self chooseWhetherOrNot:model];
            }
            if (indexPath.section == 4) {
                if (indexPath.row == 0) {
                    selectCell = 22;
                    [model ReturnsParentKeyAnArray:@"gps_fee_way"];
                }
                if (indexPath.row == 1) {
                    selectCell = 23;
                    [model ReturnsParentKeyAnArray:@"fee_way"];
                }

            }
        }
            break;



        default:
            break;
    }
}

-(void)TheReturnValueStr:(NSString *)Str selectDic:(NSDictionary *)dic selectSid:(NSInteger)sid
{
    switch (selectCell) {
        case 0:
        {
//            客户类型
            [self.model setValue:dic[@"dkey"] forKey:@"customerType"];
            self.tableView1.model.customerType = self.model.customerType;
//            [self.tableView1 reloadData];
            [self.tableView1 reloadRowsAtIndexPaths:[NSArray arrayWithObjects:ReloadIndexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
        }
            break;
        case 1:
        {
//            贷款周期
            [self.model setValue:bankRateListArray[sid][@"period"] forKey:@"loanPeriods"];
            [self.model setValue:bankRateListArray[sid][@"rate"] forKey:@"bankRate"];

            self.tableView1.model = self.model;
            NSIndexPath *ReloadIndexPath1 = [NSIndexPath indexPathForRow:0 inSection:11]; //刷新
            [self.tableView1 reloadRowsAtIndexPaths:[NSArray arrayWithObjects:ReloadIndexPath1,nil] withRowAnimation:UITableViewRowAnimationNone];
            [self.tableView1 reloadRowsAtIndexPaths:[NSArray arrayWithObjects:ReloadIndexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
        }
            break;
        case 2:
        {
//            利率类型
            [self.model setValue:dic[@"dkey"] forKey:@"rateType"];
            self.tableView1.model = self.model;
            [self.tableView1 reloadRowsAtIndexPaths:[NSArray arrayWithObjects:ReloadIndexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
        }
            break;
        case 3:
        {
//            申请人共还人关系
            [self.model setValue:dic[@"dkey"] forKey:@"applyUserGhrRelation"];
            self.tableView2.model = self.model;
            [self.tableView2 reloadRowsAtIndexPaths:[NSArray arrayWithObjects:ReloadIndexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
        }
            break;
        case 4:
        {
            [self.model setValue:dic[@"dkey"] forKey:@"marryState"];
            self.tableView2.model = self.model;
            [self.tableView2 reloadRowsAtIndexPaths:[NSArray arrayWithObjects:ReloadIndexPath,nil] withRowAnimation:UITableViewRowAnimationNone];

        }
            break;
        case 5:
        {
            [self.model setValue:[self WhetherOrNot:Str] forKey:@"applyUserJourShowIncome"];
            self.tableView2.model = self.model;
            [self.tableView2 reloadRowsAtIndexPaths:[NSArray arrayWithObjects:ReloadIndexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
        }
            break;
        case 6:
        {
            [self.model setValue:[self WhetherOrNot:Str] forKey:@"applyUserJourShowIncome"];
            self.tableView2.model = self.model;
            [self.tableView2 reloadRowsAtIndexPaths:[NSArray arrayWithObjects:ReloadIndexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
        }
            break;
        case 7:
        {
            [self.model setValue:[self WhetherOrNot:Str] forKey:@"ghJourShowIncome"];
            self.tableView2.model = self.model;
            [self.tableView2 reloadRowsAtIndexPaths:[NSArray arrayWithObjects:ReloadIndexPath,nil] withRowAnimation:UITableViewRowAnimationNone];

        }
            break;
        case 8:
        {
            [self.model setValue:[self WhetherOrNot:Str] forKey:@"ghIsPrint"];
            self.tableView2.model = self.model;
            [self.tableView2 reloadRowsAtIndexPaths:[NSArray arrayWithObjects:ReloadIndexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
        }
            break;
        case 9:
        {
            //            担保人1
            [self.model setValue:[self WhetherOrNot:Str] forKey:@"guarantor1JourShowIncome"];
            self.tableView2.model = self.model;
            [self.tableView2 reloadRowsAtIndexPaths:[NSArray arrayWithObjects:ReloadIndexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
        }
            break;
        case 10:
        {
//            担保人1是否打件
            [self.model setValue:[self WhetherOrNot:Str] forKey:@"guarantor1IsPrint"];
            self.tableView2.model = self.model;
            [self.tableView2 reloadRowsAtIndexPaths:[NSArray arrayWithObjects:ReloadIndexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
        }
            break;
        case 11:
        {
            //            担保人2
            [self.model setValue:[self WhetherOrNot:Str] forKey:@"guarantor2JourShowIncome"];
            self.tableView2.model = self.model;
            [self.tableView2 reloadRowsAtIndexPaths:[NSArray arrayWithObjects:ReloadIndexPath,nil] withRowAnimation:UITableViewRowAnimationNone];

        }
            break;
        case 12:
        {
            [self.model setValue:[self WhetherOrNot:Str] forKey:@"guarantor2IsPrint"];
            self.tableView2.model = self.model;
            [self.tableView2 reloadRowsAtIndexPaths:[NSArray arrayWithObjects:ReloadIndexPath,nil] withRowAnimation:UITableViewRowAnimationNone];

        }
            break;
        case 13:
        {
            [self.model setValue:[self WithOrWithout:Str] forKey:@"isHouseProperty"];
            self.tableView3.model = self.model;
            NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:0];
            [self.tableView3 reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
        }
            break;
        case 14:
        {
            [self.model setValue:[self WithOrWithout:Str] forKey:@"isLicense"];
            self.tableView3.model = self.model;
            NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:1];
            [self.tableView3 reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
        }
            break;
        case 15:
        {
            [self.model setValue:[self WithOrWithout:Str] forKey:@"isDriceLicense"];
            self.tableView3.model = self.model;
            NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:2];
            [self.tableView3 reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
        }
            break;

        case 16:
        {
            [self.model setValue:Str forKey:@"carTypeStr"];
            self.tableView3.model = self.model;
            NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:3];
            [self.tableView3 reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];

        }
            break;
        case 17:
        {
            [self.model setValue:[self WithOrWithout:Str] forKey:@"isSiteProve"];
            self.tableView3.model = self.model;
            NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:4];
            [self.tableView3 reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
        }
            break;
        case 18:
        {
            [self.model setValue:dic[@"dkey"] forKey:@"emergencyRelation1"];
            self.tableView4.model = self.model;
            [self.tableView4 reloadRowsAtIndexPaths:[NSArray arrayWithObjects:ReloadIndexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
        }
            break;
        case 19:
        {
            [self.model setValue:dic[@"dkey"] forKey:@"emergencyRelation2"];
            self.tableView4.model = self.model;
            [self.tableView4 reloadRowsAtIndexPaths:[NSArray arrayWithObjects:ReloadIndexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
        }
            break;
        case 20:
        {
            [self.model setValue:[self RentExisting:Str] forKey:@"houseType"];
            self.tableView5.model = self.model;
            [self.tableView5 reloadRowsAtIndexPaths:[NSArray arrayWithObjects:ReloadIndexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
        }
            break;
        case 21:
        {
            [self.model setValue:[self WhetherOrNot:Str] forKey:@"isPlatInsure"];
            self.tableView6.model = self.model;
            [self.tableView6 reloadRowsAtIndexPaths:[NSArray arrayWithObjects:ReloadIndexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
        }
            break;
        case 22:
        {
            [self.model setValue:dic[@"dkey"] forKey:@"gpsFeeWay"];
            self.tableView6.model = self.model;
            [self.tableView6 reloadRowsAtIndexPaths:[NSArray arrayWithObjects:ReloadIndexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
        }
            break;
        case 23:
        {
            [self.model setValue:dic[@"dkey"] forKey:@"bocFeeWay"];
            self.tableView6.model = self.model;
            [self.tableView6 reloadRowsAtIndexPaths:[NSArray arrayWithObjects:ReloadIndexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
        }
            break;
        case 24:
        {

        }
            break;
        case 100:
        {
            [self.model setValue:[self WhetherOrNot:Str] forKey:@"isAdvanceFund"];
            self.tableView1.model = self.model;
            [self.tableView1 reloadRowsAtIndexPaths:[NSArray arrayWithObjects:ReloadIndexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
        }
            break;
        case 101:
        {

            [self.model setValue:self.AfterSalesArray[sid][@"code"] forKey:@"carDealerCode"];
            [self.model setValue:self.AfterSalesArray[sid][@"fullName"] forKey:@"carDealerCodeStr"];
            self.tableView1.model = self.model;
            [self.tableView1 reloadRowsAtIndexPaths:[NSArray arrayWithObjects:ReloadIndexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
        }
            break;

        default:
            break;
    }
}
//有无
-(void)chooseWithOrWithout:(BaseModel *)model
{
    NSMutableArray *array = [NSMutableArray array];
    [array addObjectsFromArray:@[@"有",@"无"]];
    [model CustomBouncedView:array setState:@"100"];
}

//是否
-(void)chooseWhetherOrNot:(BaseModel *)model
{
    NSMutableArray *array = [NSMutableArray array];
    [array addObjectsFromArray:@[@"是",@"否"]];
    [model CustomBouncedView:array setState:@"100"];
}

-(NSString *)WhetherOrNot:(NSString *)str
{
    if ([str isEqualToString:@"是"]) {
        return @"1";
    }else if ([str isEqualToString:@"否"])
    {
        return @"0";
    }else
    {
        return @"";
    }
}

-(NSString *)WithOrWithout:(NSString *)str
{
    if ([str isEqualToString:@"有"]) {
        return @"1";
    }else if ([str isEqualToString:@"无"])
    {
        return @"0";
    }else
    {
        return @"";
    }
}

-(NSString *)RentExisting:(NSString *)str
{
    if ([str isEqualToString:@"自有"]) {
        return @"0";
    }else if ([str isEqualToString:@"租用"])
    {
        return @"1";
    }else if ([str isEqualToString:@"无"])
    {
        return @"2";
    }
    return @"";
}

-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index
{
    if (refreshTableview.tag == 100) {
        AccessApplyAddGPSVC *vc =[AccessApplyAddGPSVC new];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (refreshTableview.tag == 109) {
        [self apply:@"0"];
    }
}


-(void)apply:(NSString *)dealType
{

    TLNetworking *http = [TLNetworking new];
    http.code = @"632120";
    http.showView = self.view;
    http.parameters[@"EBudgetType"] = self.type;
    http.parameters[@"code"] = self.model.code;
    http.parameters[@"operator"] = [USERDEFAULTS objectForKey:USER_ID];
    http.parameters[@"budgetOrderCode"] = self.model.code;
//    保存申请
    http.parameters[@"dealType"] = dealType;
//客户类型
    if ([dealType isEqualToString:@"1"]) {
        if ([self.model.customerType isEqualToString:@""]) {
            [TLAlert alertWithMsg:@"请选择客户类型"];
            return;
        }
    }
    http.parameters[@"customerType"] = self.model.customerType;
//    汽车经销售

    if ([dealType isEqualToString:@"1"]) {
        if ([self.model.carDealerCode isEqualToString:@""]) {
            [TLAlert alertWithMsg:@"请选择汽车经销售"];
            return;
        }
    }
    http.parameters[@"carDealerCode"] = self.model.carDealerCode;

    http.parameters[@"loanBankCode"] = self.model.loanBankCode;

//    请输入厂商指导价
    UITextField *textField11100 = [self.view viewWithTag:11100];
    if ([dealType isEqualToString:@"1"]) {
        if ([textField11100.text isEqualToString:@""] || [textField11100.text integerValue] == 0) {
            [TLAlert alertWithMsg:@"请输入厂商指导价"];
            return;
        }
    }
    http.parameters[@"originalPrice"] = [NSString stringWithFormat:@"%.0f",[textField11100.text floatValue]*1000];
//    请输入车辆型号
    UITextField *textField11101 = [self.view viewWithTag:11101];
    if ([dealType isEqualToString:@"1"]) {
        if ([textField11101.text isEqualToString:@""]) {
            [TLAlert alertWithMsg:@"请输入车辆型号"];
            return;
        }
    }
    http.parameters[@"carModel"] = textField11101.text;

    UITextField *textField11102 = [self.view viewWithTag:11102];
    http.parameters[@"frameNo"] = textField11102.text;
//    发票价格
    UITextField *textField11103 = [self.view viewWithTag:11103];
    if ([dealType isEqualToString:@"1"]) {
        if ([textField11103.text isEqualToString:@""] || [textField11103.text integerValue] == 0) {
            [TLAlert alertWithMsg:@"请输入发票价格"];
            return;
        }
    }
    http.parameters[@"invoicePrice"] = [NSString stringWithFormat:@"%.0f",[textField11103.text floatValue]*1000];
//    利率类型
    if ([dealType isEqualToString:@"1"]) {
        if ([self.model.rateType isEqualToString:@""]) {
            [TLAlert alertWithMsg:@"请选择利率类型"];
            return;
        }
    }
    http.parameters[@"rateType"] = self.model.rateType;
    http.parameters[@"isSurvey"] = @"";
    UITextField *textField11105 = [self.view viewWithTag:11105];
    http.parameters[@"bankRate"] = textField11105.text;
//    我司贷款成数
    UITextField *textField11106 = [self.view viewWithTag:11106];
    http.parameters[@"companyLoanCs"] = textField11106.text;
//    是否垫资
    if ([dealType isEqualToString:@"1"]) {
        if ([self.model.isAdvanceFund isEqualToString:@""]) {
            [TLAlert alertWithMsg:@"请选择是否垫资"];
            return;
        }
    }
    http.parameters[@"isAdvanceFund"] = self.model.isAdvanceFund;
//    综合利率
    UITextField *textField11107 = [self.view viewWithTag:11107];
    http.parameters[@"globalRate"] = textField11107.text;
    UITextField *textField11104 = [self.view viewWithTag:11104];
//    http.parameters[@"fee"] = ;
    http.parameters[@"loanPeriods"] = [NSString stringWithFormat:@"%.0f",[textField11104.text floatValue]*1000];
//    厂家贴息
    UITextField *textField11108 = [self.view viewWithTag:11108];
    if ([dealType isEqualToString:@"1"]) {
        if ([textField11108.text isEqualToString:@""] || [textField11108.text integerValue] == 0) {
            [TLAlert alertWithMsg:@"请输入厂家贴息"];
            return;
        }
    }
    http.parameters[@"carDealerSubsidy"] = [NSString stringWithFormat:@"%.0f",[textField11108.text floatValue]*1000];
    UITextField *textField11109 = [self.view viewWithTag:11109];
    http.parameters[@"bankLoanCs"] = textField11109.text;
    http.parameters[@"saleUserId"] = self.model.saleUserId;

//    申请人就职单位
    UITextField *textField22200 = [self.view viewWithTag:22200];
    if ([dealType isEqualToString:@"1"]) {
        if ([textField22200.text isEqualToString:@""]) {
            [TLAlert alertWithMsg:@"请输入申请人就职单位"];
            return;
        }
    }
    http.parameters[@"applyUserCompany"] = textField22200.text;

//    申请人职位
    UITextField *textField22201 = [self.view viewWithTag:22201];
    if ([dealType isEqualToString:@"1"]) {
        if ([textField22201.text isEqualToString:@""]) {
            [TLAlert alertWithMsg:@"请输入申请人职位"];
            return;
        }
    }
    http.parameters[@"applyUserDuty"] = textField22201.text;

//申请人共还人关系
    if ([dealType isEqualToString:@"1"]) {
        if ([self.model.applyUserGhrRelation isEqualToString:@""]) {
            [TLAlert alertWithMsg:@"请选择申请人共还人关系"];
            return;
        }
    }
    http.parameters[@"applyUserGhrRelation"] = self.model.applyUserGhrRelation;
//婚姻状况
    if ([dealType isEqualToString:@"1"]) {
        if ([self.model.marryState isEqualToString:@""]) {
            [TLAlert alertWithMsg:@"请选择婚姻状况"];
            return;
        }
    }
    http.parameters[@"marryState"] = self.model.marryState;
//    其他收入说明
    UITextField *textField22202 = [self.view viewWithTag:22202];
    http.parameters[@"otherIncomeNote"] = textField22202.text;


//    购房合同
    http.parameters[@"isHouseContract"] = @"";
    http.parameters[@"houseContract"] = @"";

//    房产证
    if ([dealType isEqualToString:@"1"]) {
        if ([self.model.isHouseProperty isEqualToString:@""]) {
            [TLAlert alertWithMsg:@"请选择房产证情况"];
            return;
        }
    }
    http.parameters[@"isHouseProperty"] = self.model.isHouseProperty;
    http.parameters[@"houseProperty"] = [self.model.housePropertyPics componentsJoinedByString:@"||"];

//    营业执照
    if ([dealType isEqualToString:@"1"]) {
        if ([self.model.isLicense isEqualToString:@""]) {
            [TLAlert alertWithMsg:@"请选择营业执照"];
            return;
        }
    }
    http.parameters[@"isLicense"] = self.model.isLicense;
    http.parameters[@"license"] = [self.model.licensePics componentsJoinedByString:@"||"];

//有无驾照
    if ([dealType isEqualToString:@"1"]) {
        if ([self.model.isDriceLicense isEqualToString:@""]) {
            [TLAlert alertWithMsg:@"请选择有无驾照"];
            return;
        }
    }
    http.parameters[@"isDriceLicense"] = self.model.isDriceLicense;
    http.parameters[@"driceLicense"] = [self.model.driceLicensePics componentsJoinedByString:@"||"];
//    证明场地
    http.parameters[@"isSiteProve"] = self.model.isSiteProve;
    http.parameters[@"siteProve"] = [self.model.siteProvePics componentsJoinedByString:@"||"];
//    现有车辆
    http.parameters[@"carType"] = [self RentExisting:self.model.carTypeStr];

//    场地面积
    UITextField *textField33300 = [self.view viewWithTag:33300];
    http.parameters[@"siteArea"] = textField33300.text;
//    其他资产说明
    UITextField *textField33301 = [self.view viewWithTag:33301];
    http.parameters[@"otherPropertyNote"] = textField33301.text;


//    =================  紧急联系人  ================
//    联系人1姓名
    UITextField *textField44400 = [self.view viewWithTag:44400];
    if ([dealType isEqualToString:@"1"]) {
        if ([textField44400.text isEqualToString:@""]) {
            [TLAlert alertWithMsg:@"请输入联系人姓名"];
            return;
        }
    }
    http.parameters[@"emergencyName1"] = textField44400.text;
//    联系人关系
    if ([dealType isEqualToString:@"1"]) {
        if ([self.model.emergencyRelation1 isEqualToString:@""]) {
            [TLAlert alertWithMsg:@"请选择联系人关系"];
            return;
        }
    }
    http.parameters[@"emergencyRelation1"] = self.model.emergencyRelation1;
//手机号码
    UITextField *textField44401 = [self.view viewWithTag:44401];
    if ([dealType isEqualToString:@"1"]) {
        if ([textField44401.text isEqualToString:@""]) {
            [TLAlert alertWithMsg:@"请输入手机号码"];
            return;
        }
    }
    http.parameters[@"emergencyMobile1"] = textField44401.text;
//联系人2
    http.parameters[@"emergencyRelation2"] = self.model.emergencyRelation2;
    UITextField *textField44402 = [self.view viewWithTag:44402];
    UITextField *textField44403 = [self.view viewWithTag:44403];
    http.parameters[@"emergencyName2"] = textField44402.text;
    http.parameters[@"emergencyMobile2"] = textField44403.text;

    NSLog(@"%@==%@==%@==%@",textField44400.text,textField44401.text,textField44402.text,textField44403.text);

//    =================  其他状况  =================
//申请人户籍地
    UITextField *textField55500 = [self.view viewWithTag:55500];
    if ([dealType isEqualToString:@"1"]) {
        if ([textField55500.text isEqualToString:@""]) {
            [TLAlert alertWithMsg:@"请输入申请人户籍地"];
            return;
        }
    }
    http.parameters[@"applyBirthAddress"] = textField55500.text;
//现住房屋
    UITextField *textField55501 = [self.view viewWithTag:55501];
    if ([dealType isEqualToString:@"1"]) {
        if ([textField55501.text isEqualToString:@""]) {
            [TLAlert alertWithMsg:@"请输入现住房屋"];
            return;
        }
    }
    http.parameters[@"applyNowAddress"] = textField55501.text;
//    现住房屋类型
    if ([dealType isEqualToString:@"1"]) {
        if ([self.model.houseType isEqualToString:@""]) {
            [TLAlert alertWithMsg:@"请选择现住房屋类型"];
            return;
        }
    }
    http.parameters[@"houseType"] = self.model.houseType;

    UITextField *textField55502 = [self.view viewWithTag:55502];
    UITextField *textField55503 = [self.view viewWithTag:55503];
    UITextField *textField55504 = [self.view viewWithTag:55504];
    UITextField *textField55505 = [self.view viewWithTag:55505];
    http.parameters[@"ghBirthAddress"] = textField55502.text;
    http.parameters[@"guarantor1BirthAddress"] = textField55503.text;
    http.parameters[@"guarantor2BirthAddress"] = textField55504.text;
    http.parameters[@"otherNote"] = textField55505.text;



//    =================  费用状况  =================
    UITextField *textField66600 = [self.view viewWithTag:66600];
    UITextField *textField66601 = [self.view viewWithTag:66601];
    UITextField *textField66602 = [self.view viewWithTag:66602];
//油补公里数
    if ([dealType isEqualToString:@"1"]) {
        if ([textField66600.text isEqualToString:@""]) {
            [TLAlert alertWithMsg:@"请输入油补公里数"];
            return;
        }
    }
    http.parameters[@"oilSubsidy"] = textField66600.text;
    http.parameters[@"oilSubsidyKil"] = [NSString stringWithFormat:@"%.0f",[textField66601.text floatValue]*1000];
//我司续保
    if ([dealType isEqualToString:@"1"]) {
        if ([self.model.isPlatInsure isEqualToString:@""]) {
            [TLAlert alertWithMsg:@"请选择我司续保"];
            return;
        }
    }
    http.parameters[@"isPlatInsure"] = self.model.isPlatInsure;
    http.parameters[@"gpsFee"] = [NSString stringWithFormat:@"%.0f",[textField66602.text floatValue]*1000];
    http.parameters[@"gpsFeeWay"] = self.model.gpsFeeWay;
    http.parameters[@"feeWay"] = self.model.bocFeeWay;

    http.parameters[@"lyAmount"] = @"";
    http.parameters[@"fxAmount"] = @"";
    http.parameters[@"otherFee"] = @"";
    http.parameters[@"gpsDeduct"] = @"";
    http.parameters[@"loanBankSubbranch"] = @"";

//    =================  贷款材料  =================
    http.parameters[@"marryDivorce"] = [self.model.marryDivorcePics componentsJoinedByString:@"||"];
    http.parameters[@"houseInvoice"] = [self.model.houseInvoicePics componentsJoinedByString:@"||"];
    http.parameters[@"applyUserHkb"] = [self.model.applyUserHkbPics componentsJoinedByString:@"||"];
    http.parameters[@"bankBillPdf"] = [self.model.bankBillPdfPics componentsJoinedByString:@"||"];
    http.parameters[@"singleProvePdf"] = [self.model.singleProvePdfPics componentsJoinedByString:@"||"];
    http.parameters[@"incomeProvePdf"] = [self.model.incomeProvePdfPics componentsJoinedByString:@"||"];
    http.parameters[@"liveProvePdf"] = [self.model.liveProvePdfPics componentsJoinedByString:@"||"];
    http.parameters[@"buildProvePdf"] = [self.model.buildProvePdfPics componentsJoinedByString:@"||"];
    http.parameters[@"hkbFirstPage"] = [self.model.hkbFirstPagePics componentsJoinedByString:@"||"];
    http.parameters[@"hkbMainPage"] = [self.model.hkbMainPagePics componentsJoinedByString:@"||"];
    http.parameters[@"ghHkb"] = [self.model.ghHkbPics componentsJoinedByString:@"||"];
    http.parameters[@"ghIdNo"] = [self.model.ghIdNoPics componentsJoinedByString:@"||"];
    http.parameters[@"guarantor1IdNo"] = [self.model.guarantor1IdNoPics componentsJoinedByString:@"||"];
    http.parameters[@"guarantor1Hkb"] = [self.model.guarantor1HkbPics componentsJoinedByString:@"||"];
    http.parameters[@"guarantor2IdNo"] = [self.model.guarantor2IdNoPics componentsJoinedByString:@"||"];
    http.parameters[@"guarantor2Hkb"] = [self.model.guarantor2HkbPics componentsJoinedByString:@"||"];

//    =================  家访材料  =================
    http.parameters[@"housePic"] = [self.model.housePicPics componentsJoinedByString:@"||"];
    http.parameters[@"houseUnitPic"] = [self.model.houseUnitPicPics componentsJoinedByString:@"||"];
    http.parameters[@"houseDoorPic"] = [self.model.houseDoorPicPics componentsJoinedByString:@"||"];
    http.parameters[@"houseRoomPic"] = [self.model.houseRoomPicPics componentsJoinedByString:@"||"];
    http.parameters[@"houseCustomerPic"] = [self.model.houseCustomerPicPics componentsJoinedByString:@"||"];
    http.parameters[@"houseSaleCustomerPic"] = [self.model.houseSaleCustomerPicPics componentsJoinedByString:@"||"];

//    =================  企业照片  =================
    http.parameters[@"companyNamePic"] = [self.model.companyNamePicPics componentsJoinedByString:@"||"];
    http.parameters[@"companyPlacePic"] = [self.model.companyPlacePicPics componentsJoinedByString:@"||"];
    http.parameters[@"companyWorkshopPic"] = [self.model.companyWorkshopPicPics componentsJoinedByString:@"||"];
    http.parameters[@"companySaleCustomerPic"] = [self.model.companySaleCustomerPicPics componentsJoinedByString:@"||"];

//    =================  二手车  =================
    http.parameters[@"secondHgz"] = @"";
    http.parameters[@"secondOdometer"] = @"";
    http.parameters[@"secondCarFrontPic"] = @"";
    http.parameters[@"secondConsolePic"] = @"";
    http.parameters[@"second300Pdf"] = @"";
    http.parameters[@"secondQxbPic"] = @"";
    http.parameters[@"secondCarInPic"] = @"";
    http.parameters[@"secondNumber"] = @"";

//    =================  其他材料  =================
    http.parameters[@"otherFilePdf"] = [self.model.otherFilePdfPics componentsJoinedByString:@"||"];
    UITextField *textField101010 = [self.view viewWithTag:101010];
    http.parameters[@"otherApplyNote"] = textField101010.text;

    http.parameters[@"gpsList"] = self.gpsArray;
    http.parameters[@"creditUserIncomeList"] = @"";

    [http postWithSuccess:^(id responseObject) {

        NSNotification *notification =[NSNotification notificationWithName:LOADDATAPAGE object:nil userInfo:nil];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSError *error) {
        WGLog(@"%@",error);
    }];
}

-(void)initScrollView
{
    self.scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0 , SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight)];
    _scroll.pagingEnabled = YES;
    _scroll.delegate = self;
    _scroll.bounces = NO;
    _scroll.showsVerticalScrollIndicator = NO;
    _scroll.directionalLockEnabled = YES;
    _scroll.contentSize = CGSizeMake(SCREEN_WIDTH * 10, SCREEN_HEIGHT - kNavigationBarHeight);
    [self.view addSubview:_scroll];
    self.currentPages = 0;
}

-(void)navigativeView
{
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = -10;
    self.navigationItem.leftBarButtonItems = @[negativeSpacer, [[UIBarButtonItem alloc] initWithCustomView:self.LeftBackbButton]];
    self.RightButton.titleLabel.font = HGfont(18);
    [self.LeftBackbButton addTarget:self action:@selector(leftButtonClick) forControlEvents:(UIControlEventTouchUpInside)];
    self.navigationItem.rightBarButtonItems = @[negativeSpacer, [[UIBarButtonItem alloc] initWithCustomView:self.RightButton]];
    [self.RightButton setTitle:@"下一页" forState:(UIControlStateNormal)];
    [self.RightButton addTarget:self action:@selector(rightButtonClick) forControlEvents:(UIControlEventTouchUpInside)];
    _titleBtn = [UIButton buttonWithTitle:@"" titleColor:[UIColor whiteColor] backgroundColor:kClearColor titleFont:18];
    _titleBtn.frame = CGRectMake(0, 0, 150, 44);
    [_titleBtn addTarget:self action:@selector(titleBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    self.navigationItem.titleView = _titleBtn;
    [self titleBtnCustom];

}

-(void)leftButtonClick
{
    if (self.currentPages == 0) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    CGRect frame;
    frame.origin.x = self.scroll.frame.size.width * (self.currentPages - 1);
    self.selectRow = self.currentPages - 1;
    frame.origin.y = 0;
    frame.size = _scroll.frame.size;
    [_scroll scrollRectToVisible:frame animated:YES];
}

-(void)titleBtnClick
{
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0;  i < _dvalueArray.count; i ++) {
        [array addObject:[[SelectedListModel alloc] initWithSid:i Title:[NSString stringWithFormat:@"%@",_dvalueArray[i]]]];
    }
    SelectedListView *view = [[SelectedListView alloc] initWithFrame:CGRectMake(0, 0, 280, 0) style:UITableViewStylePlain];
    view.isSingle = YES;
    view.array = array;
    view.selectedBlock = ^(NSArray<SelectedListModel *> *array) {
        [LEEAlert closeWithCompletionBlock:^{
            NSLog(@"选中的%@" , array);

            SelectedListModel *model = array[0];
            CGRect frame;
            self.selectRow = model.sid;
            frame.origin.x = self.scroll.frame.size.width * (model.sid);
            frame.origin.y = 0;
            frame.size = self.scroll.frame.size;
            [self.scroll scrollRectToVisible:frame animated:YES];
        }];
    };
    [LEEAlert alert].config
    .LeeTitle(@"选择")
    .LeeItemInsets(UIEdgeInsetsMake(20, 0, 20, 0))
    .LeeCustomView(view)
    .LeeItemInsets(UIEdgeInsetsMake(0, 0, 0, 0))
    .LeeHeaderInsets(UIEdgeInsetsMake(10, 0, 0, 0))
    .LeeClickBackgroundClose(YES)
    .LeeShow();
}

-(void)rightButtonClick
{
    if (self.currentPages == 9) {
        [self apply:@"1"];
    }else
    {
        CGRect frame;
        frame.origin.x = self.scroll.frame.size.width * (self.currentPages + 1);
        self.selectRow = self.currentPages + 1;
        frame.origin.y = 0;
        frame.size = _scroll.frame.size;
        [_scroll scrollRectToVisible:frame animated:YES];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    CGFloat pageWidth = _scroll.frame.size.width;
    self.currentPages = floor((_scroll.contentOffset.x - pageWidth/2)/pageWidth) + 1;
//    NSLog(@"%ld",self.currentPages);
    self.selectRow = self.currentPages;
    [self titleBtnCustom];
}

-(void)titleBtnCustom
{
    [_titleBtn setTitle:_dvalueArray[self.selectRow] forState:(UIControlStateNormal)];
    [_titleBtn SG_imagePositionStyle:(SGImagePositionStyleRight) spacing:10 imagePositionBlock:^(UIButton *button) {
        [button setImage:[UIImage imageNamed:@"下拉"] forState:(UIControlStateNormal)];
    }];
    if (self.currentPages == 0) {
        [self.LeftBackbButton setTitle:@"" forState:(UIControlStateNormal)];
        [self.LeftBackbButton setImage:HGImage(@"返回") forState:(UIControlStateNormal)];
    }else
    {

        [self.LeftBackbButton setTitle:@"上一页" forState:(UIControlStateNormal)];
        [self.LeftBackbButton setImage:HGImage(@"") forState:(UIControlStateNormal)];
    }

    if (self.currentPages == 9) {
        [self.RightButton setTitle:@"申请" forState:(UIControlStateNormal)];
    }else
    {
        [self.RightButton setTitle:@"下一页" forState:(UIControlStateNormal)];
    }
}

- (void)initTableView1 {
    self.tableView1 = [[ApplyTableView1 alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView1.refreshDelegate = self;
    self.tableView1.backgroundColor = kBackgroundColor;
    self.tableView1.tag = 100;
    self.tableView1.model = self.model;
    [self.scroll addSubview:self.tableView1];
}
- (void)initTableView2 {
    self.tableView2 = [[ApplyTableView2 alloc] initWithFrame:CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView2.refreshDelegate = self;
    self.tableView2.backgroundColor = kBackgroundColor;
    self.tableView2.tag = 101;
    self.tableView2.model = self.model;
    [self.scroll addSubview:self.tableView2];
}
- (void)initTableView3 {
    self.tableView3 = [[ApplyTableView3 alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 2, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView3.refreshDelegate = self;
    self.tableView3.backgroundColor = kBackgroundColor;
    self.tableView3.tag = 102;
    self.tableView3.model = self.model;
    [self.scroll addSubview:self.tableView3];
}
- (void)initTableView4 {
    self.tableView4 = [[ApplyTableView4 alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 3, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView4.refreshDelegate = self;
    self.tableView4.backgroundColor = kBackgroundColor;
    self.tableView4.tag = 103;
    self.tableView4.model = self.model;
    [self.scroll addSubview:self.tableView4];
}
- (void)initTableView5 {
    self.tableView5 = [[ApplyTableView5 alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 4, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView5.refreshDelegate = self;
    self.tableView5.backgroundColor = kBackgroundColor;
    self.tableView5.tag = 104;
    self.tableView5.model = self.model;
    [self.scroll addSubview:self.tableView5];
}
- (void)initTableView6 {
    self.tableView6 = [[ApplyTableView6 alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 5, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView6.refreshDelegate = self;
    self.tableView6.backgroundColor = kBackgroundColor;
    self.tableView6.tag = 105;
    self.tableView6.model = self.model;
    [self.scroll addSubview:self.tableView6];
}
- (void)initTableView7 {
    self.tableView7 = [[ApplyTableView7 alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 6, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView7.refreshDelegate = self;
    self.tableView7.backgroundColor = kBackgroundColor;
    self.tableView7.tag = 106;
    self.tableView7.model = self.model;
    [self.scroll addSubview:self.tableView7];
}
- (void)initTableView8 {
    self.tableView8 = [[ApplyTableView8 alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 7, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView8.refreshDelegate = self;
    self.tableView8.backgroundColor = kBackgroundColor;
    self.tableView8.tag = 107;
    self.tableView8.model = self.model;
    [self.scroll addSubview:self.tableView8];
}
- (void)initTableView9 {
    self.tableView9 = [[ApplyTableView9 alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 8, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView9.refreshDelegate = self;
    self.tableView9.backgroundColor = kBackgroundColor;
    self.tableView9.tag = 108;
    self.tableView9.model = self.model;
    [self.scroll addSubview:self.tableView9];
}
- (void)initTableView10 {
    self.tableView10 = [[ApplyTableView10 alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 9, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView10.refreshDelegate = self;
    self.tableView10.backgroundColor = kBackgroundColor;
    self.tableView10.tag = 109;
    self.tableView10.model = self.model;
    [self.scroll addSubview:self.tableView10];
}


-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index selectRowState:(NSString *)state
{
    if ([state isEqualToString:@"add"]) {
        selectTableViewTag = refreshTableview.tag - 100;
        selectSection = index;
        [self.imagePicker picker];
    }else{
        selectTableViewTag = refreshTableview.tag - 100;
        selectSection = [state integerValue];
        switch (refreshTableview.tag - 100) {
            case 2:
            {
                [self deleteTableView3Cell:index select:[state intValue]];
            }
                break;
            case 6:
            {
                [self deleteTableView7Cell:index select:[state intValue]];
            }
                break;
            case 7:
            {
                [self deleteTableView8Cell:index select:[state intValue]];
            }
                break;
            case 8:
            {
                [self deleteTableView9Cell:index select:[state intValue]];
            }
                break;
            case 9:
            {
                NSMutableArray *array = [NSMutableArray array];
                [array addObjectsFromArray:self.model.otherFilePdfPics];
                [array removeObjectAtIndex:index - 1000];
                [self.model setValue:array forKey:@"otherFilePdfPics"];
                self.tableView10.model = self.model;
                [self.tableView10 reloadData];
            }
                break;

            default:
                break;
        }
    }
}

-(void)deleteTableView3Cell:(NSInteger )index select:(NSInteger)section
{
    switch (selectSection) {
        case 0:
        {
            NSMutableArray *array = [NSMutableArray array];
            [array addObjectsFromArray:self.model.housePropertyPics];
            [array removeObjectAtIndex:index - 1000];
            [self.model setValue:array forKey:@"housePropertyPics"];
        }
            break;
        case 1:
        {
            NSMutableArray *array = [NSMutableArray array];
            [array addObjectsFromArray:self.model.licensePics];
            [array removeObjectAtIndex:index - 1000];
            [self.model setValue:array forKey:@"licensePics"];
        }
            break;
        case 2:
        {
            NSMutableArray *array = [NSMutableArray array];
            [array addObjectsFromArray:self.model.driceLicensePics];
            [array removeObjectAtIndex:index - 1000];
            [self.model setValue:array forKey:@"driceLicensePics"];
        }
            break;
        case 4:
        {
            NSMutableArray *array = [NSMutableArray array];
            [array addObjectsFromArray:self.model.siteProvePics];
            [array removeObjectAtIndex:index - 1000];
            [self.model setValue:array forKey:@"siteProvePics"];
        }
            break;
        default:
            break;

    }
    self.tableView3.model = self.model;
    NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:selectSection];
    [self.tableView3 reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];

}


-(void)deleteTableView7Cell:(NSInteger )index select:(NSInteger)section
{
    switch (selectSection) {
        case 0:
        {
            NSMutableArray *array = [NSMutableArray array];
            [array addObjectsFromArray:self.model.marryDivorcePics];
            [array removeObjectAtIndex:index - 1000];
            [self.model setValue:array forKey:@"marryDivorcePics"];
        }
            break;
        case 1:
        {
            NSMutableArray *array = [NSMutableArray array];
            [array addObjectsFromArray:self.model.applyUserHkbPics];
            [array removeObjectAtIndex:index - 1000];
            [self.model setValue:array forKey:@"applyUserHkbPics"];
        }
            break;
        case 2:
        {
            NSMutableArray *array = [NSMutableArray array];
            [array addObjectsFromArray:self.model.bankBillPdfPics];
            [array removeObjectAtIndex:index - 1000];
            [self.model setValue:array forKey:@"bankBillPdfPics"];
        }
            break;
        case 3:
        {
            NSMutableArray *array = [NSMutableArray array];
            [array addObjectsFromArray:self.model.singleProvePdfPics];
            [array removeObjectAtIndex:index - 1000];
            [self.model setValue:array forKey:@"singleProvePdfPics"];
        }
            break;
        case 4:
        {
            NSMutableArray *array = [NSMutableArray array];
            [array addObjectsFromArray:self.model.incomeProvePdfPics];
            [array removeObjectAtIndex:index - 1000];
            [self.model setValue:array forKey:@"incomeProvePdfPics"];
        }
            break;
        case 5:
        {
            NSMutableArray *array = [NSMutableArray array];
            [array addObjectsFromArray:self.model.liveProvePdfPics];
            [array removeObjectAtIndex:index - 1000];
            [self.model setValue:array forKey:@"liveProvePdfPics"];
        }
            break;
        case 6:
        {
            NSMutableArray *array = [NSMutableArray array];
            [array addObjectsFromArray:self.model.houseInvoicePics];
            [array removeObjectAtIndex:index - 1000];
            [self.model setValue:array forKey:@"houseInvoicePics"];
        }
            break;
        case 7:
        {
            NSMutableArray *array = [NSMutableArray array];
            [array addObjectsFromArray:self.model.buildProvePdfPics];
            [array removeObjectAtIndex:index - 1000];
            [self.model setValue:array forKey:@"buildProvePdfPics"];
        }
            break;
        case 8:
        {
            NSMutableArray *array = [NSMutableArray array];
            [array addObjectsFromArray:self.model.hkbFirstPagePics];
            [array removeObjectAtIndex:index - 1000];
            [self.model setValue:array forKey:@"hkbFirstPagePics"];
        }
            break;
        case 9:
        {
            NSMutableArray *array = [NSMutableArray array];
            [array addObjectsFromArray:self.model.hkbMainPagePics];
            [array removeObjectAtIndex:index - 1000];
            [self.model setValue:array forKey:@"hkbMainPagePics"];
        }
            break;
        case 10:
        {
            NSMutableArray *array = [NSMutableArray array];
            [array addObjectsFromArray:self.model.guarantor1IdNoPics];
            [array removeObjectAtIndex:index - 1000];
            [self.model setValue:array forKey:@"guarantor1IdNoPics"];
        }
            break;
        case 11:
        {
            NSMutableArray *array = [NSMutableArray array];
            [array addObjectsFromArray:self.model.guarantor1HkbPics];
            [array removeObjectAtIndex:index - 1000];
            [self.model setValue:array forKey:@"guarantor1HkbPics"];
        }
            break;
        case 12:
        {
            NSMutableArray *array = [NSMutableArray array];
            [array addObjectsFromArray:self.model.guarantor2IdNoPics];
            [array removeObjectAtIndex:index - 1000];
            [self.model setValue:array forKey:@"guarantor2IdNoPics"];
        }
            break;
        case 13:
        {
            NSMutableArray *array = [NSMutableArray array];
            [array addObjectsFromArray:self.model.guarantor2HkbPics];
            [array removeObjectAtIndex:index - 1000];
            [self.model setValue:array forKey:@"guarantor2HkbPics"];
        }
            break;
        case 14:
        {
            NSMutableArray *array = [NSMutableArray array];
            [array addObjectsFromArray:self.model.ghIdNoPics];
            [array removeObjectAtIndex:index - 1000];
            [self.model setValue:array forKey:@"ghIdNoPics"];
        }
            break;
        case 15:
        {
            NSMutableArray *array = [NSMutableArray array];
            [array addObjectsFromArray:self.model.ghHkbPics];
            [array removeObjectAtIndex:index - 1000];
            [self.model setValue:array forKey:@"ghHkbPics"];
        }
            break;
        default:
            break;

    }
    
    self.tableView7.model = self.model;
    NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:selectSection];
    [self.tableView7 reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];

}

-(void)deleteTableView8Cell:(NSInteger )index select:(NSInteger)section
{
    switch (selectSection) {
        case 0:
        {
            NSMutableArray *array = [NSMutableArray array];
            [array addObjectsFromArray:self.model.housePicPics];
            [array removeObjectAtIndex:1000 - index];
            [self.model setValue:array forKey:@"housePicPics"];
        }
            break;
        case 1:
        {
            NSMutableArray *array = [NSMutableArray array];
            [array addObjectsFromArray:self.model.houseUnitPicPics];
            [array removeObjectAtIndex:1000 - index];
            [self.model setValue:array forKey:@"houseUnitPicPics"];
        }
            break;
        case 2:
        {
            NSMutableArray *array = [NSMutableArray array];
            [array addObjectsFromArray:self.model.houseDoorPicPics];
            [array removeObjectAtIndex:1000 - index];
            [self.model setValue:array forKey:@"houseDoorPicPics"];
        }
            break;
        case 3:
        {
            NSMutableArray *array = [NSMutableArray array];
            [array addObjectsFromArray:self.model.houseRoomPicPics];
            [array removeObjectAtIndex:1000 - index];
            [self.model setValue:array forKey:@"houseRoomPicPics"];
        }
            break;
        case 4:
        {
            NSMutableArray *array = [NSMutableArray array];
            [array addObjectsFromArray:self.model.houseCustomerPicPics];
            [array removeObjectAtIndex:1000 - index];
            [self.model setValue:array forKey:@"houseCustomerPicPics"];
        }
            break;
        case 5:
        {
            NSMutableArray *array = [NSMutableArray array];
            [array addObjectsFromArray:self.model.houseSaleCustomerPicPics];
            [array removeObjectAtIndex:1000 - index];
            [self.model setValue:array forKey:@"houseSaleCustomerPicPics"];
        }
            break;
        default:
            break;

    }

    self.tableView8.model = self.model;
    NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:selectSection];
    [self.tableView8 reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
}

-(void)deleteTableView9Cell:(NSInteger )index select:(NSInteger)section
{
    switch (selectSection) {
        case 0:
        {
            NSMutableArray *array = [NSMutableArray array];
            [array addObjectsFromArray:self.model.companyNamePicPics];
            [array removeObjectAtIndex:index - 1000];
            [self.model setValue:array forKey:@"companyNamePicPics"];
        }
            break;
        case 1:
        {
            NSMutableArray *array = [NSMutableArray array];
            [array addObjectsFromArray:self.model.companyPlacePicPics];
            [array removeObjectAtIndex:index - 1000];
            [self.model setValue:array forKey:@"companyPlacePicPics"];
        }
            break;
        case 2:
        {
            NSMutableArray *array = [NSMutableArray array];
            [array addObjectsFromArray:self.model.companyWorkshopPicPics];
            [array removeObjectAtIndex:index - 1000];
            [self.model setValue:array forKey:@"companyWorkshopPicPics"];
        }
            break;
        case 3:
        {
            NSMutableArray *array = [NSMutableArray array];
            [array addObjectsFromArray:self.model.companySaleCustomerPicPics];
            [array removeObjectAtIndex:index - 1000];
            [self.model setValue:array forKey:@"companySaleCustomerPicPics"];
        }
            break;
        default:
            break;

    }

    self.tableView9.model = self.model;
    NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:selectSection];
    [self.tableView9 reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (TLImagePicker *)imagePicker {

    if (!_imagePicker) {
        ProjectWeakSelf;
        _imagePicker = [[TLImagePicker alloc] initWithVC:self];

        _imagePicker.allowsEditing = YES;
        _imagePicker.pickFinish = ^(NSDictionary *info){
            UIImage *image = info[@"UIImagePickerControllerOriginalImage"];
            NSData *imgData = UIImageJPEGRepresentation(image, 0.1);

            //进行上传
            TLUploadManager *manager = [TLUploadManager manager];

            manager.imgData = imgData;
            manager.image = image;
            [manager getTokenShowView:weakSelf.view succes:^(NSString *key) {
                WGLog(@"%@",key);
                [weakSelf setImage:image setData:key];

            } failure:^(NSError *error) {

            }];
        };
    }

    return _imagePicker;
}

-(void)setImage:(UIImage *)image setData:(NSString *)data
{
    if (selectTableViewTag == 2) {
        [self tableView2AddImage:data];
    }
    if (selectTableViewTag == 6) {
        [self tableView7AddImage:data];
    }
    if (selectTableViewTag == 7) {
        [self tableView8AddImage:data];
    }
    if (selectTableViewTag == 8) {
        [self tableView9AddImage:data];
    }
    if (selectTableViewTag == 9) {
        NSMutableArray *array = [NSMutableArray array];
        [array addObjectsFromArray:self.model.otherFilePdfPics];
        [array addObject:data];
        [self.model setValue:array forKey:@"otherFilePdfPics"];
        self.tableView10.model = self.model;
        [self.tableView10 reloadData];
    }
}

-(void)tableView2AddImage:(NSString *)data
{
    switch (selectSection) {
        case 0:
        {
            NSMutableArray *array = [NSMutableArray array];
            [array addObjectsFromArray:self.model.housePropertyPics];
            [array addObject:data];
            [self.model setValue:array forKey:@"housePropertyPics"];
        }
            break;
        case 1:
        {
            NSMutableArray *array = [NSMutableArray array];
            [array addObjectsFromArray:self.model.licensePics];
            [array addObject:data];
            [self.model setValue:array forKey:@"licensePics"];
        }
            break;
        case 2:
        {
            NSMutableArray *array = [NSMutableArray array];
            [array addObjectsFromArray:self.model.driceLicensePics];
            [array addObject:data];
            [self.model setValue:array forKey:@"driceLicensePics"];
        }
            break;
        case 4:
        {
            NSMutableArray *array = [NSMutableArray array];
            [array addObjectsFromArray:self.model.siteProvePics];
            [array addObject:data];
            [self.model setValue:array forKey:@"siteProvePics"];
        }
            break;

        default:
            break;
    }
    self.tableView3.model = self.model;
    NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:selectSection];
    [self.tableView3 reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
}

-(void)tableView7AddImage:(NSString *)data
{
    switch (selectSection) {
        case 0:
        {
            NSMutableArray *array = [NSMutableArray array];
            [array addObjectsFromArray:self.model.marryDivorcePics];
            [array addObject:data];
            [self.model setValue:array forKey:@"marryDivorcePics"];
        }
            break;
        case 1:
        {
            NSMutableArray *array = [NSMutableArray array];
            [array addObjectsFromArray:self.model.applyUserHkbPics];
            [array addObject:data];
            [self.model setValue:array forKey:@"applyUserHkbPics"];
        }
            break;
        case 2:
        {
            NSMutableArray *array = [NSMutableArray array];
            [array addObjectsFromArray:self.model.bankBillPdfPics];
            [array addObject:data];
            [self.model setValue:array forKey:@"bankBillPdfPics"];
        }
            break;
        case 3:
        {
            NSMutableArray *array = [NSMutableArray array];
            [array addObjectsFromArray:self.model.singleProvePdfPics];
            [array addObject:data];
            [self.model setValue:array forKey:@"singleProvePdfPics"];
        }
            break;
        case 4:
        {
            NSMutableArray *array = [NSMutableArray array];
            [array addObjectsFromArray:self.model.incomeProvePdfPics];
            [array addObject:data];
            [self.model setValue:array forKey:@"incomeProvePdfPics"];
        }
            break;
        case 5:
        {
            NSMutableArray *array = [NSMutableArray array];
            [array addObjectsFromArray:self.model.liveProvePdfPics];
            [array addObject:data];
            [self.model setValue:array forKey:@"liveProvePdfPics"];
        }
            break;
        case 6:
        {
            NSMutableArray *array = [NSMutableArray array];
            [array addObjectsFromArray:self.model.houseInvoicePics];
            [array addObject:data];
            [self.model setValue:array forKey:@"houseInvoicePics"];
        }
            break;
        case 7:
        {
            NSMutableArray *array = [NSMutableArray array];
            [array addObjectsFromArray:self.model.buildProvePdfPics];
            [array addObject:data];
            [self.model setValue:array forKey:@"buildProvePdfPics"];
        }
            break;
        case 8:
        {
            NSMutableArray *array = [NSMutableArray array];
            [array addObjectsFromArray:self.model.hkbFirstPagePics];
            [array addObject:data];
            [self.model setValue:array forKey:@"hkbFirstPagePics"];
        }
            break;
        case 9:
        {
            NSMutableArray *array = [NSMutableArray array];
            [array addObjectsFromArray:self.model.hkbMainPagePics];
            [array addObject:data];
            [self.model setValue:array forKey:@"hkbMainPagePics"];
        }
            break;
        case 10:
        {
            NSMutableArray *array = [NSMutableArray array];
            [array addObjectsFromArray:self.model.guarantor1IdNoPics];
            [array addObject:data];
            [self.model setValue:array forKey:@"guarantor1IdNoPics"];
        }
            break;
        case 11:
        {
            NSMutableArray *array = [NSMutableArray array];
            [array addObjectsFromArray:self.model.guarantor1HkbPics];
            [array addObject:data];
            [self.model setValue:array forKey:@"guarantor1HkbPics"];
        }
            break;
        case 12:
        {
            NSMutableArray *array = [NSMutableArray array];
            [array addObjectsFromArray:self.model.guarantor2IdNoPics];
            [array addObject:data];
            [self.model setValue:array forKey:@"guarantor2IdNoPics"];
        }
            break;
        case 13:
        {
            NSMutableArray *array = [NSMutableArray array];
            [array addObjectsFromArray:self.model.guarantor2HkbPics];
            [array addObject:data];
            [self.model setValue:array forKey:@"guarantor2HkbPics"];
        }
            break;
        case 14:
        {
            NSMutableArray *array = [NSMutableArray array];
            [array addObjectsFromArray:self.model.ghIdNoPics];
            [array addObject:data];
            [self.model setValue:array forKey:@"ghIdNoPics"];
        }
            break;
        case 15:
        {
            NSMutableArray *array = [NSMutableArray array];
            [array addObjectsFromArray:self.model.ghHkbPics];
            [array addObject:data];
            [self.model setValue:array forKey:@"ghHkbPics"];
        }
            break;


        default:
            break;

    }
    self.tableView7.model = self.model;
    NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:selectSection];
    [self.tableView7 reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
}

-(void)tableView8AddImage:(NSString *)data
{
    switch (selectSection) {
        case 0:
        {
            NSMutableArray *array = [NSMutableArray array];
            [array addObjectsFromArray:self.model.housePicPics];
            [array addObject:data];
            [self.model setValue:array forKey:@"housePicPics"];
        }
            break;
        case 1:
        {
            NSMutableArray *array = [NSMutableArray array];
            [array addObjectsFromArray:self.model.houseUnitPicPics];
            [array addObject:data];
            [self.model setValue:array forKey:@"houseUnitPicPics"];
        }
            break;
        case 2:
        {
            NSMutableArray *array = [NSMutableArray array];
            [array addObjectsFromArray:self.model.houseDoorPicPics];
            [array addObject:data];
            [self.model setValue:array forKey:@"houseDoorPicPics"];
        }
            break;
        case 3:
        {
            NSMutableArray *array = [NSMutableArray array];
            [array addObjectsFromArray:self.model.houseRoomPicPics];
            [array addObject:data];
            [self.model setValue:array forKey:@"houseRoomPicPics"];
        }
            break;
        case 4:
        {
            NSMutableArray *array = [NSMutableArray array];
            [array addObjectsFromArray:self.model.houseCustomerPicPics];
            [array addObject:data];
            [self.model setValue:array forKey:@"houseCustomerPicPics"];
        }
            break;
        case 5:
        {
            NSMutableArray *array = [NSMutableArray array];
            [array addObjectsFromArray:self.model.houseSaleCustomerPicPics];
            [array addObject:data];
            [self.model setValue:array forKey:@"houseSaleCustomerPicPics"];
        }
            break;
        default:
            break;

    }

    self.tableView8.model = self.model;
    NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:selectSection];
    [self.tableView8 reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
}


-(void)tableView9AddImage:(NSString *)data
{
    switch (selectSection) {
        case 0:
        {
            NSMutableArray *array = [NSMutableArray array];
            [array addObjectsFromArray:self.model.companyNamePicPics];
            [array addObject:data];
            [self.model setValue:array forKey:@"companyNamePicPics"];
        }
            break;
        case 1:
        {
            NSMutableArray *array = [NSMutableArray array];
            [array addObjectsFromArray:self.model.companyPlacePicPics];
            [array addObject:data];
            [self.model setValue:array forKey:@"companyPlacePicPics"];
        }
            break;
        case 2:
        {
            NSMutableArray *array = [NSMutableArray array];
            [array addObjectsFromArray:self.model.companyWorkshopPicPics];
            [array addObject:data];
            [self.model setValue:array forKey:@"companyWorkshopPicPics"];
        }
            break;
        case 3:
        {
            NSMutableArray *array = [NSMutableArray array];
            [array addObjectsFromArray:self.model.companySaleCustomerPicPics];
            [array addObject:data];
            [self.model setValue:array forKey:@"companySaleCustomerPicPics"];
        }
            break;
        default:
            break;

    }

    self.tableView9.model = self.model;
    NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:selectSection];
    [self.tableView9 reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
}

@end
