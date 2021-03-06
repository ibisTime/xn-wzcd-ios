#import "AccessSingleTableView.h"
#import "InformationCell.h"
#define Information @"InformationCell"
@interface AccessSingleTableView ()<UITableViewDataSource,UITableViewDelegate>
@end
@implementation AccessSingleTableView
-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[InformationCell class] forCellReuseIdentifier:Information];
    }
    return self;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
#pragma mark -- 行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.model.count;
}
#pragma mark -- tableView
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    InformationCell *cell = [tableView cellForRowAtIndexPath:indexPath]; 
    if (cell == nil) {
        cell = [[InformationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    AccessSingleModel *model = self.model[indexPath.row];
    cell.accessSingleModel = model;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if ([model.curNodeCode isEqualToString:@"002_18"]) {
        cell.button2.hidden = NO;
        [cell.button2 setTitle:@"录入" forState:(UIControlStateNormal)];
    }
    else
    {
        cell.button2.hidden = YES;
    }
    [cell.button2 addTarget:self action:@selector(buttonClick:) forControlEvents:(UIControlEventTouchUpInside)];
    cell.button2.tag = indexPath.row;
    return cell;
}
-(void)buttonClick:(UIButton *)sender
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
    AccessSingleModel *model = self.model[indexPath.row];
    if ([model.curNodeCode isEqualToString:@"002_18"]) {
        return 330;
    }else
    {
        return 280;
    }
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
