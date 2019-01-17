#import "DetailsTableView4.h"
#define ChooseC @"ChooseCell"
#import "TextFieldCell.h"
#define TextField @"TextFieldCell"
#import "InputBoxCell.h"
#define InputBox @"InputBoxCell"
@interface DetailsTableView4 ()<UITableViewDataSource,UITableViewDelegate>
@end
@implementation DetailsTableView4
-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[TextFieldCell class] forCellReuseIdentifier:ChooseC];
        [self registerClass:[TextFieldCell class] forCellReuseIdentifier:TextField];
        [self registerClass:[InputBoxCell class] forCellReuseIdentifier:InputBox];
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
    return 3;
}
#pragma mark -- tableView
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:TextField forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSArray *nameArray = @[@"*联系人1姓名",@"联系人2姓名"];
        cell.name = nameArray[indexPath.section];
        NSArray *detailsArray = @[
                                  [NSString stringWithFormat:@"%@",self.model.emergencyName1],
                                  [NSString stringWithFormat:@"%@",self.model.emergencyName2]
                                  ];
        cell.TextFidStr = detailsArray[indexPath.section];
        cell.isInput = @"0";
        return cell;
    }
    if (indexPath.row == 1) {
        TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:ChooseC forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSArray *nameArray =@[@"*与申请人关系",@"与申请人关系"];
        cell.name = nameArray[indexPath.row];
        if (indexPath.section == 0) {
            cell.TextFidStr = [NSString stringWithFormat:@"%@",[[BaseModel user]setParentKey:@"emergency_contact_relation" setDkey:self.model.emergencyRelation1]];
        }else
        {
            cell.TextFidStr = [NSString stringWithFormat:@"%@",[[BaseModel user]setParentKey:@"emergency_contact_relation" setDkey:self.model.emergencyRelation2]];
        }
        cell.isInput = @"0";
        return cell;
    }
    TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:TextField forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSArray *nameArray = @[@"*手机号码",@"手机号码"];
    cell.name = nameArray[indexPath.section];
    cell.isInput = @"0";
    NSArray *detailsArray = @[
                              [NSString stringWithFormat:@"%@",self.model.emergencyMobile1],
                              [NSString stringWithFormat:@"%@",self.model.emergencyMobile2]
                              ];
    cell.TextFidStr = detailsArray[indexPath.section];
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
