//
//  SurveyIdCardTableViewCell.m
//  CarLoans
//
//  Created by QinBao Zheng on 2018/7/31.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "SurveyIdCardTableViewCell.h"

@implementation SurveyIdCardTableViewCell
{
    SurvuyPeopleModel *photoModel;
    UIImageView *imageView1;
    UIImageView *imageView2;

}

-(UILabel *)nameLbl
{
    if (!_nameLbl) {
        _nameLbl = [UILabel labelWithFrame:CGRectMake(15, 0, SCREEN_WIDTH - 30, 50) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(14) textColor:[UIColor blackColor]];
        _nameLbl.text = @"身份证";
    }
    return _nameLbl;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.nameLbl];
        for (int i = 0; i < 2; i ++) {

            UIImageView *photoImage = [[UIImageView alloc]initWithFrame:CGRectMake(15 + i % 2 * (SCREEN_WIDTH - 20)/2, 50, (SCREEN_WIDTH - 40)/2, SCREEN_WIDTH/3)];
            if (i == 0)
            {
                imageView1 = photoImage;

            }
            else
            {
                imageView2 = photoImage;
            }
            kViewBorderRadius(photoImage, 5, 1, HGColor(230, 230, 230));
            [self addSubview:photoImage];

            UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
            button.frame = photoImage.frame;
            [button addTarget:self action:@selector(buttonClick:) forControlEvents:(UIControlEventTouchUpInside)];
            button.tag = 10 + i;
            [self addSubview:button];

//            UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickMenuBtn:)];
//            [photoImage addGestureRecognizer:tapGR];
//            UIView *singleTapView = [tapGR view];
//            singleTapView.tag = i + 500;
        }

        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 49 + SCREEN_WIDTH/3 + 20, SCREEN_WIDTH, 1)];
        lineView.backgroundColor = LineBackColor;
        [self addSubview:lineView];
    }
    return self;
}

- (void)buttonClick:(UIButton *)sender
{
    NSArray *array = @[[photoModel.idNoFront convertImageUrl],[photoModel.idNoReverse convertImageUrl]];

    UIWindow *window = [[UIApplication sharedApplication] keyWindow];

    [ImageBrowserViewController show:window.rootViewController type:PhotoBroswerVCTypeModal index:sender.tag - 10 imagesBlock:^NSArray *{
        return array;
    }];

}

-(void)setModel:(SurvuyPeopleModel *)model
{
    photoModel = model;
    [imageView1 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[model.idNoFront convertImageUrl]]]];
    [imageView2 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[model.idNoReverse convertImageUrl]]]];
}

@end
