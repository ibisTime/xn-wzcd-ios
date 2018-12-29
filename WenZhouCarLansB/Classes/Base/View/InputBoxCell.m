//
//  InputBoxCell.m
//  CarLoans
//
//  Created by QinBao Zheng on 2018/7/17.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "InputBoxCell.h"

@implementation InputBoxCell

-(UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [UILabel labelWithFrame:CGRectMake(15, 0, 90, 50) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(14) textColor:[UIColor blackColor]];
    }
    return _nameLabel;
}

-(UITextField *)nameTextField
{
    if (!_nameTextField) {
        _nameTextField = [[UITextField alloc]initWithFrame:CGRectMake(105, 0, SCREEN_WIDTH - 140, 50)];
        _nameTextField.font = HGfont(14);
        _nameTextField.textAlignment = NSTextAlignmentRight;
        [_nameTextField setValue:HGfont(14) forKeyPath:@"_placeholderLabel.font"];
        _nameTextField.keyboardType = UIKeyboardTypeNumberPad;
    }
    return _nameTextField;
}

-(UILabel *)symbolLabel{
    if (!_symbolLabel) {
        _symbolLabel = [UILabel labelWithFrame:CGRectMake(SCREEN_WIDTH - 25, 0, 10, 50) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(14) textColor:[UIColor blackColor]];
        _symbolLabel.text = @"¥";
    }
    return _symbolLabel;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.nameLabel];
        [self addSubview:self.nameTextField];
        [self addSubview:self.symbolLabel];

        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 49, SCREEN_WIDTH, 1)];
        lineView.backgroundColor = LineBackColor;
        [self addSubview:lineView];
    }
    return self;
}

-(void)setName:(NSString *)name
{
    _nameLabel.text = name;
    _nameLabel.frame = CGRectMake(15, 18, 0, 14);
    [_nameLabel sizeToFit];
    _nameTextField.frame = CGRectMake(_nameLabel.frame.size.width + _nameLabel.frame.origin.x + 10, 0, SCREEN_WIDTH - _nameLabel.frame.size.width - _nameLabel.frame.origin.x - 10 - 35, 50);
//    _nameTextField.backgroundColor = [UIColor redColor];
}

-(void)setNameText:(NSString *)nameText
{
    
    _nameTextField.placeholder = nameText;
}

-(void)setDetailsStr:(NSString *)detailsStr
{
    _nameTextField.text = detailsStr;
}

-(void)setIsInput:(NSString *)isInput
{
    if ([isInput isEqualToString:@"0"]) {
        _nameTextField.enabled = NO;
    }
}

@end
