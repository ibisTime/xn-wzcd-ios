//
//  UploadSingleImageCell.m
//  WenZhouCarLansB
//
//  Created by QinBao Zheng on 2018/9/3.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "UploadSingleImageCell.h"

@implementation UploadSingleImageCell
{
    NSString *imageStr;
    UIImageView *photoImage;
    
}

-(UILabel *)nameLbl
{
    if (!_nameLbl) {
        _nameLbl = [UILabel labelWithFrame:CGRectMake(15, 0, SCREEN_WIDTH - 30, 50) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(14) textColor:[UIColor blackColor]];
//        _nameLbl.text = @"身份证";
    }
    return _nameLbl;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.nameLbl];


        UIButton *button = [UIButton buttonWithTitle:@"" titleColor:GaryTextColor backgroundColor:BackColor titleFont:13];
        button.frame = CGRectMake(15 , 50, (SCREEN_WIDTH - 40)/2, SCREEN_WIDTH/3);
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:(UIControlEventTouchUpInside)];
        _photoBtn = button;
        [self addSubview:button];

        photoImage = [[UIImageView alloc]initWithFrame:CGRectMake(0 , 0, (SCREEN_WIDTH - 40)/2, SCREEN_WIDTH/3)];
        kViewBorderRadius(photoImage, 5, 1, HGColor(230, 230, 230));
        [button addSubview:photoImage];



        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 49 + SCREEN_WIDTH/3 + 20, SCREEN_WIDTH, 1)];
        lineView.backgroundColor = LineBackColor;
        [self addSubview:lineView];
    }
    return self;
}

-(void)setUploadStr:(NSString *)uploadStr
{
    _nameLbl.text = uploadStr;
    [_photoBtn setTitle:uploadStr forState:(UIControlStateNormal)];
    [_photoBtn SG_imagePositionStyle:(SGImagePositionStyleTop) spacing:10 imagePositionBlock:^(UIButton *button) {
        [button setImage:[UIImage imageNamed:@"添加"] forState:(UIControlStateNormal)];
    }];

}

- (void)buttonClick:(UIButton *)sender
{
    if ([BaseModel isBlankString:imageStr] == YES)
    {

    }else
    {
        NSArray *array = @[[imageStr convertImageUrl]];
        UIWindow *window = [[UIApplication sharedApplication] keyWindow];
        [ImageBrowserViewController show:window.rootViewController type:PhotoBroswerVCTypeModal index:0 imagesBlock:^NSArray *{
            return array;
        }];
    }
}

-(void)setUploadPhoto:(NSString *)uploadPhoto
{
    [photoImage sd_setImageWithURL:[NSURL URLWithString:[uploadPhoto convertImageUrl]]];
}

-(void)setImgStr:(NSString *)imgStr
{
    imageStr = imgStr;
    [photoImage sd_setImageWithURL:[NSURL URLWithString:[imgStr convertImageUrl]]];

}

@end
