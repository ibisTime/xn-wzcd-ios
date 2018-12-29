//
//  ApplyTableView7.m
//  WenZhouCarLansB
//
//  Created by QinBao Zheng on 2018/9/3.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "ApplyTableView7.h"

#import "CollectionViewCell.h"
#define CollectionView @"CollectionViewCell"

@interface ApplyTableView7 ()<UITableViewDataSource,UITableViewDelegate,CustomCollectionDelegate>


@end
@implementation ApplyTableView7

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {

    if (self = [super initWithFrame:frame style:style]) {
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[CollectionViewCell class] forCellReuseIdentifier:CollectionView];
        _array1 = [NSMutableArray array];
        _array2 = [NSMutableArray array];
        _array3 = [NSMutableArray array];
        _array4 = [NSMutableArray array];
        _array5 = [NSMutableArray array];
        _array6 = [NSMutableArray array];
        _array7 = [NSMutableArray array];
        _array8 = [NSMutableArray array];
        _array9 = [NSMutableArray array];
        _array10 = [NSMutableArray array];
        _array11 = [NSMutableArray array];
        _array12 = [NSMutableArray array];
        _array13 = [NSMutableArray array];
        _array14 = [NSMutableArray array];
        _array15 = [NSMutableArray array];

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

    NSString *CellIdentifier = [NSString stringWithFormat:@"cell1%ld%ld",indexPath.section,indexPath.row];
    CollectionViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[CollectionViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];

    }
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
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSString *str = [NSString stringWithFormat:@"%ld",indexPath.section];
    cell.selectStr = str;
    cell.delegate = self;

    return cell;
}

//添加
-(void)CustomCollection:(UICollectionView *)collectionView didSelectRowAtIndexPath:(NSIndexPath *)indexPath str:(NSString *)str
{
    if ([self.refreshDelegate respondsToSelector:@selector(refreshTableViewButtonClick:button:selectRowAtIndex:selectRowState:)]) {
        [self.refreshDelegate refreshTableViewButtonClick:self button:nil selectRowAtIndex:[str integerValue] selectRowState:@"add"];

    }
}

//删除
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
            numberToRound = (self.model.marryDivorcePics.count + 1.0)/3.0;
            result = (int)ceilf(numberToRound);
            return result * ((SCREEN_WIDTH - 50)/3 + 10) + 20;
        }
            break;
        case 1:
        {
            float numberToRound;
            int result;
            numberToRound = (self.model.applyUserHkbPics.count + 1.0)/3.0;
            result = (int)ceilf(numberToRound);
            return result * ((SCREEN_WIDTH - 50)/3 + 10) + 20;
        }
            break;
        case 2:
        {
            float numberToRound;
            int result;
            numberToRound = (self.model.bankBillPdfPics.count + 1.0)/3.0;
            result = (int)ceilf(numberToRound);
            return result * ((SCREEN_WIDTH - 50)/3 + 10) + 20;
        }
            break;
        case 3:
        {
            float numberToRound;
            int result;
            numberToRound = (self.model.singleProvePdfPics.count + 1.0)/3.0;
            result = (int)ceilf(numberToRound);
            return result * ((SCREEN_WIDTH - 50)/3 + 10) + 20;
        }
            break;
        case 4:
        {
            float numberToRound;
            int result;
            numberToRound = (self.model.incomeProvePdfPics.count + 1.0)/3.0;
            result = (int)ceilf(numberToRound);
            return result * ((SCREEN_WIDTH - 50)/3 + 10) + 20;
        }
            break;
        case 5:
        {
            float numberToRound;
            int result;
            numberToRound = (self.model.liveProvePdfPics.count + 1.0)/3.0;
            result = (int)ceilf(numberToRound);
            return result * ((SCREEN_WIDTH - 50)/3 + 10) + 20;
        }
            break;
        case 6:
        {
            float numberToRound;
            int result;
            numberToRound = (self.model.houseInvoicePics.count + 1.0)/3.0;
            result = (int)ceilf(numberToRound);
            return result * ((SCREEN_WIDTH - 50)/3 + 10) + 20;
        }
            break;
        case 7:
        {
            float numberToRound;
            int result;
            numberToRound = (self.model.buildProvePdfPics.count + 1.0)/3.0;
            result = (int)ceilf(numberToRound);
            return result * ((SCREEN_WIDTH - 50)/3 + 10) + 20;
        }
            break;
        case 8:
        {
            float numberToRound;
            int result;
            numberToRound = (self.model.hkbFirstPagePics.count + 1.0)/3.0;
            result = (int)ceilf(numberToRound);
            return result * ((SCREEN_WIDTH - 50)/3 + 10) + 20;
        }
            break;
        case 9:
        {
            float numberToRound;
            int result;
            numberToRound = (self.model.hkbMainPagePics.count + 1.0)/3.0;
            result = (int)ceilf(numberToRound);
            return result * ((SCREEN_WIDTH - 50)/3 + 10) + 20;
        }
            break;
        case 10:
        {
            float numberToRound;
            int result;
            numberToRound = (self.model.guarantor1IdNoPics.count + 1.0)/3.0;
            result = (int)ceilf(numberToRound);
            return result * ((SCREEN_WIDTH - 50)/3 + 10) + 20;
        }
            break;
        case 11:
        {
            float numberToRound;
            int result;
            numberToRound = (self.model.guarantor1HkbPics.count + 1.0)/3.0;
            result = (int)ceilf(numberToRound);
            return result * ((SCREEN_WIDTH - 50)/3 + 10) + 20;
        }
            break;
        case 12:
        {
            float numberToRound;
            int result;
            numberToRound = (self.model.guarantor2IdNoPics.count + 1.0)/3.0;
            result = (int)ceilf(numberToRound);
            return result * ((SCREEN_WIDTH - 50)/3 + 10) + 20;
        }
            break;
        case 13:
        {
            float numberToRound;
            int result;
            numberToRound = (self.model.guarantor2HkbPics.count + 1.0)/3.0;
            result = (int)ceilf(numberToRound);
            return result * ((SCREEN_WIDTH - 50)/3 + 10) + 20;
        }
            break;
        case 14:
        {
            float numberToRound;
            int result;
            numberToRound = (self.model.ghIdNoPics.count + 1.0)/3.0;
            result = (int)ceilf(numberToRound);
            return result * ((SCREEN_WIDTH - 50)/3 + 10) + 20;
        }
            break;
        case 15:
        {
            float numberToRound;
            int result;
            numberToRound = (self.model.ghHkbPics.count + 1.0)/3.0;
            result = (int)ceilf(numberToRound);
            return result * ((SCREEN_WIDTH - 50)/3 + 10) + 20;
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
