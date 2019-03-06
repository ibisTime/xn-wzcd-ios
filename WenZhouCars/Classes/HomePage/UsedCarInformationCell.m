#import "UsedCarInformationCell.h"
@implementation UsedCarInformationCell
-(UILabel *)nameLbl
{
    if (!_nameLbl) {
        _nameLbl = [UILabel labelWithFrame:CGRectMake(15, 0, SCREEN_WIDTH - 30, 50) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(14) textColor:[UIColor blackColor]];
    }
    return _nameLbl;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.nameLbl];
        [self addSubview:self.photoBtn];
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 49 + SCREEN_WIDTH/3, SCREEN_WIDTH, 1)];
        lineView.backgroundColor = LineBackColor;
        [self addSubview:lineView];
    }
    return self;
}
-(void)setName:(NSString *)name
{
    _nameLbl.text = name;
}
-(void)btnClick:(UIButton *)sender
{
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    [ImageBrowserViewController show:window.rootViewController type:PhotoBroswerVCTypeModal index:sender.tag - 10000 imagesBlock:^NSArray *{
        return self.photoArray;
    }];
}
-(void)setPicArray:(NSArray *)picArray
{
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < picArray.count; i ++) {
        [array addObject:[picArray[i] convertImageUrl]];
    }
    self.photoArray = array;
    for (int i = 0; i < picArray.count; i ++) {
        UIImageView *photoImage = [[UIImageView alloc]initWithFrame:CGRectMake(15 + i % 2 *  ((SCREEN_WIDTH - 40)/2 + 10), 50 , (SCREEN_WIDTH - 50)/2, SCREEN_WIDTH/3)];
        [photoImage sd_setImageWithURL:[NSURL URLWithString:[picArray[i] convertImageUrl]]];
        [self addSubview:photoImage];
        UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
        button.frame = photoImage.frame;
        [button addTarget:self action:@selector(btnClick:) forControlEvents:(UIControlEventTouchUpInside)];
        button.tag = 10000 + i;
        [self addSubview:button];
    }
}
@end
