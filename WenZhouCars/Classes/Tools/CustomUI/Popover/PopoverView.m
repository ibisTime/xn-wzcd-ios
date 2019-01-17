#import "PopoverView.h"
#import "PopoverViewCell.h"
static float const kPopoverViewMargin = 8.f; 
static float const kPopoverViewCellHeight = 40.f; 
static float const kPopoverViewArrowHeight = 13.f; 
float DegreesToRadians(float angle) {
    return angle*M_PI/180;
}
@interface PopoverView () <UITableViewDelegate, UITableViewDataSource>
#pragma mark - UI
@property (nonatomic, weak) UIWindow *keyWindow; 
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *shadeView; 
@property (nonatomic, weak) CAShapeLayer *borderLayer; 
#pragma mark - Data
@property (nonatomic, copy) NSArray<PopoverAction *> *actions;
@property (nonatomic, assign) CGFloat windowWidth; 
@property (nonatomic, assign) CGFloat windowHeight; 
@property (nonatomic, assign) BOOL isUpward; 
@end
@implementation PopoverView
#pragma mark - Lift Cycle
- (instancetype)initWithFrame:(CGRect)frame {
    if (!(self = [super initWithFrame:frame])) return nil;
    [self initialize];
    kViewRadius(self, 5);
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    [self initialize];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    _tableView.frame = CGRectMake(0, _isUpward ? kPopoverViewArrowHeight : 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) - kPopoverViewArrowHeight);
}
- (void)dealloc {
    NSLog(@"PopoverView dealloced");
}
#pragma mark - Setter
- (void)setHideAfterTouchOutside:(BOOL)hideAfterTouchOutside {
    _hideAfterTouchOutside = hideAfterTouchOutside;
    _shadeView.userInteractionEnabled = _hideAfterTouchOutside;
}
- (void)setShowShade:(BOOL)showShade {
    _showShade = showShade;
    _shadeView.backgroundColor = _showShade ? [UIColor colorWithWhite:0.f alpha:0.18f] : [UIColor clearColor];
    if (_borderLayer) {
        _borderLayer.strokeColor = _showShade ? [UIColor clearColor].CGColor : _tableView.separatorColor.CGColor;
    }
}
- (void)setStyle:(PopoverViewStyle)style {
    _style = style;
    _tableView.separatorColor = [PopoverViewCell bottomLineColorForStyle:_style];
    if (_style == PopoverViewStyleDefault) {
        self.backgroundColor = [UIColor whiteColor];
    } else {
        self.backgroundColor = [UIColor colorWithRed:0.29 green:0.29 blue:0.29 alpha:1.00];
    }
}
#pragma mark - Private
- (void)initialize {
    _actions = @[];
    _isUpward = YES;
    _style = PopoverViewStyleDefault;
    self.backgroundColor = [UIColor whiteColor];
    _keyWindow = [UIApplication sharedApplication].keyWindow;
    _windowWidth = CGRectGetWidth(_keyWindow.bounds);
    _windowHeight = CGRectGetHeight(_keyWindow.bounds);
    _shadeView = [[UIView alloc] initWithFrame:_keyWindow.bounds];
    [_shadeView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)]];
    [self setShowShade:NO];
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.scrollEnabled = NO;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.separatorColor = [PopoverViewCell bottomLineColorForStyle:_style];
    [self addSubview:_tableView];
}
- (void)showToPoint:(CGPoint)toPoint {
    NSAssert(_actions.count > 0, @"actions must not be nil or empty !");
    float arrowWidth = 28;
    float cornerRadius = 6.f;
    float arrowCornerRadius = 2.5f;
    float arrowBottomCornerRadius = 4.f;
    CGFloat minHorizontalEdge = kPopoverViewMargin + cornerRadius + arrowWidth/2 + 2;
    if (toPoint.x < minHorizontalEdge) {
        toPoint.x = minHorizontalEdge;
    }
    if (_windowWidth - toPoint.x < minHorizontalEdge) {
        toPoint.x = _windowWidth - minHorizontalEdge;
    }
    _shadeView.alpha = 0.f;
    [_keyWindow addSubview:_shadeView];
    [_tableView reloadData];
    CGFloat currentW = [self calculateMaxWidth]; 
    CGFloat currentH = _tableView.contentSize.height + kPopoverViewArrowHeight;
    CGFloat maxHeight = _isUpward ? (_windowHeight - toPoint.y - kPopoverViewMargin) : (toPoint.y - CGRectGetHeight([UIApplication sharedApplication].statusBarFrame));
    if (currentH > maxHeight) { 
        currentH = maxHeight;
        _tableView.scrollEnabled = YES;
        if (!_isUpward) { 
            [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_actions.count - 1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
        }
    }
    CGFloat currentX = toPoint.x - currentW/2, currentY = toPoint.y;
    if (toPoint.x <= currentW/2 + kPopoverViewMargin) {
        currentX = kPopoverViewMargin;
    }
    if (_windowWidth - toPoint.x <= currentW/2 + kPopoverViewMargin) {
        currentX = _windowWidth - kPopoverViewMargin - currentW;
    }
    if (!_isUpward) {
        currentY = toPoint.y - currentH;
    }
    self.frame = CGRectMake(currentX, currentY, currentW, currentH - 15);
    CGPoint arrowPoint = CGPointMake(toPoint.x - CGRectGetMinX(self.frame), _isUpward ? 0 : currentH); 
    CGFloat maskTop = _isUpward ? kPopoverViewArrowHeight : 0; 
    CGFloat maskBottom = _isUpward ? currentH : currentH - kPopoverViewArrowHeight; 
    UIBezierPath *maskPath = [UIBezierPath bezierPath];
    [maskPath moveToPoint:CGPointMake(0, cornerRadius + maskTop)];
    [maskPath addArcWithCenter:CGPointMake(cornerRadius, cornerRadius + maskTop)
                        radius:cornerRadius
                    startAngle:DegreesToRadians(180)
                      endAngle:DegreesToRadians(270)
                     clockwise:YES];
    if (_isUpward) {
        [maskPath addLineToPoint:CGPointMake(arrowPoint.x - arrowWidth/2, kPopoverViewArrowHeight)];
        [maskPath addQuadCurveToPoint:CGPointMake(arrowPoint.x - arrowCornerRadius, arrowCornerRadius)
                         controlPoint:CGPointMake(arrowPoint.x - arrowWidth/2 + arrowBottomCornerRadius, kPopoverViewArrowHeight)];
        [maskPath addQuadCurveToPoint:CGPointMake(arrowPoint.x + arrowCornerRadius, arrowCornerRadius)
                         controlPoint:arrowPoint];
        [maskPath addQuadCurveToPoint:CGPointMake(arrowPoint.x + arrowWidth/2, kPopoverViewArrowHeight)
                         controlPoint:CGPointMake(arrowPoint.x + arrowWidth/2 - arrowBottomCornerRadius, kPopoverViewArrowHeight)];
    }
    [maskPath addLineToPoint:CGPointMake(currentW - cornerRadius, maskTop)];
    [maskPath addArcWithCenter:CGPointMake(currentW - cornerRadius, maskTop + cornerRadius)
                        radius:cornerRadius
                    startAngle:DegreesToRadians(270)
                      endAngle:DegreesToRadians(0)
                     clockwise:YES];
    [maskPath addLineToPoint:CGPointMake(currentW, maskBottom - cornerRadius)];
    [maskPath addArcWithCenter:CGPointMake(currentW - cornerRadius, maskBottom - cornerRadius)
                        radius:cornerRadius
                    startAngle:DegreesToRadians(0)
                      endAngle:DegreesToRadians(90)
                     clockwise:YES];
    if (!_isUpward) {
        [maskPath addLineToPoint:CGPointMake(arrowPoint.x + arrowWidth/2, currentH - kPopoverViewArrowHeight)];
        [maskPath addQuadCurveToPoint:CGPointMake(arrowPoint.x + arrowCornerRadius, currentH - arrowCornerRadius)
                         controlPoint:CGPointMake(arrowPoint.x + arrowWidth/2 - arrowBottomCornerRadius, currentH - kPopoverViewArrowHeight)];
        [maskPath addQuadCurveToPoint:CGPointMake(arrowPoint.x - arrowCornerRadius, currentH - arrowCornerRadius)
                         controlPoint:arrowPoint];
        [maskPath addQuadCurveToPoint:CGPointMake(arrowPoint.x - arrowWidth/2, currentH - kPopoverViewArrowHeight)
                         controlPoint:CGPointMake(arrowPoint.x - arrowWidth/2 + arrowBottomCornerRadius, currentH - kPopoverViewArrowHeight)];
    }
    [maskPath addLineToPoint:CGPointMake(cornerRadius, maskBottom)];
    [maskPath addArcWithCenter:CGPointMake(cornerRadius, maskBottom - cornerRadius)
                        radius:cornerRadius
                    startAngle:DegreesToRadians(90)
                      endAngle:DegreesToRadians(180)
                     clockwise:YES];
    [maskPath closePath];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
    if (!_showShade) {
        CAShapeLayer *borderLayer = [CAShapeLayer layer];
        borderLayer.frame = self.bounds;
        borderLayer.path = maskPath.CGPath;
        borderLayer.lineWidth = 1;
        borderLayer.fillColor = [UIColor clearColor].CGColor;
        borderLayer.strokeColor = _tableView.separatorColor.CGColor;
        [self.layer addSublayer:borderLayer];
        _borderLayer = borderLayer;
    }
    [_keyWindow addSubview:self];
    CGRect oldFrame = self.frame;
    self.layer.anchorPoint = CGPointMake(arrowPoint.x/currentW, _isUpward ? 0.f : 1.f);
    self.frame = oldFrame;
    self.transform = CGAffineTransformMakeScale(0.01f, 0.01f);
    [UIView animateWithDuration:0.25f animations:^{
        self.transform = CGAffineTransformIdentity;
        _shadeView.alpha = 1.f;
    }];
}
- (CGFloat)calculateMaxWidth {
    CGFloat maxWidth = 0.f, titleLeftEdge = 0.f, imageWidth = 0.f, imageMaxHeight = kPopoverViewCellHeight - PopoverViewCellVerticalMargin*2;
    CGSize imageSize = CGSizeZero;
    UIFont *titleFont = [PopoverViewCell titleFont];
    for (PopoverAction *action in _actions) {
        imageWidth = 0.f;
        titleLeftEdge = 0.f;
        if (action.image) { 
            titleLeftEdge = PopoverViewCellTitleLeftEdge; 
            imageSize = action.image.size;
            if (imageSize.height > imageMaxHeight) {
                imageWidth = imageMaxHeight*imageSize.width/imageSize.height;
            } else {
                imageWidth = imageSize.width;
            }
        }
        CGFloat titleWidth;
        if ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0) { 
            titleWidth = [action.title sizeWithAttributes:@{NSFontAttributeName : titleFont}].width;
        } else { 
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
            titleWidth = [action.title sizeWithFont:titleFont].width;
#pragma GCC diagnostic pop
        }
        CGFloat contentWidth = PopoverViewCellHorizontalMargin*2 + imageWidth + titleLeftEdge + titleWidth;
        if (contentWidth > maxWidth) {
            maxWidth = ceil(contentWidth); 
        }
    }
    if (maxWidth > CGRectGetWidth(_keyWindow.bounds) - kPopoverViewMargin*2) {
        maxWidth = CGRectGetWidth(_keyWindow.bounds) - kPopoverViewMargin*2;
    }
    return maxWidth;
}
- (void)hide {
    [UIView animateWithDuration:0.25f animations:^{
        self.alpha = 0.f;
        _shadeView.alpha = 0.f;
        self.transform = CGAffineTransformMakeScale(0.01f, 0.01f);
    } completion:^(BOOL finished) {
        [_shadeView removeFromSuperview];
        [self removeFromSuperview];
    }];
}
#pragma mark - Public
+ (instancetype)popoverView {
    return [[self alloc] init];
}
- (void)showToView:(UIView *)pointView withActions:(NSArray<PopoverAction *> *)actions {
    CGRect pointViewRect = [pointView.superview convertRect:pointView.frame toView:_keyWindow];
    CGFloat pointViewUpLength = CGRectGetMinY(pointViewRect);
    CGFloat pointViewDownLength = _windowHeight - CGRectGetMaxY(pointViewRect);
    CGPoint toPoint = CGPointMake(CGRectGetMidX(pointViewRect), 0);
    if (pointViewUpLength > pointViewDownLength) {
        toPoint.y = pointViewUpLength - 5;
    }
    else {
        toPoint.y = CGRectGetMaxY(pointViewRect) + 5;
    }
    _isUpward = pointViewUpLength <= pointViewDownLength;
    _actions = [actions copy];
    [self showToPoint:toPoint];
}
- (void)showToPoint:(CGPoint)toPoint withActions:(NSArray<PopoverAction *> *)actions {
    _actions = [actions copy];
    _isUpward = toPoint.y <= _windowHeight - toPoint.y;
    [self showToPoint:toPoint];
}
#pragma mark - UITableViewDelegate & UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _actions.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kPopoverViewCellHeight;
}
static NSString *kPopoverCellIdentifier = @"kPopoverCellIdentifier";
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PopoverViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kPopoverCellIdentifier];
    if (!cell) {
        cell = [[PopoverViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kPopoverCellIdentifier];
    }
    [cell setAction:_actions[indexPath.row]];
    [cell showBottomLine: indexPath.row < _actions.count - 1];
    cell.style = _style;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [UIView animateWithDuration:0.25f animations:^{
        self.alpha = 0.f;
        _shadeView.alpha = 0.f;
    } completion:^(BOOL finished) {
        PopoverAction *action = _actions[indexPath.row];
        action.handler ? action.handler(action) : NULL;
        _actions = nil;
        [_shadeView removeFromSuperview];
        [self removeFromSuperview];
    }];
}
@end
