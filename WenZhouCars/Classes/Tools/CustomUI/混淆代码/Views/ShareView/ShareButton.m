#import "ShareButton.h"
@implementation ShareButton
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _range = 10.0f;
    }
    return self;
}
- (void)setRange:(CGFloat)range{
    _range = range;
    [self layoutSubviews];
}
- (void)layoutSubviews{
    [super layoutSubviews];
    CGPoint center = self.imageView.center;
    center.x = self.frame.size.width/2;
    center.y = self.imageView.frame.size.height/2;
    self.imageView.center = center;
    CGRect imageFrame = [self imageView].frame;
    imageFrame.origin.y = (self.frame.size.height - imageFrame.size.height - self.titleLabel.frame.size.height - _range ) / 2;
    self.imageView.frame = imageFrame;
    CGRect titleFrame = [self titleLabel].frame;
    titleFrame.origin.x = 0;
    titleFrame.origin.y = self.imageView.frame.origin.y + self.imageView.frame.size.height + _range;
    titleFrame.size.width = self.frame.size.width;
    self.titleLabel.frame = titleFrame;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}
- (void)configTitle:(NSString *)title Image:(UIImage *)image{
    [self setTitle:title forState:UIControlStateNormal];
    [self setImage:image forState:UIControlStateNormal];
}
@end
