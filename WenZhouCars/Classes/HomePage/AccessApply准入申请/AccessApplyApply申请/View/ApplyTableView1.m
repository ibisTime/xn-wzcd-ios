#import "ApplyTableView1.h"
#import "ChooseCell.h"
#define ChooseC @"ChooseCell"
#import "TextFieldCell.h"
#define TextField @"TextFieldCell"
#import "InputBoxCell.h"
#define InputBox @"InputBoxCell"
#import "ADDGPSCell.h"
#define ADDGPSc @"ADDGPSCell"
#import "AddGPSListCell.h"
#define AddGPSList @"AddGPSListCell"
@interface ApplyTableView1 ()<UITableViewDataSource,UITableViewDelegate>
{
}
@end
@implementation ApplyTableView1
-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[ChooseCell class] forCellReuseIdentifier:ChooseC];
        [self registerClass:[TextFieldCell class] forCellReuseIdentifier:TextField];
        [self registerClass:[InputBoxCell class] forCellReuseIdentifier:InputBox];
        [self registerClass:[ADDGPSCell class] forCellReuseIdentifier:ADDGPSc];
        [self registerClass:[AddGPSListCell class] forCellReuseIdentifier:AddGPSList];
    }
    return self;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 19;
}
#pragma mark -- 行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0 || section == 5 || section == 14) {
        return 2;
    }
    if (section == 17) {
        return self.GPSArray.count;
    }
    return 1;
}
#pragma mark -- tableView
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:TextField forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSArray *nameArray = @[@"客户姓名",@"业务编号"];
        cell.isInput = @"0";
        cell.name = nameArray[indexPath.row];
        cell.nameText = @"";
        NSArray *detailsArray = @[self.model.customerName,self.model.code];
        cell.nameTextField.text = [BaseModel convertNull:detailsArray[indexPath.row]];
        cell.nameTextField.tag = 1000 + indexPath.row;
        return cell;
    }
    if (indexPath.section == 1) {
        ChooseCell *cell = [tableView dequeueReusableCellWithIdentifier:ChooseC forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.name = @"*客户类型";
        cell.details = [[BaseModel user]setParentKey:@"gps_apply_type" setDkey:self.model.customerType];
        cell.detailsLabel.tag = 1002 + indexPath.row;
        return cell;
    }
    if (indexPath.section == 2) {
        ChooseCell *cell = [tableView dequeueReusableCellWithIdentifier:ChooseC forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.name = @"*汽车经销售";
        cell.details = self.model.carDealerCodeStr;
        cell.detailsLabel.tag = 1003 + indexPath.row;
        return cell;
    }
    if (indexPath.section == 3) {
        NSString *CellIdentifier = [NSString stringWithFormat:@"cell1%ld%ld",indexPath.section,indexPath.row];
        TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[TextFieldCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
            cell.nameTextField.text = [BaseModel convertNull:self.model.loanBankName];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.isInput = @"0";
        cell.name = @"贷款银行";
        cell.nameText = @"";
        cell.nameTextField.tag = 1004 + indexPath.row;
        return cell;
    }
    if (indexPath.section == 4) {
        NSString *CellIdentifier = [NSString stringWithFormat:@"cell1%ld%ld",indexPath.section,indexPath.row];
        InputBoxCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[InputBoxCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
            cell.nameTextField.text = [NSString stringWithFormat:@"%.2f",[self.model.originalPrice floatValue]/1000];
        }
        cell.name = @"*厂商指导价(元)";
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.nameTextField.tag = 11100;
        return cell;
    }
    if (indexPath.section == 5) {
        NSString *CellIdentifier = [NSString stringWithFormat:@"cell1%ld%ld",indexPath.section,indexPath.row];
        TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[TextFieldCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
            if (indexPath.row == 0) {
                cell.TextFidStr = [NSString stringWithFormat:@"%@",self.model.carModel];
            }else
            {
                cell.TextFidStr = [NSString stringWithFormat:@"%@",self.model.frameNo];
            }
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSArray *nameArray = @[@"*车辆型号",@"车架号"];
        cell.name = nameArray[indexPath.row];
        NSArray *placArray = @[@"请输入车辆型号",@"请输入车架号"];
        cell.nameText = placArray[indexPath.row];
        cell.nameTextField.tag = 11101 + indexPath.row;
        return cell;
    }
    if (indexPath.section == 6) {
        ChooseCell *cell = [tableView dequeueReusableCellWithIdentifier:ChooseC forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.name = @"*贷款周期(期)";
        cell.detailsLabel.text = [NSString stringWithFormat:@"%ld",[self.model.loanPeriods integerValue]];
        return cell;
    }
    if (indexPath.section == 7) {
        NSString *CellIdentifier = [NSString stringWithFormat:@"cell1%ld%ld",indexPath.section,indexPath.row];
        InputBoxCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[InputBoxCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
            cell.nameTextField.text = [NSString stringWithFormat:@"%.2f",[self.model.invoicePrice floatValue]/1000];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.name = @"*发票价格(元)";
        cell.nameTextField.tag = 11103 + indexPath.row;
        [cell.nameTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        return cell;
    }
    if (indexPath.section == 8) {
        TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:TextField forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.isInput = @"0";
        cell.name = @"购车途径";
        cell.nameText = @"";
        NSString *shopWay;
        if ([self.model.shopWay integerValue] == 1) {
            shopWay = @"新车";
        }
        else
        {
            shopWay = @"二手车";
        }
        cell.nameTextField.tag = 1010 + indexPath.row;
        cell.TextFidStr = shopWay;
        return cell;
    }
    if (indexPath.section == 9) {
        ChooseCell *cell = [tableView dequeueReusableCellWithIdentifier:ChooseC forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.name = @"*利率类型";
        cell.details = [[BaseModel user]setParentKey:@"rate_type" setDkey:self.model.rateType];
        return cell;
    }
    if (indexPath.section == 10) {
        NSString *CellIdentifier = [NSString stringWithFormat:@"cell1%ld%ld",indexPath.section,indexPath.row];
        TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[TextFieldCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
            cell.nameTextField.text = [NSString stringWithFormat:@"%.2f",[self.model.loanAmount floatValue]/1000];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.name = @"*贷款金额";
        cell.nameTextField.tag = 11104 + indexPath.row;
        [cell.nameTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        return cell;
    }
    if (indexPath.section == 11) {
        ChooseCell *cell = [tableView dequeueReusableCellWithIdentifier:ChooseC forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSArray *nameArray = @[@"*银行利率"];
        cell.name = nameArray[indexPath.row];
        cell.detailsLabel.tag = 11105 + indexPath.row;
        cell.details = [NSString stringWithFormat:@"%@",self.model.bankRate];
        return cell;
    }
    if (indexPath.section == 12) {
        NSString *CellIdentifier = [NSString stringWithFormat:@"cell1%ld%ld",indexPath.section,indexPath.row];
        TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[TextFieldCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
            cell.nameTextField.text = [BaseModel convertNull:self.model.companyLoanCs];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.isInput = @"0";
        cell.name = @"我司贷款成数";
        cell.nameText = @"";
        cell.nameTextField.tag = 11106 + indexPath.row;
        [cell.nameTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        return cell;
    }
    if (indexPath.section == 13) {
        ChooseCell *cell = [tableView dequeueReusableCellWithIdentifier:ChooseC forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.name = @"*是否垫资";
        cell.details = [self WhetherOrNot:self.model.isAdvanceFund];
        return cell;
    }
    if (indexPath.section == 14) {
        NSString *CellIdentifier = [NSString stringWithFormat:@"cell1%ld%ld",indexPath.section,indexPath.row];
        TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[TextFieldCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
            if (indexPath.row == 0) {
                cell.nameTextField.text = [BaseModel convertNull:self.model.globalRate];
                cell.isInput = @"0";
                cell.nameTextField.tag = 11107 + indexPath.row;
            }else
            {
                cell.nameTextField.text = [NSString stringWithFormat:@"%.2f",[self.model.fee floatValue]/1000];
                cell.nameText = @"请输入服务费";
                cell.nameTextField.tag = 11111;
            }
        }
        [cell.nameTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSArray *nameArray = @[@"综合利率",@"服务费"];
        cell.name = nameArray[indexPath.row];
        cell.nameText = @"";
        return cell;
    }
    if (indexPath.section == 15) {
        NSString *CellIdentifier = [NSString stringWithFormat:@"cell1%ld%ld",indexPath.section,indexPath.row];
        InputBoxCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[InputBoxCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
            cell.nameTextField.text = [NSString stringWithFormat:@"%.2f",[self.model.carDealerSubsidy floatValue]/1000];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.name = @"*厂家贴息";
        cell.nameTextField.tag = 11108 + indexPath.row;
        return cell;
    }
    if (indexPath.section == 16) {
        TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:TextField forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.isInput = @"0";
        cell.name = @"银行贷款成数";
        cell.nameText = @"";
        cell.TextFidStr = self.model.bankLoanCs;
        cell.nameTextField.tag = 11109 + indexPath.row;
        return cell;
    }
    if (indexPath.section == 17) {
        AddGPSListCell *cell = [tableView dequeueReusableCellWithIdentifier:AddGPSList forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.dic = self.GPSArray[indexPath.row];
        return cell;
    }
    ADDGPSCell *cell = [tableView dequeueReusableCellWithIdentifier:ADDGPSc forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell.addGPSBtn addTarget:self action:@selector(addGPSBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
    cell.addGPSBtn.tag = 12345;
    return cell;
}
- (void)textFieldDidChange:(UITextField *)textField{
    if (textField.markedTextRange == nil) {
        NSLog(@"text:%@", textField.text);
        UITextField *textField11104 = [self viewWithTag:11104];
        UITextField *textField11106 = [self viewWithTag:11106];
        UITextField *textField11107 = [self viewWithTag:11107];
        UITextField *textField11103 = [self viewWithTag:11103];
        UITextField *textField11109 = [self viewWithTag:11109];
        UITextField *textField11111 = [self viewWithTag:11111];
        if (textField.tag == 11104) {
            textField11106.text = [NSString stringWithFormat:@"%.2f",[textField.text floatValue]/[textField11103.text floatValue]];
            textField11107.text = [NSString stringWithFormat:@"%.2f",[textField11111.text floatValue]/[textField.text floatValue] + [self.model.bankRate floatValue]];
            textField11109.text = [NSString stringWithFormat:@"%.2f",([textField11111.text floatValue]+[textField.text floatValue]) / [textField11103.text floatValue]];
        }
        if (textField.tag == 11103) {
            textField11106.text = [NSString stringWithFormat:@"%.2f",[textField11104.text floatValue]/[textField.text floatValue]];
            textField11109.text = [NSString stringWithFormat:@"%.2f",([textField11111.text floatValue]+[textField11104.text floatValue]) / [textField.text floatValue]];
        }
        if (textField.tag == 11111) {
            textField11107.text = [NSString stringWithFormat:@"%.2f",[textField.text floatValue]/[textField11104.text floatValue] + [self.model.bankRate floatValue]];
            textField11109.text = [NSString stringWithFormat:@"%.2f",([textField.text floatValue]+[textField11104.text floatValue]) / [textField11103.text floatValue]];
        }
    }
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
    if (indexPath.section == 17 || indexPath.section == 18) {
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
