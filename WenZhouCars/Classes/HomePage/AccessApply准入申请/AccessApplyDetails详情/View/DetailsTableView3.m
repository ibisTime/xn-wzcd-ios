#import "DetailsTableView3.h"
#define ChooseC @"ChooseCell"
#import "TextFieldCell.h"
#define TextField @"TextFieldCell"
#import "InputBoxCell.h"
#define InputBox @"InputBoxCell"
#import "CollectionCell1.h"
#define CollectionView @"CollectionCell1"
@interface DetailsTableView3 ()<UITableViewDataSource,UITableViewDelegate,CustomCollectionDelegate>
@end
@implementation DetailsTableView3
-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[TextFieldCell class] forCellReuseIdentifier:ChooseC];
        [self registerClass:[TextFieldCell class] forCellReuseIdentifier:TextField];
        [self registerClass:[InputBoxCell class] forCellReuseIdentifier:InputBox];
        [self registerClass:[CollectionCell1 class] forCellReuseIdentifier:CollectionView];
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
            TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:ChooseC forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            NSArray *nameArray = @[@"*房产证情况",@"*营业执照",@"*有无驾照",@"现有车辆",@"提供证明场地"];
            cell.name = nameArray[indexPath.section];
            if (indexPath.section == 0) {
                cell.TextFidStr = [self WithOrWithout:self.model.isHouseProperty];
            }
            if (indexPath.section == 1) {
                cell.TextFidStr = [self WithOrWithout:self.model.isLicense];
            }
            if (indexPath.section == 2) {
                cell.TextFidStr = [self WithOrWithout:self.model.isDriceLicense];
            }
            if (indexPath.section == 3) {
                cell.TextFidStr = self.model.carTypeStr;
            }
            if (indexPath.section == 4) {
                cell.TextFidStr = [self WithOrWithout:self.model.isSiteProve];
            }
            cell.isInput = @"0";
            return cell;
        }
        if (indexPath.row == 1) {
            CollectionCell1 *cell = [tableView dequeueReusableCellWithIdentifier:CollectionView forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            NSString *str = [NSString stringWithFormat:@"%ld",indexPath.section];
            cell.selectStr = str;
            cell.delegate = self;
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
            return cell;
        }
    }
    TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:TextField forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSArray *nameArray = @[@"经营场地面积",@"其他资产说明"];
    cell.name = nameArray[indexPath.row];
    cell.nameTextField.tag = 33300 + indexPath.row;
    NSArray *detailsArray = @[
                              [NSString stringWithFormat:@"%@",self.model.siteArea],
                              [NSString stringWithFormat:@"%@",self.model.otherPropertyNote]
                              ];
    cell.isInput = @"0";
    cell.TextFidStr = detailsArray[indexPath.row];
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
            CGFloat picNumber = self.model.housePropertyPics.count;
            numberToRound = (picNumber)/3.0;
            result = (int)ceilf(numberToRound);
            if (result > 0) {
                return result * ((SCREEN_WIDTH - 50)/3 + 10) + 20;
            }else
            {
                return 0.01;
            }
        }
    }
    if (indexPath.section == 1) {
        if (indexPath.row == 1) {
            float numberToRound;
            int result;
            CGFloat picNumber = self.model.licensePics.count;
            numberToRound = (picNumber)/3.0;
            result = (int)ceilf(numberToRound);
            if (result > 0) {
                return result * ((SCREEN_WIDTH - 50)/3 + 10) + 20;
            }else
            {
                return 0.01;
            }
        }
    }
    if (indexPath.section == 2) {
        if (indexPath.row == 1) {
            float numberToRound;
            int result;
            CGFloat picNumber = self.model.driceLicensePics.count;
            numberToRound = (picNumber)/3.0;
            WGLog(@"%@",self.model.driceLicensePics);
            WGLog(@"%.2f",numberToRound);
            result = (int)ceilf(numberToRound);
            if (result > 0) {
                return result * ((SCREEN_WIDTH - 50)/3 + 10) + 20;
            }else
            {
                return 0.01;
            }
        }
    }
    if (indexPath.section == 4) {
        if (indexPath.row == 1) {
            float numberToRound;
            int result;
            CGFloat picNumber = self.model.siteProvePics.count;
            numberToRound = (picNumber)/3.0;
            result = (int)ceilf(numberToRound);
            if (result > 0) {
                return result * ((SCREEN_WIDTH - 50)/3 + 10) + 20;
            }else
            {
                return 0.01;
            }
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
