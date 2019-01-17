#import "DetailsTableView7.h"
#import "CollectionCell1.h"
#define CollectionView @"CollectionViewCell"
@interface DetailsTableView7 ()<UITableViewDataSource,UITableViewDelegate,CustomCollectionDelegate>
@end
@implementation DetailsTableView7
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
    return 16;
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
            NSLog(@"%@",self.model.marryDivorcePics);
            cell.collectDataArray = self.model.marryDivorcePics;
        }
            break;
        case 1:
        {
            cell.collectDataArray = self.model.applyUserHkbPics;
        }
            break;
        case 2:
        {
            cell.collectDataArray = self.model.bankBillPdfPics;
        }
            break;
        case 3:
        {
            cell.collectDataArray = self.model.singleProvePdfPics;
        }
            break;
        case 4:
        {
            cell.collectDataArray = self.model.incomeProvePdfPics;
        }
            break;
        case 5:
        {
            cell.collectDataArray = self.model.liveProvePdfPics;
        }
            break;
        case 6:
        {
            cell.collectDataArray = self.model.houseInvoicePics;
        }
            break;
        case 7:
        {
            cell.collectDataArray = self.model.buildProvePdfPics;
        }
            break;
        case 8:
        {
            cell.collectDataArray = self.model.hkbFirstPagePics;
        }
            break;
        case 9:
        {
            cell.collectDataArray = self.model.hkbMainPagePics;
        }
            break;
        case 10:
        {
            cell.collectDataArray = self.model.guarantor1IdNoPics;
        }
            break;
        case 11:
        {
            cell.collectDataArray = self.model.guarantor1HkbPics;
        }
            break;
        case 12:
        {
            cell.collectDataArray = self.model.guarantor2IdNoPics;
        }
            break;
        case 13:
        {
            cell.collectDataArray = self.model.guarantor2HkbPics;
        }
            break;
        case 14:
        {
            cell.collectDataArray = self.model.ghIdNoPics;
        }
            break;
        case 15:
        {
            cell.collectDataArray = self.model.ghHkbPics;
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
            numberToRound = (self.model.marryDivorcePics.count + 0.0)/3.0;
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
            numberToRound = (self.model.applyUserHkbPics.count + 0.0)/3.0;
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
            numberToRound = (self.model.bankBillPdfPics.count + 0.0)/3.0;
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
            numberToRound = (self.model.singleProvePdfPics.count + 0.0)/3.0;
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
            numberToRound = (self.model.incomeProvePdfPics.count + 0.0)/3.0;
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
            numberToRound = (self.model.liveProvePdfPics.count + 0.0)/3.0;
            result = (int)ceilf(numberToRound);
            if (result > 0) {
                return result * ((SCREEN_WIDTH - 50)/3 + 10) + 20;
            }else
            {
                return 0.01;
            }
        }
            break;
        case 6:
        {
            float numberToRound;
            int result;
            numberToRound = (self.model.houseInvoicePics.count + 0.0)/3.0;
            result = (int)ceilf(numberToRound);
            if (result > 0) {
                return result * ((SCREEN_WIDTH - 50)/3 + 10) + 20;
            }else
            {
                return 0.01;
            }
        }
            break;
        case 7:
        {
            float numberToRound;
            int result;
            numberToRound = (self.model.buildProvePdfPics.count + 0.0)/3.0;
            result = (int)ceilf(numberToRound);
            if (result > 0) {
                return result * ((SCREEN_WIDTH - 50)/3 + 10) + 20;
            }else
            {
                return 0.01;
            }
        }
            break;
        case 8:
        {
            float numberToRound;
            int result;
            numberToRound = (self.model.hkbFirstPagePics.count + 0.0)/3.0;
            result = (int)ceilf(numberToRound);
            if (result > 0) {
                return result * ((SCREEN_WIDTH - 50)/3 + 10) + 20;
            }else
            {
                return 0.01;
            }
        }
            break;
        case 9:
        {
            float numberToRound;
            int result;
            numberToRound = (self.model.hkbMainPagePics.count + 0.0)/3.0;
            result = (int)ceilf(numberToRound);
            if (result > 0) {
                return result * ((SCREEN_WIDTH - 50)/3 + 10) + 20;
            }else
            {
                return 0.01;
            }
        }
            break;
        case 10:
        {
            float numberToRound;
            int result;
            numberToRound = (self.model.guarantor1IdNoPics.count + 0.0)/3.0;
            result = (int)ceilf(numberToRound);
            if (result > 0) {
                return result * ((SCREEN_WIDTH - 50)/3 + 10) + 20;
            }else
            {
                return 0.01;
            }
        }
            break;
        case 11:
        {
            float numberToRound;
            int result;
            numberToRound = (self.model.guarantor1HkbPics.count + 0.0)/3.0;
            result = (int)ceilf(numberToRound);
            if (result > 0) {
                return result * ((SCREEN_WIDTH - 50)/3 + 10) + 20;
            }else
            {
                return 0.01;
            }
        }
            break;
        case 12:
        {
            float numberToRound;
            int result;
            numberToRound = (self.model.guarantor2IdNoPics.count + 0.0)/3.0;
            result = (int)ceilf(numberToRound);
            if (result > 0) {
                return result * ((SCREEN_WIDTH - 50)/3 + 10) + 20;
            }else
            {
                return 0.01;
            }
        }
            break;
        case 13:
        {
            float numberToRound;
            int result;
            numberToRound = (self.model.guarantor2HkbPics.count + 0.0)/3.0;
            result = (int)ceilf(numberToRound);
            if (result > 0) {
                return result * ((SCREEN_WIDTH - 50)/3 + 10) + 20;
            }else
            {
                return 0.01;
            }
        }
            break;
        case 14:
        {
            float numberToRound;
            int result;
            numberToRound = (self.model.ghIdNoPics.count + 0.0)/3.0;
            result = (int)ceilf(numberToRound);
            if (result > 0) {
                return result * ((SCREEN_WIDTH - 50)/3 + 10) + 20;
            }else
            {
                return 0.01;
            }
        }
            break;
        case 15:
        {
            float numberToRound;
            int result;
            numberToRound = (self.model.ghHkbPics.count + 0.0)/3.0;
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
    NSArray *array = @[@"结婚证(离婚证)",@"户口本(主贷本人页)",@"银行流水",@"单身证明",@"收入证明",@"居住证明",@"购房发票",@"自建房证明",@"户口本(首页)",@"户口本(户主页)",@"担保人1身份证",@"担保人1户口本",@"担保人2身份证",@"担保人2户口本",@"共还人身份证",@"共还人户口本"];
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
