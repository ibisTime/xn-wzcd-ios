#import "ADPeopleTableView.h"
#import "ChooseCell.h"
#define ChooseC @"ChooseCell"
#import "TextFieldCell.h"
#define TextField @"TextFieldCell"
#import "UploadIdCardCell.h"
#define UploadIdCard @"UploadIdCardCell"
#import "CollectionViewCell.h"
#define CollectionView @"CollectionViewCell"
#import "UploadSingleImageCell.h"
#define UploadSingleImage @"UploadSingleImageCell"
@interface ADPeopleTableView ()<UITableViewDataSource,UITableViewDelegate,UploadIdCardDelegate,CustomCollectionDelegate>
@end
@implementation ADPeopleTableView
-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[ChooseCell class] forCellReuseIdentifier:ChooseC];
        [self registerClass:[TextFieldCell class] forCellReuseIdentifier:TextField];
        [self registerClass:[UploadIdCardCell class] forCellReuseIdentifier:UploadIdCard];
        [self registerClass:[CollectionViewCell class] forCellReuseIdentifier:CollectionView];
        [self registerClass:[UploadSingleImageCell class] forCellReuseIdentifier:UploadSingleImage];
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
    if (section == 1 || section == 2 || section == 4 ) {
        return 2;
    }
    return 1;
}
#pragma mark -- tableView
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        UploadIdCardCell *cell = [tableView dequeueReusableCellWithIdentifier:UploadIdCard forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.IdCardDelegate = self;
        cell.idNoFront = self.idNoFront;
        cell.idNoReverse = self.idNoReverse;
        return cell;
    }
    if (indexPath.section == 1) {
        TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:TextField forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSArray *nameArray = @[@"姓名",@"手机号"];
        NSArray *placeholderArray = @[@"请输入姓名",@"请输入手机号"];
        cell.name = nameArray[indexPath.row];
        cell.nameText = placeholderArray[indexPath.row];
        cell.nameTextField.tag = 200 + indexPath.row;
        if (self.selectRow > 1000) {
            NSArray *Array = @[_dataDic[@"userName"],_dataDic[@"mobile"]];
            cell.TextFidStr = Array[indexPath.row];
        }
        return cell;
    }
    if (indexPath.section == 2) {
        ChooseCell *cell = [tableView dequeueReusableCellWithIdentifier:ChooseC forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSArray *nameArray = @[@"贷款角色",@"与借款人关系"];
        cell.name = nameArray[indexPath.row];
        if (indexPath.row == 0) {
            if ([BaseModel isBlankString:self.loanRole] == NO) {
                cell.details = [[BaseModel user] setParentKey:@"credit_user_loan_role" setDkey:self.loanRole];
            }
        }else
        {
            if ([BaseModel isBlankString:self.relation] == NO) {
                cell.details = [[BaseModel user] setParentKey:@"credit_user_relation" setDkey:self.relation];
            }
        }
        return cell;
    }
    if (indexPath.section == 3) {
        TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:TextField forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.name = @"身份证号";
        cell.nameText = @"请输入身份证号";
        cell.nameTextField.tag = 202;
        if (self.selectRow > 1000) {
            cell.TextFidStr = _dataDic[@"idNo"];
        }
        return cell;
    }
    UploadSingleImageCell *cell = [tableView dequeueReusableCellWithIdentifier:UploadSingleImage forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSArray *array = @[@"增信查询授权书",@"面签照片"];
    cell.uploadStr = array[indexPath.row];
    [cell.photoBtn addTarget:self action:@selector(photoBtnCick:) forControlEvents:(UIControlEventTouchUpInside)];
    cell.photoBtn.tag = indexPath.row + 100;
    if (indexPath.row == 0) {
        cell.uploadPhoto = _CerStr;
    }else
    {
        cell.uploadPhoto = _FaceStr;
    }
    return cell;
}
-(void)photoBtnCick:(UIButton *)sender
{
    if (sender.tag == 50) {
        if ([self.refreshDelegate respondsToSelector:@selector(refreshTableViewButtonClick:button:selectRowAtIndex:selectRowState:)]) {
            [self.refreshDelegate refreshTableViewButtonClick:self button:sender selectRowAtIndex:sender.tag selectRowState:@"Cer"];
        }
    }else
    {
        if ([self.refreshDelegate respondsToSelector:@selector(refreshTableViewButtonClick:button:selectRowAtIndex:selectRowState:)]) {
            [self.refreshDelegate refreshTableViewButtonClick:self button:sender selectRowAtIndex:sender.tag selectRowState:@"Face"];
        }
    }
}
-(void)selectButtonClick:(UIButton *)sender
{
    [_ButtonDelegate selectButtonClick:sender];
}
-(void)UploadIdCardBtn:(UIButton *)sender
{
    if ([self.refreshDelegate respondsToSelector:@selector(refreshTableViewButtonClick:button:selectRowAtIndex:selectRowState:)]) {
        [self.refreshDelegate refreshTableViewButtonClick:self button:sender selectRowAtIndex:sender.tag selectRowState:@"IDCard"];
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
    if (indexPath.section == 0 || indexPath.section == 4) {
        return SCREEN_WIDTH/3 + 70;
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
    if (section == 4) {
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
    if (section == 4) {
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
    if ([self.refreshDelegate respondsToSelector:@selector(refreshTableViewButtonClick:button:selectRowAtIndex:selectRowState:)]) {
        [self.refreshDelegate refreshTableViewButtonClick:self button:sender selectRowAtIndex:sender.tag selectRowState:@"confirm"];
    }
}
@end
