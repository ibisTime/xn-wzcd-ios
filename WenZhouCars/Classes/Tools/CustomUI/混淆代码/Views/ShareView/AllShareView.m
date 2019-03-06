#import "AllShareView.h"
#import "SDAutoLayout.h"
#import "LEEAlert.h"
#define VIEWSAFEAREAINSETS(view) ({UIEdgeInsets i; if(@available(iOS 11.0, *)) {i = view.safeAreaInsets;} else {i = UIEdgeInsetsZero;} i;})
@interface AllShareView ()
@property (nonatomic , strong ) UIView *backGroundView; 
@property (nonatomic , strong ) UIScrollView *shareScrollView; 
@property (nonatomic , strong ) UIScrollView *moreScrollView; 
@property (nonatomic , strong ) UIView *lineView; 
@property (nonatomic , strong ) NSArray *shareInfoArray; 
@property (nonatomic , strong ) NSArray *moreInfoArray; 
@property (nonatomic , strong ) NSMutableArray *shareButtonArray; 
@property (nonatomic , strong ) NSMutableArray *moreButtonArray; 
@end
@implementation AllShareView
{
    BOOL isShowMore; 
    BOOL isShowReport; 
}
- (void)dealloc{
    _backGroundView = nil;
    _shareScrollView = nil;
    _shareInfoArray = nil;
    _shareButtonArray = nil;
    _lineView = nil;
    _moreScrollView = nil;
    _moreInfoArray = nil;
    _moreButtonArray = nil;
}
#pragma mark - 初始化
- (instancetype)initWithFrame:(CGRect)frame ShowMore:(BOOL)showMore{
    return [self initWithFrame:frame ShowMore:showMore ShowReport:NO];
}
- (instancetype)initWithFrame:(CGRect)frame ShowMore:(BOOL)showMore ShowReport:(BOOL)showReport{
    self = [super initWithFrame:frame];
    if (self) {
        isShowMore = showMore;
        isShowReport = showReport;
        [self initData];
        [self initSubview];
        [self configAutoLayout];
    }
    return self;
}
#pragma mark - 初始化数据
- (void)initData{
    _shareButtonArray = [NSMutableArray array];
    _moreButtonArray = [NSMutableArray array];
    NSMutableArray *tempShareInfoArray = [NSMutableArray array];
        [tempShareInfoArray addObject:@{@"title" : @"朋友圈" , @"image" : @"infor_popshare_friends_nor" , @"highlightedImage" : @"infor_popshare_friends_pre" , @"type" : @(ShareTypeToWechatTimeline)}];
        [tempShareInfoArray addObject:@{@"title" : @"微信" , @"image" : @"infor_popshare_weixin_nor" , @"highlightedImage" : @"infor_popshare_weixin_pre" , @"type" : @(ShareTypeToWechat)}];
        [tempShareInfoArray addObject:@{@"title" : @"QQ好友" , @"image" : @"infor_popshare_qq_nor" , @"highlightedImage" : @"infor_popshare_qq_pre" , @"type" : @(ShareTypeToQQFriend)}];
        [tempShareInfoArray addObject:@{@"title" : @"新浪微博" , @"image" : @"infor_popshare_sina_nor" , @"highlightedImage" : @"infor_popshare_sina_pre" , @"type" : @(ShareTypeToSina)}];
        [tempShareInfoArray addObject:@{@"title" : @"QQ空间" , @"image" : @"infor_popshare_kunjian_nor" , @"highlightedImage" : @"infor_popshare_kunjian_pre" , @"type" : @(ShareTypeToQZone)}];
    [tempShareInfoArray addObject:@{@"title" : @"新浪微博" , @"image" : @"infor_popshare_sina_nor" , @"highlightedImage" : @"infor_popshare_sina_pre" , @"type" : @(ShareTypeToSina)}];
    _shareInfoArray = tempShareInfoArray;
    NSMutableArray *tempMoreInfoArray = [NSMutableArray array];
    [tempMoreInfoArray addObject: (1) == 1 ?
    @{@"title" :  @"夜间模式" , @"image" : @"infor_popshare_light_nor" , @"highlightedImage" : @"infor_popshare_light_pre" , @"type" : @(MoreTypeToTheme)} :
    @{@"title" :  @"日间模式" , @"image" : @"infor_popshare_day_nor" , @"highlightedImage" : @"infor_popshare_day_pre" , @"type" : @(MoreTypeToTheme)}];
    if (isShowReport) {
        [tempMoreInfoArray addObject:@{@"title" : @"举报" , @"image" : @"infor_popshare_report_nor" , @"highlightedImage" : @"infor_popshare_report_pre" , @"type" : @(MoreTypeToReport)}];
    }
    [tempMoreInfoArray addObject:@{@"title" : @"字体设置" , @"image" : @"infor_popshare_wordsize_nor" , @"highlightedImage" : @"infor_popshare_wordsize_pre" , @"type" : @(MoreTypeToFontSize)}];
    [tempMoreInfoArray addObject:@{@"title" : @"复制链接" , @"image" : @"infor_popshare_copylink_nor" , @"highlightedImage" : @"infor_popshare_copylink_pre" , @"type" : @(MoreTypeToCopyLink)}];
    _moreInfoArray = tempMoreInfoArray;
}
#pragma mark - 初始化子视图
- (void)initSubview{
    _backGroundView = [[UIView alloc] init];
    _backGroundView.backgroundColor = [UIColor colorWithRed:243/255.0 green:243/255.0 blue:243/255.0 alpha:1.0f];
    [self addSubview:_backGroundView];
    _shareScrollView = [[UIScrollView alloc] init];
    _shareScrollView.backgroundColor = [UIColor clearColor];
    _shareScrollView.bounces = YES;
    _shareScrollView.showsVerticalScrollIndicator = NO;
    _shareScrollView.showsHorizontalScrollIndicator = NO;
    [_backGroundView addSubview:_shareScrollView];
    for (NSDictionary *info in _shareInfoArray) {
        ShareButton *button = [ShareButton buttonWithType:UIButtonTypeCustom];
        [button configTitle:info[@"title"] Image:[UIImage imageNamed:info[@"image"]]];
        [button setImage:[UIImage imageNamed:info[@"highlightedImage"]] forState:UIControlStateHighlighted];
        [button.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(shareButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_shareScrollView addSubview:button];
        [_shareButtonArray addObject:button];
    }
    if (isShowMore) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.2f];
        [_backGroundView addSubview:_lineView];
        _moreScrollView = [[UIScrollView alloc] init];
        _moreScrollView.backgroundColor = [UIColor clearColor];
        _moreScrollView.bounces = YES;
        _moreScrollView.showsVerticalScrollIndicator = NO;
        _moreScrollView.showsHorizontalScrollIndicator = NO;
        [_backGroundView addSubview:_moreScrollView];
        for (NSDictionary *info in _moreInfoArray) {
            ShareButton *button = [ShareButton buttonWithType:UIButtonTypeCustom];
            [button configTitle:info[@"title"] Image:[UIImage imageNamed:info[@"image"]]];
            [button setImage:[UIImage imageNamed:info[@"highlightedImage"]] forState:UIControlStateHighlighted];
            [button.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(moreButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            [_moreScrollView addSubview:button];
            [_moreButtonArray addObject:button];
        }
    }
}
#pragma mark - 设置自动布局
- (void)configAutoLayout{
    CGFloat height = 140;
    CGFloat buttonMargin = 20;
    _backGroundView.sd_layout
    .topEqualToView(self)
    .leftEqualToView(self)
    .rightEqualToView(self);
    _shareScrollView.sd_layout
    .topSpaceToView(_backGroundView , 20)
    .leftEqualToView(_backGroundView)
    .rightEqualToView(_backGroundView)
    .heightIs(100);
    for (UIButton *button in _shareButtonArray) {
        if (_shareButtonArray.firstObject == button) {
            button.sd_layout
            .topEqualToView(_shareScrollView)
            .leftSpaceToView(_shareScrollView , 20)
            .widthIs(60.0f)
            .bottomEqualToView(_shareScrollView);
        } else {
            button.sd_layout
            .topEqualToView(_shareScrollView)
            .leftSpaceToView(_shareButtonArray[[_shareButtonArray indexOfObject:button] - 1] , buttonMargin)
            .widthIs(60.0f)
            .bottomEqualToView(_shareScrollView);
        }
    }
    [_shareScrollView setupAutoContentSizeWithRightView:_shareButtonArray.lastObject rightMargin:20];
    if (isShowMore) {
        _lineView.sd_layout
        .topSpaceToView(_shareScrollView , 10)
        .leftSpaceToView(_backGroundView , 30)
        .rightSpaceToView(_backGroundView , 30)
        .heightIs(0.5f);
        _moreScrollView.sd_layout
        .topSpaceToView(_lineView , 10)
        .leftEqualToView(_backGroundView)
        .rightEqualToView(_backGroundView)
        .heightIs(100);
        for (UIButton *button in _moreButtonArray) {
            if (_moreButtonArray.firstObject == button) {
                button.sd_layout
                .topEqualToView(_moreScrollView)
                .leftSpaceToView(_moreScrollView , 20)
                .widthIs(60.0f)
                .bottomEqualToView(_moreScrollView);
            } else {
                button.sd_layout
                .topEqualToView(_moreScrollView)
                .leftSpaceToView(_moreButtonArray[[_moreButtonArray indexOfObject:button] - 1] , buttonMargin)
                .widthIs(60.0f)
                .bottomEqualToView(_moreScrollView);
            }
        }
        [_moreScrollView setupAutoContentSizeWithRightView:_moreButtonArray.lastObject rightMargin:20];
        [_backGroundView setupAutoHeightWithBottomView:_moreScrollView bottomMargin:20.0f];
        height = 260;
    } else {
        [_backGroundView setupAutoHeightWithBottomView:_shareScrollView bottomMargin:20.0f];
    }
    self.height = height;
}
- (void)safeAreaInsetsDidChange{
    [super safeAreaInsetsDidChange];
    self.shareScrollView.sd_layout
    .topSpaceToView(self.backGroundView , 20)
    .leftSpaceToView(self.backGroundView , VIEWSAFEAREAINSETS(self).left)
    .rightSpaceToView(self.backGroundView , VIEWSAFEAREAINSETS(self).left)
    .heightIs(100);
    if (isShowMore) {
        self.moreScrollView.sd_layout
        .topSpaceToView(self.lineView , 10)
        .leftSpaceToView(self.backGroundView , VIEWSAFEAREAINSETS(self).left)
        .rightSpaceToView(self.backGroundView , VIEWSAFEAREAINSETS(self).left)
        .heightIs(100);
    }
}
#pragma mark - 分享按钮点击事件
- (void)shareButtonAction:(UIButton *)sender{
    __weak typeof(self) weakSelf = self;
    [LEEAlert closeWithCompletionBlock:^{
        if (!weakSelf) return;
        NSInteger index = [weakSelf.shareButtonArray indexOfObject:sender];
        ShareType type = (ShareType)[weakSelf.shareInfoArray[index][@"type"] integerValue];
        if (weakSelf.openShareBlock) weakSelf.openShareBlock(type);
    }];
}
#pragma mark - 更多按钮点击事件
- (void)moreButtonAction:(UIButton *)sender{
    __weak typeof(self) weakSelf = self;
    [LEEAlert closeWithCompletionBlock:^{
        if (!weakSelf) return;
        NSInteger index = [weakSelf.moreButtonArray indexOfObject:sender];
        MoreType type = (MoreType)[weakSelf.moreInfoArray[index][@"type"] integerValue];
        if (weakSelf.openMoreBlock) {
            weakSelf.openMoreBlock(type);
        }
    }];
}
#pragma mark - 显示
- (void)show{
//    [LEEAlert actionsheet].config
//    .LeeAddCustomView(^(LEECustomView *custom) {
//        custom.view = self;
//        custom.isAutoWidth = YES;
//    })
//    .LeeItemInsets(UIEdgeInsetsMake(0, 0, 0, 0))
//    .LeeAddAction(^(LEEAction *action) {
//        action.title = @"取消";
//        action.titleColor = [UIColor grayColor];
//        action.height = 45.0f;
//    })
//    .LeeHeaderInsets(UIEdgeInsetsMake(0, 0, 0, 0))
//    .LeeActionSheetBottomMargin(0.0f)
//    .LeeCornerRadius(0.0f)
//    .LeeConfigMaxWidth(^CGFloat(LEEScreenOrientationType type) {
//        return CGRectGetWidth([[UIScreen mainScreen] bounds]);
//    })
//    .LeeShow();
}
@end
