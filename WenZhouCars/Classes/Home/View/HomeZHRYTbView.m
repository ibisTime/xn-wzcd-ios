#import "HomeZHRYTbView.h"
#import "HomeCell.h"
#define Home @"HomeCell"
#import "HomeHeadView.h"
@interface HomeZHRYTbView ()<UITableViewDelegate,UITableViewDataSource,HomeCellDelegate>
{
    NSDictionary *dataDic;
    HomeHeadView *headView;
}
@end
@implementation HomeZHRYTbView
-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[HomeCell class] forCellReuseIdentifier:Home];
        headView = [[HomeHeadView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 130)];
        self.tableHeaderView = headView;
    }
    return self;
}
-(void)setDic:(NSDictionary *)dic
{
    if ([BaseModel isBlankString:dic[@"loginName"]] == NO) {
        headView.dic = dic;
        dataDic = dic;
    }
    [self reloadData];
}
-(void)CustomTableViewHeadView
{
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
#pragma mark -- 行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
#pragma mark -- tableView
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell1";
    HomeCell *cell = [tableView cellForRowAtIndexPath:indexPath]; 
    if (cell == nil) {
        cell = [[HomeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.HomeDelegate = self;
    cell.sectionNum = indexPath.section + 100;
    cell.dic = self.RedDotDic;
    return cell;
}
-(void)cellLabel
{
    UILabel *label1 = [self viewWithTag:5000];
    UILabel *label2 = [self viewWithTag:5001];
    UILabel *label3 = [self viewWithTag:5002];
    UILabel *label4 = [self viewWithTag:5003];
    UILabel *label5 = [self viewWithTag:5004];
    UILabel *label6 = [self viewWithTag:5005];
    if ([self.RedDotDic[@"creditTodo"] integerValue] == 0) {
        label1.hidden = YES;
    }else
    {
        label1.text = [NSString stringWithFormat:@"%ld",[self.RedDotDic[@"creditTodo"] integerValue]];
        label1.hidden = NO;
        NSLog(@"%ld",[self.RedDotDic[@"creditTodo"] integerValue]);
    }
    if ([self.RedDotDic[@"interviewTodo"] integerValue] == 0) {
        label2.hidden = YES;
    }else
    {
        label2.text = [NSString stringWithFormat:@"%ld",[self.RedDotDic[@"interviewTodo"] integerValue]];
        label2.hidden = NO;
    }
    if ([self.RedDotDic[@"gpsInstallTodo"] integerValue] == 0) {
        label3.hidden = YES;
    }else
    {
        label3.text = [NSString stringWithFormat:@"%ld",[self.RedDotDic[@"gpsInstallTodo"] integerValue]];
        label3.hidden = NO;
    }
    if ([self.RedDotDic[@"carSettleTodo"] integerValue] == 0) {
        label4.hidden = YES;
    }else
    {
        label4.text = [NSString stringWithFormat:@"%ld",[self.RedDotDic[@"carSettleTodo"] integerValue]];
        label4.hidden = NO;
    }
    if ([self.RedDotDic[@"entryMortgageTodo"] integerValue] == 0) {
        label5.hidden = YES;
    }else
    {
        label5.text = [NSString stringWithFormat:@"%ld",[self.RedDotDic[@"entryMortgageTodo"] integerValue]];
        label5.hidden = NO;
    }
    if ([self.RedDotDic[@"logisticsTodo"] integerValue] == 0) {
        label6.hidden = YES;
    }else
    {
        label6.text = [NSString stringWithFormat:@"%ld",[self.RedDotDic[@"logisticsTodo"] integerValue]];
        label6.hidden = NO;
    }
}
-(void)HomeCell:(NSInteger)tag button:(UIButton *)sender
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
    return SCREEN_WIDTH/3;
}
#pragma mark -- 区头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 45;
}
#pragma mark -- 区尾高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headView = [[UIView alloc]init];
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 35)];
    backView.backgroundColor = [UIColor whiteColor];
    [headView addSubview:backView];
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(15, 10, 4, 15)];
    lineView.backgroundColor = MainColor;
    [backView addSubview:lineView];
    UILabel *headLabel = [UILabel labelWithFrame:CGRectMake(30, 0, SCREEN_WIDTH - 45, 35) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(15) textColor:[UIColor blackColor]];
    [backView addSubview:headLabel];
    NSArray *nameArray = @[@"车贷业务",@"车贷工具",@"资料传递"];
    headLabel.text = nameArray[section];
    return headView;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}
@end
