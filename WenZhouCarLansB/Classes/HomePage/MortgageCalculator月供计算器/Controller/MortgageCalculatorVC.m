//
//  MortgageCalculatorVC.m
//  WenZhouCarLansB
//
//  Created by QinBao Zheng on 2018/9/4.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "MortgageCalculatorVC.h"
#import "MortgageCalculatorTableView.h"
@interface MortgageCalculatorVC ()<RefreshDelegate,BaseModelDelegate>
{
    NSInteger selectNumber;
    //    银行编号
    NSString *loanBankCode;

    NSString *loanPeriods;
    NSString *rateType;
    NSString *serviceChargeWay;
    NSString *bankRate;
    NSString *surcharge;

}
//银行卡
@property (nonatomic , strong)NSArray *bankArray;

@property (nonatomic , strong)MortgageCalculatorTableView *tableView;

@property (nonatomic , strong)NSArray *bankRateList;

@end

@implementation MortgageCalculatorVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initTableView];
    self.title = @"月供计算器";
}

- (void)initTableView {
    self.tableView = [[MortgageCalculatorTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    self.tableView.backgroundColor = kBackgroundColor;
    [self.view addSubview:self.tableView];
}

-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        selectNumber = indexPath.row;
        if (indexPath.row == 0) {
            if (_bankArray.count > 0) {
                [self BankLoadData];
            }else
            {
                TLNetworking *http = [TLNetworking new];
                http.isShowMsg = YES;
                http.code = @"632037";
                [http postWithSuccess:^(id responseObject) {
                    self.bankArray = responseObject[@"data"];
                    [self BankLoadData];
                } failure:^(NSError *error) {

                }];
            }
        }else
        {
            if (_bankRateList.count == 0) {
                [TLAlert alertWithInfo:@"请选择银行"];

            }else
            {
                BaseModel *model = [BaseModel new];
                model.ModelDelegate = self;
                NSMutableArray *array = [NSMutableArray array];
                for (int i = 0; i < _bankRateList.count; i ++) {
                    [array addObject:[NSString stringWithFormat:@"%@期",_bankRateList[i][@"period"]]];
                }
                [model CustomBouncedView:array setState:@"100"];
            }
        }
    }
    if (indexPath.section == 2) {
        BaseModel *model = [BaseModel new];
        model.ModelDelegate = self;
        if (indexPath.row == 0) {
            selectNumber = 2;
            [model ReturnsParentKeyAnArray:@"rate_type"];
        }else if (indexPath.row == 1)
        {
            selectNumber = 3;
            [model ReturnsParentKeyAnArray:@"boc_fee_way"];
        }else
        {
            selectNumber = 4;
            [model ReturnsParentKeyAnArray:@"surcharge"];
        }
    }
}

//银行卡弹框
-(void)BankLoadData
{
    BaseModel *model = [BaseModel new];
    model.ModelDelegate = self;
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < self.bankArray.count; i ++) {
        [array addObject:self.bankArray[i][@"bankName"]];
    }
    [model CustomBouncedView:array setState:@"100"];
}


-(void)TheReturnValueStr:(NSString *)Str selectDic:(NSDictionary *)dic selectSid:(NSInteger)sid
{
    WGLog(@"%@",dic);
    if (selectNumber == 0)
    {
        _tableView.bankStr = Str;
        _bankRateList = _bankArray[sid][@"bankRateList"];
        loanBankCode = self.bankArray[sid][@"code"];



        _tableView.periodStr = @"";
        _tableView.interestStr = @"";
        _tableView.interestTypeStr = @"";
        _tableView.feesChargedStr = @"";
        _tableView.surcharge = @"";

        loanPeriods = @"";
        rateType = @"";
        serviceChargeWay = @"";
        bankRate = @"";
        surcharge = @"";
        UILabel *label1 = [self.view viewWithTag:100];
        UILabel *label2 = [self.view viewWithTag:101];
        label1.text = @"首期    0.0¥";
        label2.text = @"月供    0.0¥";

    }else if(selectNumber == 1)
    {

        _tableView.periodStr = Str;
        loanPeriods = Str;
        _tableView.interestStr = _bankRateList[sid][@"rate"];
        bankRate = _bankRateList[sid][@"rate"];
    }
    else if(selectNumber == 2)
    {
        _tableView.interestTypeStr = Str;
        rateType = dic[@"dkey"];
    }
    else if(selectNumber == 3)
    {
        _tableView.feesChargedStr = Str;
        serviceChargeWay = dic[@"dkey"];
    }else if(selectNumber == 4)
    {
        _tableView.surcharge = Str;
        surcharge = dic[@"dkey"];
    }
    [self.tableView reloadData];
}


-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index
{
    UITextField *textField1 = [self.view viewWithTag:300];
    if ([BaseModel isBlankString:loanBankCode] == YES) {
        [TLAlert alertWithInfo:@"请选择银行"];
        return;
    }
    if ([BaseModel isBlankString:loanPeriods] == YES) {
        [TLAlert alertWithInfo:@"请选择贷款周期"];
        return;
    }
    if ([textField1.text isEqualToString:@""]) {
        [TLAlert alertWithInfo:@"请输入贷款金额"];
        return;
    }
    if ([BaseModel isBlankString:rateType] == YES) {
        [TLAlert alertWithInfo:@"请选择利率类型"];
        return;
    }
    if ([self.tableView.bankStr isEqualToString:@"中国银行"]) {
        if ([serviceChargeWay isEqualToString:@""]) {
            [TLAlert alertWithInfo:@"请选择手续费收取方式"];
            return;
        }else
        {
            if ([self.tableView.feesChargedStr isEqualToString:@"附加费"]) {
                if ([surcharge isEqualToString:@""]) {
                    [TLAlert alertWithInfo:@"请选择附加费"];
                    return;
                }
            }
        }
    }
    TLNetworking *http = [TLNetworking new];
    http.code = @"632690";


    http.showView = self.view;
    http.parameters[@"rateType"] = rateType;
    http.parameters[@"loanPeriods"] = [NSString stringWithFormat:@"%ld",[loanPeriods integerValue]];
    http.parameters[@"loanBankCode"] = loanBankCode;
    http.parameters[@"serviceChargeWay"] = [NSString stringWithFormat:@"%ld",[serviceChargeWay integerValue]];
    http.parameters[@"loanAmount"] = @([textField1.text floatValue] * 1000);
    http.parameters[@"bankRate"] = [NSString stringWithFormat:@"%.2f",[bankRate floatValue]];
    http.parameters[@"surcharge"] = surcharge;


    [http postWithSuccess:^(id responseObject) {

        UILabel *label1 = [self.view viewWithTag:100];
        UILabel *label2 = [self.view viewWithTag:101];
        label1.text = [NSString stringWithFormat:@"首期    %.2f¥",[responseObject[@"data"][@"initialAmount"] floatValue]/1000];
        label2.text = [NSString stringWithFormat:@"月供    %.2f¥",[responseObject[@"data"][@"annualAmount"] floatValue]/1000];

    } failure:^(NSError *error) {
        WGLog(@"%@",error);
    }];

}


@end
