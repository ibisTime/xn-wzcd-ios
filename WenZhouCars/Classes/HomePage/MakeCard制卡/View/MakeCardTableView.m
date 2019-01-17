#import "MakeCardTableView.h"
#import "InformationCell.h"
#define Information @"InformationCell"
@interface MakeCardTableView ()<UITableViewDataSource,UITableViewDelegate>
@end
@implementation MakeCardTableView
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
    InformationCell *cell = [tableView dequeueReusableCellWithIdentifier:Information forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self.model.count > 0) {
        cell.makeCardModel = self.model[indexPath.row];
    }
    MakeCardModel *model = self.model[indexPath.row];
    if ([model.makeCardStatus integerValue] == 2) {
        [cell.button2 setTitle:@"录入" forState:(UIControlStateNormal)];
        cell.button2.hidden = NO;
    }else
    {
        cell.button2.hidden = YES;
    }
    [cell.button2 addTarget:self action:@selector(buttonClick2:) forControlEvents:(UIControlEventTouchUpInside)];
    cell.button2.tag = indexPath.row;
    return cell;
}
-(void)buttonClick2:(UIButton *)sender
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
    MakeCardModel *model = self.model[indexPath.row];
    if ([model.makeCardStatus integerValue] == 2) {
        return 330;
    }
    return 280;
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
