//
//  UsedCarEvaluationReportCell.m
//  WenZhouCarLansB
//
//  Created by QinBao Zheng on 2018/9/11.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "UsedCarEvaluationReportCell.h"

@implementation UsedCarEvaluationReportCell
{
    UIImageView *zmImage;
    UIImageView *fmImage;

}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSArray *nameArray = @[@"驾驶证正面",@"驾驶证反面"];
        for (int i = 0; i < 2; i ++) {
            UIButton *_photoBtn = [UIButton buttonWithTitle:nameArray[i] titleColor:GaryTextColor backgroundColor:BackColor titleFont:13];
            _photoBtn.frame = CGRectMake(15 + i % 2 * ((SCREEN_WIDTH - 40)/2 + 10) , 0, (SCREEN_WIDTH - 40)/2, SCREEN_WIDTH/3);
            [_photoBtn SG_imagePositionStyle:(SGImagePositionStyleTop) spacing:10 imagePositionBlock:^(UIButton *button) {
                [button setImage:[UIImage imageNamed:@"添加"] forState:(UIControlStateNormal)];
            }];


            kViewBorderRadius(_photoBtn, 5, 1, HGColor(230, 230, 230));
            [self addSubview:_photoBtn];

            UIImageView *photoImage = [[UIImageView alloc]initWithFrame:CGRectMake(0 , 0, (SCREEN_WIDTH - 40)/2, SCREEN_WIDTH/3)];
            if (i == 0) {
                zmImage = photoImage;

                _ZMBtn = _photoBtn;
            }else
            {

                fmImage = photoImage;
                _FMBtn = _photoBtn;
            }
            [_photoBtn addSubview:photoImage];
        }
    }
    return self;
}

-(void)setZMStr:(NSString *)ZMStr
{
    [zmImage sd_setImageWithURL:[NSURL URLWithString:[ZMStr convertImageUrl]]];
}

-(void)setFMStr:(NSString *)FMStr
{
    [fmImage sd_setImageWithURL:[NSURL URLWithString:[FMStr convertImageUrl]]];
}

@end
