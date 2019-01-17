#import "ApplyTableView6.h"
#import "ChooseCell.h"
#define ChooseC @"ChooseCell"
#import "TextFieldCell.h"
#define TextField @"TextFieldCell"
#import "InputBoxCell.h"
#define InputBox @"InputBoxCell"
@interface ApplyTableView6 ()<UITableViewDataSource,UITableViewDelegate>
@end
@implementation ApplyTableView6
-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[ChooseCell class] forCellReuseIdentifier:ChooseC];
        [self registerClass:[TextFieldCell class] forCellReuseIdentifier:TextField];
        [self registerClass:[InputBoxCell class] forCellReuseIdentifier:InputBox];
    }
    return self;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}
#pragma mark -- 行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 4) {
        return 2;
    }
    return 1;
}
#pragma mark -- tableView
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        NSString *CellIdentifier = [NSString stringWithFormat:@"cell1%ld%ld",indexPath.section,indexPath.row];
        TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[TextFieldCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
            cell.TextFidStr = self.model.oilSubsidyKil;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSArray *nameArray = @[@"*油补公里数"];
        cell.name = nameArray[indexPath.row];
        NSArray *placArray = @[@"请输入油补公里数"];
        cell.nameText = placArray[indexPath.row];
        cell.nameTextField.tag = 66600;
        return cell;
    }
    if (indexPath.section == 1) {
        NSString *CellIdentifier = [NSString stringWithFormat:@"cell1%ld%ld",indexPath.section,indexPath.row];
        InputBoxCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[InputBoxCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
            cell.detailsStr = [NSString stringWithFormat:@"%.2f",[self.model.oilSubsidy floatValue]/1000];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.name = @"油补";
        cell.nameTextField.tag = 66601;
        return cell;
    }
    if (indexPath.section ==2) {
        ChooseCell *cell = [tableView dequeueReusableCellWithIdentifier:ChooseC forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.name = @"*我司续保";
        cell.details = [self WhetherOrNot:self.model.isPlatInsure];
        return cell;
    }
    if (indexPath.section == 3) {
        NSString *CellIdentifier = [NSString stringWithFormat:@"cell1%ld%ld",indexPath.section,indexPath.row];
        InputBoxCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[InputBoxCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
            cell.detailsStr = [NSString stringWithFormat:@"%.2f",[self.model.gpsDeduct floatValue]/1000];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.name = @"GPS提成";
        cell.nameText = @"请输入GPS提成";
        cell.nameTextField.tag = 66602;
        return cell;
    }
    ChooseCell *cell = [tableView dequeueReusableCellWithIdentifier:ChooseC forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSArray *nameArray = @[@"GPS收费方式",@"收客户手续费收取方式"];
    cell.name = nameArray[indexPath.row];
    NSArray *detailsArray = @[
                              [[BaseModel user]setParentKey:@"gps_fee_way" setDkey:self.model.gpsFeeWay],
                              [[BaseModel user]setParentKey:@"fee_way" setDkey:self.model.bocFeeWay]
                              ];
    cell.details = detailsArray[indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.refreshDelegate respondsToSelector:@selector(refreshTableView:didSelectRowAtIndexPath:)]) {
        [self.refreshDelegate refreshTableView:self didSelectRowAtIndexPath:indexPath];
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
#pragma mark -- 行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
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
