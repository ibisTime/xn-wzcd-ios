#import "InstallationDetailsTableView.h"
#import "TextFieldCell.h"
#define TextField @"TextFieldCell"
#import "SurveyPeopleTableViewCell.h"
#define SurveyPeople @"SurveyPeopleTableViewCell"
#import "GPSInformationListCell.h"
#define GPSInformationList @"GPSInformationListCell"
@interface InstallationDetailsTableView ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation InstallationDetailsTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {

    if (self = [super initWithFrame:frame style:style]) {
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[TextFieldCell class] forCellReuseIdentifier:TextField];
        [self registerClass:[SurveyPeopleTableViewCell class] forCellReuseIdentifier:SurveyPeople];
        [self registerClass:[GPSInformationListCell class] forCellReuseIdentifier:GPSInformationList];
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
        return 4;
    }
    return _model.budgetOrderGpsList.count;
}

#pragma mark -- tableView
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:TextField forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSArray *nameArray = @[@"客户姓名",@"业务编号",@"贷款银行",@"贷款金额"];
        cell.name = nameArray[indexPath.row];
        cell.isInput = @"0";
        NSArray *detailsArray = @[
                                  [NSString stringWithFormat:@"%@", _model.customerName],
                                  [NSString stringWithFormat:@"%@", _model.code],
                                  [NSString stringWithFormat:@"%@", _model.loanBankName],
                                  [NSString stringWithFormat:@"%.2f  ¥", [_model.credit[@"loanAmount"] floatValue]]
                                  ];
        cell.TextFidStr = detailsArray[indexPath.row];
        return cell;
    }
    GPSInformationListCell *cell = [tableView dequeueReusableCellWithIdentifier:GPSInformationList forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.dic = _model.budgetOrderGpsList[indexPath.row];
//    [cell.deleteBtn addTarget:self action:@selector(deleteBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
    cell.deleteBtn.tag = indexPath.row;
    return cell;
}

//添加证信人
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
    if (indexPath.section == 1) {
        return 215;
    }
    return 50;
}

#pragma mark -- 区头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return 50;
    }
    return 0.01;
}

#pragma mark -- 区尾高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return 10;
    }
    return 0.01;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        UIView *headView = [[UIView alloc]init];
        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
        backView.backgroundColor = [UIColor whiteColor];
        [headView addSubview:backView];

        UILabel *headLabel = [UILabel labelWithFrame:CGRectMake(15, 0, SCREEN_WIDTH - 30, 50) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(15) textColor:[UIColor blackColor]];
        headLabel.text = @"已安装列表";
        [backView addSubview:headLabel];

        return headView;
    }
    return nil;
    return nil;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{

    return nil;
}

@end
