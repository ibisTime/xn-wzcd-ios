#import "DetailsTableView1.h"
#import "TextFieldCell.h"
#define TextField @"TextFieldCell"
#import "AddGPSListCell.h"
#define AddGPSList @"AddGPSListCell"
@interface DetailsTableView1 ()<UITableViewDataSource,UITableViewDelegate>
@end
@implementation DetailsTableView1
-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[TextFieldCell class] forCellReuseIdentifier:TextField];
        [self registerClass:[AddGPSListCell class] forCellReuseIdentifier:AddGPSList];
    }
    return self;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
#pragma mark -- 行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 1) {
        return self.model.budgetOrderGpsList.count;
    }
    return 20;
}
#pragma mark -- tableView
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        AddGPSListCell *cell = [tableView dequeueReusableCellWithIdentifier:AddGPSList forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.dic = self.model.budgetOrderGpsList[indexPath.row];
        return cell;
    }
    TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:TextField forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSArray *nameArray = @[@"客户姓名",@"业务编号",@"客户类型",@"汽车经销售",@"贷款银行",@"厂商指导价(元)",@"*车辆型号",@"车架号",@"贷款周期(期)",@"发票价格(元)",@"购车途径",@"利率类型",@"贷款金额",@"银行利率",@"我司贷款成数",@"是否垫资",@"综合利率",@"服务费",@"厂家贴息",@"银行贷款成数"];
    cell.isInput = @"0";
    cell.name = nameArray[indexPath.row];
    switch (indexPath.row) {
        case 0:
        {
            cell.TextFidStr = self.model.customerName;
        }
            break;
        case 1:
        {
            cell.TextFidStr = self.model.code;
        }
            break;
        case 2:
        {
            cell.TextFidStr = [[BaseModel user]setParentKey:@"gps_apply_type" setDkey:self.model.customerType];
        }
            break;
        case 3:
        {
            cell.TextFidStr = self.model.carDealerType;
        }
            break;
        case 4:
        {
            cell.TextFidStr = [BaseModel convertNull:self.model.loanBankName];
        }
            break;
        case 5:
        {
            cell.TextFidStr = [NSString stringWithFormat:@"%.2f",[self.model.originalPrice floatValue]/1000];
        }
            break;
        case 6:
        {
            cell.TextFidStr = [NSString stringWithFormat:@"%@",self.model.carModel];
        }
            break;
        case 7:
        {
            cell.TextFidStr = [NSString stringWithFormat:@"%@",self.model.frameNo];
        }
            break;
        case 8:
        {
            cell.TextFidStr = [NSString stringWithFormat:@"%ld",[self.model.loanPeriods integerValue]];
        }
            break;
        case 9:
        {
            cell.TextFidStr = [NSString stringWithFormat:@"%.2f",[self.model.invoicePrice floatValue]/1000];
        }
            break;
        case 10:
        {
            NSString *shopWay;
            if ([self.model.shopWay integerValue] == 1) {
                shopWay = @"新车";
            }
            else
            {
                shopWay = @"二手车";
            }
            cell.TextFidStr = shopWay;
        }
            break;
        case 11:
        {
            cell.TextFidStr = [[BaseModel user]setParentKey:@"rate_type" setDkey:self.model.rateType];
        }
            break;
        case 12:
        {
            cell.TextFidStr = [NSString stringWithFormat:@"%.2f",[self.model.loanAmount floatValue]/1000];
        }
            break;
        case 13:
        {
            cell.TextFidStr = [BaseModel convertNull:self.model.bankRate];
        }
            break;
        case 14:
        {
            cell.TextFidStr = [BaseModel convertNull:self.model.companyLoanCs];
        }
            break;
        case 15:
        {
            cell.TextFidStr  = [self WhetherOrNot:self.model.isAdvanceFund];
        }
            break;
        case 16:
        {
            cell.TextFidStr = [BaseModel convertNull:self.model.globalRate];
        }
            break;
        case 17:
        {
            cell.TextFidStr = [NSString stringWithFormat:@"%.2f",[self.model.fee floatValue]/1000];
        }
            break;
        case 18:
        {
            cell.TextFidStr = [NSString stringWithFormat:@"%.2f",[self.model.carDealerSubsidy floatValue]/1000];
        }
            break;
        case 19:
        {
            cell.TextFidStr = self.model.bankLoanCs;
        }
            break;
        default:
            break;
    }
    return cell;
}
-(void)addGPSBtnClick:(UIButton *)sender
{
    if ([self.refreshDelegate respondsToSelector:@selector(refreshTableViewButtonClick:button:selectRowAtIndex:)]) {
        [self.refreshDelegate refreshTableViewButtonClick:self button:sender selectRowAtIndex:sender.tag];
    }
}
-(NSString *)WhetherOrNot:(NSString *)str
{
    if ([str isEqualToString:@"1"]) {
        return @"是";
    }else if ([str isEqualToString:@"0"])
    {
        return @"否";
    }else
    {
        return @"";
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.refreshDelegate respondsToSelector:@selector(refreshTableView:didSelectRowAtIndexPath:)]) {
        [self.refreshDelegate refreshTableView:self didSelectRowAtIndexPath:indexPath];
    }
}
#pragma mark -- 行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        return 125;
    }
    return 50;
}
#pragma mark -- 区头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}
#pragma mark -- 区尾高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}
@end
