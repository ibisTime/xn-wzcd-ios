//
//  MortgageCalculatorPriceCell.m
//  WenZhouCarLansB
//
//  Created by QinBao Zheng on 2018/9/4.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "MortgageCalculatorPriceCell.h"

@implementation MortgageCalculatorPriceCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = kBackgroundColor;
        NSArray *array = @[@"首期    0.0¥",@"月供    0.0¥"];
        for (int i = 0; i < 2; i ++) {
            UILabel *nameLabel = [UILabel labelWithFrame:CGRectMake(15, 20 + i %2*50, SCREEN_WIDTH - 30, 50) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(24) textColor:[UIColor blackColor]];
            nameLabel.text = array[i];
            nameLabel.tag = 100 + i;
            [self addSubview:nameLabel];
        }
    }
    return self;
}

@end
