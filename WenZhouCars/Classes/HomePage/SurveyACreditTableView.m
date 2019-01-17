#import "SurveyACreditTableView.h"
#import "ChooseCell.h"
#import "InputBoxCell.h"
#import "SurveyPeopleTableViewCell.h"
#import "TextFieldCell.h"
#define ChooseC @"ChooseCell"
#define InputBox @"InputBoxCell"
#define SurveyPeople @"SurveyPeopleTableViewCell"
#define TextField @"TextFieldCell"
#import "CarSettledUpdataPhotoCell.h"
#define CarSettledUpdataPhoto @"CarSettledUpdataPhotoCell"
#import "UsedCarEvaluationReportCell.h"
#define UsedCarEvaluationReport @"UsedCarEvaluationReportCell"
@interface SurveyACreditTableView ()<UITableViewDataSource,UITableViewDelegate,SurveyPeopleDelegate>
@end
@implementation SurveyACreditTableView
-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[ChooseCell class] forCellReuseIdentifier:ChooseC];
        [self registerClass:[InputBoxCell class] forCellReuseIdentifier:InputBox];
        [self registerClass:[SurveyPeopleTableViewCell class] forCellReuseIdentifier:SurveyPeople];
        [self registerClass:[TextFieldCell class] forCellReuseIdentifier:TextField];
        [self registerClass:[CarSettledUpdataPhotoCell class] forCellReuseIdentifier:CarSettledUpdataPhoto];
        [self registerClass:[UsedCarEvaluationReportCell class] forCellReuseIdentifier:UsedCarEvaluationReport];
    }
    return self;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([_speciesStr isEqualToString:@"新车"] || [_speciesStr isEqualToString:@""]) {
        return 3;
    }else
    {
        return 4;
    }
}
#pragma mark -- 行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 2;
    }
    return 1;
}
#pragma mark -- tableView
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        ChooseCell *cell = [tableView dequeueReusableCellWithIdentifier:ChooseC forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSArray *nameArray = @[@"银行",@"业务种类"];
        cell.name = nameArray[indexPath.row];
        NSArray *detailsArray = @[_bankStr,_speciesStr];
        cell.detailsLabel.text = detailsArray[indexPath.row];
        return cell;
    }
    if (indexPath.section == 1) {
        InputBoxCell *cell = [tableView dequeueReusableCellWithIdentifier:InputBox forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.name = @"贷款金额";
        cell.nameText = @"请输入贷款金额";
        cell.nameTextField.tag = 300;
        return cell;
    }
    if ([_speciesStr isEqualToString:@"新车"] || [_speciesStr isEqualToString:@""]) {
        SurveyPeopleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SurveyPeople forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.name = @"征信人";
        cell.btnStr = @"添加征信人";
        cell.delegate = self;
        [cell.photoBtn addTarget:self action:@selector(photoBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
        if (_peopleAray.count > 0) {
            cell.peopleArray = _peopleAray;
        }
        return cell;
    }else
    {
        if (indexPath.section == 2) {
            UsedCarEvaluationReportCell *cell = [tableView dequeueReusableCellWithIdentifier:UsedCarEvaluationReport forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.ZMStr = self.ZMStr;
            cell.FMStr = self.FMStr;
            [cell.ZMBtn addTarget:self action:@selector(BtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
            cell.ZMBtn.tag = 100;
            [cell.FMBtn addTarget:self action:@selector(BtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
            cell.FMBtn.tag = 101;
            return cell;
        }
        SurveyPeopleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SurveyPeople forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.name = @"征信人";
        cell.btnStr = @"添加征信人";
        cell.delegate = self;
        [cell.photoBtn addTarget:self action:@selector(photoBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
        if (_peopleAray.count > 0) {
            cell.peopleArray = _peopleAray;
        }
        return cell;
    }
}
-(void)BtnClick:(UIButton *)sender
{
    if ([self.refreshDelegate respondsToSelector:@selector(refreshTableViewButtonClick:button:selectRowAtIndex:selectRowState:)]) {
        [self.refreshDelegate refreshTableViewButtonClick:self button:sender selectRowAtIndex:sender.tag selectRowState:@"add"];
    }
}
-(void)SurveyPeopleSelectButton:(UIButton *)sender
{
    if ([self.refreshDelegate respondsToSelector:@selector(refreshTableViewButtonClick:button:selectRowAtIndex:)]) {
        [self.refreshDelegate refreshTableViewButtonClick:self button:sender selectRowAtIndex:sender.tag];
    }
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
    if ([_speciesStr isEqualToString:@"新车"] || [_speciesStr isEqualToString:@""]) {
        if (indexPath.section == 2) {
            return 50 + 15 + (_peopleAray.count + 1)*145 + 5;
        }
        return 50;
    }else
    {
        if (indexPath.section == 2) {
            return SCREEN_WIDTH/3 + 15;
        }
        if (indexPath.section == 3) {
            return 50 + 15 + (_peopleAray.count + 1)*145 + 5;
        }
        return 50;
    }
}
#pragma mark -- 区头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if ([_speciesStr isEqualToString:@"新车"] || [_speciesStr isEqualToString:@""]) {
        if (section == 0 || section == 3) {
            return 0.01;
        }
        return 10;
    }else
    {
        if (section == 0 || section == 4) {
            return 0.01;
        }
        if (section == 2) {
            return 50;
        }
        return 10;
    }
}
#pragma mark -- 区尾高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if ([_speciesStr isEqualToString:@"新车"] || [_speciesStr isEqualToString:@""]) {
        if (section == 2) {
            return 100;
        }
        return 0.01;
    }else
    {
        if (section == 3) {
            return 100;
        }
        return 0.01;
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if ([_speciesStr isEqualToString:@"二手车"]) {
        if (section == 2) {
            UIView *headView = [[UIView alloc]init];
            UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
            backView.backgroundColor = [UIColor whiteColor];
            [headView addSubview:backView];
            UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
            lineView.backgroundColor = LineBackColor;
            [headView addSubview:lineView];
            UILabel *nameLabel = [UILabel labelWithFrame:CGRectMake(15, 0, SCREEN_WIDTH, 50) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(14) textColor:[UIColor blackColor]];
            nameLabel.text = @"二手车评估报告";
            [headView addSubview:nameLabel];
            return headView;
        }
    }
    return nil;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if ([_speciesStr isEqualToString:@"新车"] || [_speciesStr isEqualToString:@""]) {
        if (section == 2) {
            UIView *headView = [[UIView alloc]init];
            UIButton *initiateButton = [UIButton buttonWithTitle:@"发起" titleColor:[UIColor whiteColor] backgroundColor:MainColor titleFont:18];
            initiateButton.frame = CGRectMake(15, 30, SCREEN_WIDTH - 30, 50);
            kViewRadius(initiateButton, 5);
            [initiateButton addTarget:self action:@selector(confirmButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
            initiateButton.tag = 100;
            [headView addSubview:initiateButton];
            return headView;
        }
    }else
    {
        if (section == 3) {
            UIView *headView = [[UIView alloc]init];
            UIButton *initiateButton = [UIButton buttonWithTitle:@"发起" titleColor:[UIColor whiteColor] backgroundColor:MainColor titleFont:18];
            initiateButton.frame = CGRectMake(15, 30, SCREEN_WIDTH - 30, 50);
            kViewRadius(initiateButton, 5);
            [initiateButton addTarget:self action:@selector(confirmButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
            initiateButton.tag = 100;
            [headView addSubview:initiateButton];
            return headView;
        }
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
