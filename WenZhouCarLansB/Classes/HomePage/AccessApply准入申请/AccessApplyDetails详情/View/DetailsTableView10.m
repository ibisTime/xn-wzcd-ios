//
//  DetailsTableView10.m
//  WenZhouCarLansB
//
//  Created by QinBao Zheng on 2018/9/11.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "DetailsTableView10.h"

#import "CollectionCell1.h"
#define CollectionView @"CollectionViewCell"
#import "TextFieldCell.h"
#define TextField @"TextFieldCell"
@interface DetailsTableView10 ()<UITableViewDataSource,UITableViewDelegate,CustomCollectionDelegate>


@end
@implementation DetailsTableView10

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {

    if (self = [super initWithFrame:frame style:style]) {
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[CollectionCell1 class] forCellReuseIdentifier:CollectionView];
        [self registerClass:[TextFieldCell class] forCellReuseIdentifier:TextField];

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
    return 1;
}

#pragma mark -- tableView
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        CollectionCell1 *cell = [tableView dequeueReusableCellWithIdentifier:CollectionView forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSString *str = [NSString stringWithFormat:@"%ld",indexPath.section];
        cell.selectStr = str;
        cell.collectDataArray = self.model.otherFilePdfPics;
        cell.delegate = self;
        return cell;
    }
    TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:TextField forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.name = @"备注事项";
    cell.isInput = @"";
    cell.nameTextField.tag = 101010;

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

    if (indexPath.section == 0) {
        float numberToRound;
        int result;
        numberToRound = (self.model.otherFilePdfPics.count + 0.0)/3.0;
        result = (int)ceilf(numberToRound);
        if (result > 0) {
            return result * ((SCREEN_WIDTH - 50)/3 + 10) + 20;
        }else
        {
            return 0.01;
        }
    }
    return 50;
}

#pragma mark -- 区头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 50;
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
    if (section == 0) {
        UIView *headView = [[UIView alloc]init];

        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
        backView.backgroundColor = [UIColor whiteColor];
        [headView addSubview:backView];

        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
        lineView.backgroundColor = LineBackColor;
        [headView addSubview:lineView];

        NSArray *array = @[@"附件"];
        UILabel *nameLabel = [UILabel labelWithFrame:CGRectMake(15, 0, SCREEN_WIDTH, 50) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(14) textColor:[UIColor blackColor]];
        nameLabel.text = array[section];
        [headView addSubview:nameLabel];

        return headView;
    }
    return nil;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{

    return nil;
}



@end
