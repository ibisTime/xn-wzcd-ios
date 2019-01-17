#import "DetailsTableView8.h"
#import "CollectionCell1.h"
#define CollectionView @"CollectionViewCell"
@interface DetailsTableView8 ()<UITableViewDataSource,UITableViewDelegate,CustomCollectionDelegate>
@end
@implementation DetailsTableView8
-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        self.dataSource = self;
        self.delegate = self;
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
    return 1;
}
#pragma mark -- tableView
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionCell1 *cell = [tableView dequeueReusableCellWithIdentifier:CollectionView forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSString *str = [NSString stringWithFormat:@"%ld",indexPath.section];
    cell.selectStr = str;
    cell.delegate = self;
    switch (indexPath.section) {
        case 0:
        {
            cell.collectDataArray = self.model.housePicPics;
        }
            break;
        case 1:
        {
            cell.collectDataArray = self.model.houseUnitPicPics;
        }
            break;
        case 2:
        {
            cell.collectDataArray = self.model.houseDoorPicPics;
        }
            break;
        case 3:
        {
            cell.collectDataArray = self.model.houseRoomPicPics;
        }
            break;
        case 4:
        {
            cell.collectDataArray = self.model.houseCustomerPicPics;
        }
            break;
        case 5:
        {
            cell.collectDataArray = self.model.houseSaleCustomerPicPics;
        }
            break;
        default:
            break;
    }
    return cell;
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
    switch (indexPath.section) {
        case 0:
        {
            float numberToRound;
            int result;
            numberToRound = (self.model.housePicPics.count + 0.0)/3.0;
            result = (int)ceilf(numberToRound);
            if (result > 0) {
                return result * ((SCREEN_WIDTH - 50)/3 + 10) + 20;
            }else
            {
                return 0.01;
            }
        }
            break;
        case 1:
        {
            float numberToRound;
            int result;
            numberToRound = (self.model.houseUnitPicPics.count + 0.0)/3.0;
            result = (int)ceilf(numberToRound);
            if (result > 0) {
                return result * ((SCREEN_WIDTH - 50)/3 + 10) + 20;
            }else
            {
                return 0.01;
            }
        }
            break;
        case 2:
        {
            float numberToRound;
            int result;
            numberToRound = (self.model.houseDoorPicPics.count + 0.0)/3.0;
            result = (int)ceilf(numberToRound);
            if (result > 0) {
                return result * ((SCREEN_WIDTH - 50)/3 + 10) + 20;
            }else
            {
                return 0.01;
            }
        }
            break;
        case 3:
        {
            float numberToRound;
            int result;
            numberToRound = (self.model.houseRoomPicPics.count + 0.0)/3.0;
            result = (int)ceilf(numberToRound);
            if (result > 0) {
                return result * ((SCREEN_WIDTH - 50)/3 + 10) + 20;
            }else
            {
                return 0.01;
            }
        }
            break;
        case 4:
        {
            float numberToRound;
            int result;
            numberToRound = (self.model.houseCustomerPicPics.count + 0.0)/3.0;
            result = (int)ceilf(numberToRound);
            if (result > 0) {
                return result * ((SCREEN_WIDTH - 50)/3 + 10) + 20;
            }else
            {
                return 0.01;
            }
        }
            break;
        case 5:
        {
            float numberToRound;
            int result;
            numberToRound = (self.model.houseSaleCustomerPicPics.count + 0.0)/3.0;
            result = (int)ceilf(numberToRound);
            if (result > 0) {
                return result * ((SCREEN_WIDTH - 50)/3 + 10) + 20;
            }else
            {
                return 0.01;
            }
        }
            break;
        default:
            break;
    }
    return ((SCREEN_WIDTH - 50)/3 + 10) + 20;
}
#pragma mark -- 区头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}
#pragma mark -- 区尾高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headView = [[UIView alloc]init];
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    backView.backgroundColor = [UIColor whiteColor];
    [headView addSubview:backView];
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    lineView.backgroundColor = LineBackColor;
    [headView addSubview:lineView];
    NSArray *array = @[@"小区外观",@"单元楼照片",@"门派照片",@"客厅照片",@"主贷和住宅合影",@"签约员与客户合影"];
    UILabel *nameLabel = [UILabel labelWithFrame:CGRectMake(15, 0, SCREEN_WIDTH, 50) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(14) textColor:[UIColor blackColor]];
    nameLabel.text = array[section];
    [headView addSubview:nameLabel];
    return headView;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}
@end
