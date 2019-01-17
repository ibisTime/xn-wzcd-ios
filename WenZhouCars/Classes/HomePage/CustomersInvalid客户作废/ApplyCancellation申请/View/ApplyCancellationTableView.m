#import "ApplyCancellationTableView.h"
#import "ChooseCell.h"
#define Choose @"ChooseCell"
#import "TextFieldCell.h"
#define TextField @"TextFieldCell"
@interface ApplyCancellationTableView ()<UITableViewDataSource,UITableViewDelegate>
{
    AccessSingleModel *accessSingleModel;
}
@end
@implementation ApplyCancellationTableView
-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[ChooseCell class] forCellReuseIdentifier:Choose];
        [self registerClass:[TextFieldCell class] forCellReuseIdentifier:TextField];
    }
    return self;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
#pragma mark -- 行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 1) {
        return 3;
    }
    return 1;
}
-(void)setModel:(AccessSingleModel *)model
{
    accessSingleModel = model;
    [self reloadData];
}
#pragma mark -- tableView
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        ChooseCell *cell = [tableView dequeueReusableCellWithIdentifier:Choose forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.name = @"业务编号";
        cell.xiaImage.image = HGImage(@"you");
        cell.xiaImage.frame = CGRectMake(SCREEN_WIDTH - 25, 17.5, 7.5, 15);
        if ([BaseModel isBlankString:accessSingleModel.code] == NO) {
            cell.detailsLabel.text = accessSingleModel.code;
        }
        return cell;
    }
    if (indexPath.section == 1) {
        TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:TextField forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSArray *nameArray = @[@"客户姓名",@"贷款银行",@"贷款金额"];
        cell.name = nameArray[indexPath.row];
        cell.isInput = @"0";
        if ([BaseModel isBlankString:accessSingleModel.code] == NO) {
            NSArray *array = @[
                               [NSString stringWithFormat:@"%@",accessSingleModel.customerName],
                               [NSString stringWithFormat:@"%@",accessSingleModel.loanBankName],
                               [NSString stringWithFormat:@"%.2f",[accessSingleModel.loanAmount floatValue]/1000]
                               ];
            cell.TextFidStr = array[indexPath.row];
        }
        return cell;
    }
    TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:TextField forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.name = @"作废原因";
    cell.nameText = @"请输入作废原因";
    cell.nameTextField.tag = 100;
    return cell;
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
    return 50;
}
#pragma mark -- 区头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 2) {
        return 10;
    }
    return 0.01;
}
#pragma mark -- 区尾高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 2) {
        return 100;
    }
    return 0.01;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 2) {
        UIView *headView = [[UIView alloc]init];
        UIButton *confirmButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        confirmButton.frame = CGRectMake(20, 30, SCREEN_WIDTH - 40, 50);
        [confirmButton setTitle:@"确认" forState:(UIControlStateNormal)];
        confirmButton.backgroundColor = MainColor;
        kViewRadius(confirmButton, 5);
        confirmButton.titleLabel.font = HGfont(18);
        [confirmButton addTarget:self action:@selector(confirmButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
        [headView addSubview:confirmButton];
        return headView;
    }
    return nil;
}
-(void)confirmButtonClick:(UIButton *)sender
{
    if ([self.refreshDelegate respondsToSelector:@selector(refreshTableViewButtonClick:button:selectRowAtIndex:)]) {
        [self.refreshDelegate refreshTableViewButtonClick:self button:sender selectRowAtIndex:sender.tag];
    }
}
@end
