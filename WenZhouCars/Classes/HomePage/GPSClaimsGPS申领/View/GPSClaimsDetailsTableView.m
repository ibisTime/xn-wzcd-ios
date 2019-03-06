#import "GPSClaimsDetailsTableView.h"
#import "TextFieldCell.h"
#define TextField @"TextFieldCell"
@interface GPSClaimsDetailsTableView ()<UITableViewDataSource,UITableViewDelegate>
@end
@implementation GPSClaimsDetailsTableView
-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[TextFieldCell class] forCellReuseIdentifier:TextField];
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
    if (section == 0) {
        return 3;
    }
    return self.model.gpsList.count + 1;
}
#pragma mark -- tableView
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:TextField forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSArray *nameArray = @[@"状态",@"申请个数",@"申请说明"];
        cell.name = nameArray[indexPath.row];
        cell.isInput = @"0";
        NSString *state;
        if (_model.status == 0) {
            state = @"待审核";
        }else if (_model.status == 1)
        {
            state = @"审核通过,待发货";
        }
        else if (_model.status == 2)
        {
            state = @"审核不通过";
        }
        else if (_model.status == 3)
        {
            state = @"已发货,待收货";
        }else
        {
            state = @"已收货";
        }
        NSArray *textFidArray = @[
                                  state,
                                  [NSString stringWithFormat:@"%@个",_model.applyCount],
                                  [NSString stringWithFormat:@"%@",_model.applyReason]
                                  ];
        cell.TextFidStr = textFidArray[indexPath.row];
        return cell;
    }
    TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:TextField forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row == 0) {
        cell.name = @"GPS列表";
    }else
    {
        cell.name = @"设备号";
        cell.TextFidStr = self.model.gpsList[indexPath.row - 1][@"gpsDevNo"];
    }
    return cell;
}
-(void)photoBtnClick:(UIButton *)sender
{
    if ([self.refreshDelegate respondsToSelector:@selector(refreshTableViewButtonClick:button:selectRowAtIndex:)]) {
        [self.refreshDelegate refreshTableViewButtonClick:self button:sender selectRowAtIndex:sender.tag];
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
    return 50;
}
#pragma mark -- 区头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return 10;
    }
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
