#import "ApplyTableView3.h"
#import "ChooseCell.h"
#define ChooseC @"ChooseCell"
#import "TextFieldCell.h"
#define TextField @"TextFieldCell"
#import "InputBoxCell.h"
#define InputBox @"InputBoxCell"
#import "CollectionViewCell.h"
#define CollectionView @"CollectionViewCell"
@interface ApplyTableView3 ()<UITableViewDataSource,UITableViewDelegate,CustomCollectionDelegate>
@end
@implementation ApplyTableView3
-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[ChooseCell class] forCellReuseIdentifier:ChooseC];
        [self registerClass:[TextFieldCell class] forCellReuseIdentifier:TextField];
        [self registerClass:[InputBoxCell class] forCellReuseIdentifier:InputBox];
        [self registerClass:[CollectionViewCell class] forCellReuseIdentifier:CollectionView];
    }
    return self;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 6;
}
#pragma mark -- 行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        if ([self.model.isHouseProperty isEqualToString:@"1"]) {
            return 2;
        }else
        {
            return 1;
        }
    }
    if (section == 1) {
        if ([self.model.isLicense isEqualToString:@"1"])
        {
            return 2;
        }
        else
        {
            return 1;
        }
    }
    if (section == 2) {
        if ([self.model.isDriceLicense isEqualToString:@"1"])
        {
            return 2;
        }
        else
        {
            return 1;
        }
    }
    if (section == 3) {
        return 1;
    }
    if (section == 4) {
        if ([self.model.isSiteProve isEqualToString:@"1"])
        {
            return 2;
        }
        else
        {
            return 1;
        }
    }
    return 2;
}
#pragma mark -- tableView
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section < 5) {
        if (indexPath.row == 0) {
            ChooseCell *cell = [tableView dequeueReusableCellWithIdentifier:ChooseC forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            NSArray *nameArray = @[@"*房产证情况",@"*营业执照",@"*有无驾照",@"现有车辆",@"提供证明场地"];
            cell.name = nameArray[indexPath.section];
            if (indexPath.section == 0) {
                cell.details = [self WithOrWithout:self.model.isHouseProperty];
            }
            if (indexPath.section == 1) {
                cell.details = [self WithOrWithout:self.model.isLicense];
            }
            if (indexPath.section == 2) {
                cell.details = [self WithOrWithout:self.model.isDriceLicense];
            }
            if (indexPath.section == 3) {
                cell.details = self.model.carTypeStr;
            }
            if (indexPath.section == 4) {
                cell.details = [self WithOrWithout:self.model.isSiteProve];
            }
            return cell;
        }
        if (indexPath.row == 1) {
            NSString *CellIdentifier = [NSString stringWithFormat:@"cell1%ld%ld",indexPath.section,indexPath.row];
            CollectionViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (!cell) {
                cell = [[CollectionViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
                if (indexPath.section == 0) {
                    cell.collectDataArray = self.model.housePropertyPics;
                }
                if (indexPath.section == 1) {
                    cell.collectDataArray = self.model.licensePics;
                }
                if (indexPath.section == 2) {
                    cell.collectDataArray = self.model.driceLicensePics;
                }
                if (indexPath.section == 4) {
                    cell.collectDataArray = self.model.siteProvePics;
                }
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            NSString *str = [NSString stringWithFormat:@"%ld",indexPath.section];
            cell.selectStr = str;
            cell.delegate = self;
            return cell;
        }
    }
    NSString *CellIdentifier = [NSString stringWithFormat:@"cell1%ld%ld",indexPath.section,indexPath.row];
    TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[TextFieldCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        NSArray *detailsArray = @[
                                  [NSString stringWithFormat:@"%@",self.model.siteArea],
                                  [NSString stringWithFormat:@"%@",self.model.otherPropertyNote]
                                  ];
        cell.TextFidStr = detailsArray[indexPath.row];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSArray *nameArray = @[@"经营场地面积",@"其他资产说明"];
    cell.name = nameArray[indexPath.row];
    NSArray *placArray = @[@"请输入经营场地面积",@"请输入其他资产说明"];
    cell.nameText = placArray[indexPath.row];
    cell.nameTextField.tag = 33300 + indexPath.row;
    return cell;
}
-(NSString *)WithOrWithout:(NSString *)str
{
    if ([str isEqualToString:@"1"]) {
        return @"有";
    }else if ([str isEqualToString:@"0"])
    {
        return @"无";
    }else
    {
        return @"";
    }
}
-(void)CustomCollection:(UICollectionView *)collectionView didSelectRowAtIndexPath:(NSIndexPath *)indexPath str:(NSString *)str
{
    if ([self.refreshDelegate respondsToSelector:@selector(refreshTableViewButtonClick:button:selectRowAtIndex:selectRowState:)]) {
        [self.refreshDelegate refreshTableViewButtonClick:self button:nil selectRowAtIndex:[str integerValue] selectRowState:@"add"];
    }
}
-(void)UploadImagesBtn:(UIButton *)sender str:(NSString *)str
{
    if ([self.refreshDelegate respondsToSelector:@selector(refreshTableViewButtonClick:button:selectRowAtIndex:selectRowState:)]) {
        [self.refreshDelegate refreshTableViewButtonClick:self button:sender selectRowAtIndex:sender.tag selectRowState:str];
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
    if (indexPath.section == 0) {
        if (indexPath.row == 1) {
            float numberToRound;
            int result;
            numberToRound = (self.model.housePropertyPics.count + 1.0)/3.0;
            result = (int)ceilf(numberToRound);
            return result * ((SCREEN_WIDTH - 50)/3 + 10) + 20;
        }
    }
    if (indexPath.section == 1) {
        if (indexPath.row == 1) {
            float numberToRound;
            int result;
            numberToRound = (self.model.licensePics.count + 1.0)/3.0;
            result = (int)ceilf(numberToRound);
            return result * ((SCREEN_WIDTH - 50)/3 + 10) + 20;
        }
    }
    if (indexPath.section == 2) {
        if (indexPath.row == 1) {
            float numberToRound;
            int result;
            numberToRound = (self.model.driceLicensePics.count + 1.0)/3.0;
            result = (int)ceilf(numberToRound);
            return result * ((SCREEN_WIDTH - 50)/3 + 10) + 20;
        }
    }
    if (indexPath.section == 4) {
        if (indexPath.row == 1) {
            float numberToRound;
            int result;
            numberToRound = (self.model.siteProvePics.count + 1.0)/3.0;
            result = (int)ceilf(numberToRound);
            return result * ((SCREEN_WIDTH - 50)/3 + 10) + 20;
        }
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
