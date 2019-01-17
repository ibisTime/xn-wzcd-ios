#import "ShareView.h"
#import "ShareButton.h"
#import "SDAutoLayout.h"
#import "LEEAlert.h"
@interface ShareView () <UIScrollViewDelegate>
@property (nonatomic , strong ) UIScrollView *scrollView;
@property (nonatomic , strong ) UIPageControl *pageControl;
@property (nonatomic , strong ) NSArray *infoArray;
@property (nonatomic , strong ) NSMutableArray *buttonArray;
@property (nonatomic , strong ) NSMutableArray *pageViewArray;
@end
@implementation ShareView
{
    NSInteger lineMaxNumber; 
    NSInteger singleMaxCount; 
}
- (void)dealloc{
    _scrollView = nil;
    _pageControl = nil;
    _infoArray = nil;
    _buttonArray = nil;
    _pageViewArray = nil;
}
#pragma mark - 初始化
- (instancetype)initWithFrame:(CGRect)frame
                    InfoArray:(NSArray *)infoArray
                MaxLineNumber:(NSInteger)maxLineNumber
               MaxSingleCount:(NSInteger)maxSingleCount{
    self = [super initWithFrame:frame];
    if (self) {
        _infoArray = infoArray;
        _buttonArray = [NSMutableArray array];
        _pageViewArray = [NSMutableArray array];
        lineMaxNumber = maxLineNumber;
        singleMaxCount = maxSingleCount;
        [self initData];
        [self initSubview];
        [self configAutoLayout];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame{
    return [self initWithFrame:frame InfoArray:nil MaxLineNumber:0 MaxSingleCount:0];
}
#pragma mark - 初始化数据
- (void)initData{
    if (!_infoArray) {
        _infoArray = @[
                       @{@"title" : @"微信" , @"image" : @"infor_popshare_weixin_nor" , @"highlightedImage" : @"infor_popshare_weixin_pre" , @"type" : [NSNumber numberWithInteger:ShareTypeToWechat]} ,
                       @{@"title" : @"微信朋友圈" , @"image" : @"infor_popshare_friends_nor" , @"highlightedImage" : @"infor_popshare_friends_pre" , @"type" : [NSNumber numberWithInteger:ShareTypeToWechatTimeline]} ,
                       @{@"title" : @"新浪微博" , @"image" : @"infor_popshare_sina_nor" , @"highlightedImage" : @"infor_popshare_sina_pre" , @"type" : [NSNumber numberWithInteger:ShareTypeToSina]} ,
                       @{@"title" : @"QQ好友" , @"image" : @"infor_popshare_qq_nor" , @"highlightedImage" : @"infor_popshare_qq_pre" , @"type" : [NSNumber numberWithInteger:ShareTypeToQQFriend]} ,
                       @{@"title" : @"QQ空间" , @"image" : @"infor_popshare_kunjian_nor" , @"highlightedImage" : @"infor_popshare_kunjian_pre" , @"type" : [NSNumber numberWithInteger:ShareTypeToQZone]} ,
                       @{@"title" : @"新浪微博" , @"image" : @"infor_popshare_sina_nor" , @"highlightedImage" : @"infor_popshare_sina_pre" , @"type" : [NSNumber numberWithInteger:ShareTypeToSina]} ,
                       @{@"title" : @"QQ好友" , @"image" : @"infor_popshare_qq_nor" , @"highlightedImage" : @"infor_popshare_qq_pre" , @"type" : [NSNumber numberWithInteger:ShareTypeToQQFriend]} ,
                       @{@"title" : @"QQ空间" , @"image" : @"infor_popshare_kunjian_nor" , @"highlightedImage" : @"infor_popshare_kunjian_pre" , @"type" : [NSNumber numberWithInteger:ShareTypeToQZone]}];
    }
    lineMaxNumber = lineMaxNumber > 0 ? lineMaxNumber : 2;
    singleMaxCount = singleMaxCount > 0 ? singleMaxCount : 3;
}
#pragma mark - 初始化子视图
- (void)initSubview{
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.backgroundColor = [UIColor clearColor];
    _scrollView.delegate = self;
    _scrollView.bounces = YES;
    _scrollView.pagingEnabled = YES;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:_scrollView];
    _pageControl = [[UIPageControl alloc] init];
    _pageControl.currentPage = 0;
    _pageControl.pageIndicatorTintColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3f];
    _pageControl.currentPageIndicatorTintColor = [UIColor grayColor];
    [self addSubview:_pageControl];
    NSInteger index = 0;
    UIView *pageView = nil;
    for (NSDictionary *info in _infoArray) {
        if (index % (lineMaxNumber * singleMaxCount) == 0) {
            pageView = [[UIView alloc] init];
            [_scrollView addSubview:pageView];
            [_pageViewArray addObject:pageView];
        }
        ShareButton *button = [ShareButton buttonWithType:UIButtonTypeCustom];
        [button configTitle:info[@"title"] Image:[UIImage imageNamed:info[@"image"]]];
        [button setImage:[UIImage imageNamed:info[@"highlightedImage"]] forState:UIControlStateHighlighted];
        [button.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(shareButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [pageView addSubview:button];
        [_buttonArray addObject:button];
        index++;
    }
    _pageControl.numberOfPages = _pageViewArray.count > 1 ? _pageViewArray.count : 0;
}
#pragma mark - 设置自动布局
- (void)configAutoLayout{
    NSInteger lineNumber = ceilf((double)_infoArray.count / singleMaxCount); 
    NSInteger singleCount = ceilf((double)_infoArray.count / lineNumber); 
    singleCount = singleCount >= _infoArray.count ? singleCount : singleMaxCount ; 
    CGFloat buttonWidth = self.width / singleCount;
    CGFloat buttonHeight = 100.0f;
    NSInteger index = 0;
    NSInteger currentPageCount = 0;
    UIView *pageView = nil;
    for (ShareButton *button in _buttonArray) {
        if (index % (lineMaxNumber * singleMaxCount) == 0) {
            pageView = _pageViewArray[currentPageCount];
            if (currentPageCount == 0) {
                pageView.sd_layout
                .leftSpaceToView(_scrollView , 0)
                .topSpaceToView(_scrollView , 0)
                .rightSpaceToView(_scrollView , 0)
                .heightIs((lineNumber > lineMaxNumber ? lineMaxNumber : lineNumber ) * buttonHeight);
            } else {
                pageView.sd_layout
                .leftSpaceToView(_pageViewArray[currentPageCount - 1] , 0)
                .topSpaceToView(_scrollView , 0)
                .widthRatioToView(_pageViewArray[currentPageCount - 1] , 1)
                .heightRatioToView(_pageViewArray[currentPageCount - 1] , 1);
            }
            currentPageCount ++;
        }
        if (index == 0) {
            button.sd_layout
            .leftSpaceToView(pageView , 0)
            .topSpaceToView(pageView , 0)
            .widthIs(buttonWidth)
            .heightIs(buttonHeight);
        } else {
            if (index % singleCount == 0) {
                if (index % (lineMaxNumber * singleMaxCount) == 0) {
                    button.sd_layout
                    .leftSpaceToView(pageView , 0)
                    .topSpaceToView(pageView , 0)
                    .widthIs(buttonWidth)
                    .heightIs(buttonHeight);
                } else {
                    button.sd_layout
                    .leftSpaceToView(pageView , 0)
                    .topSpaceToView(_buttonArray[index - singleCount] , 0)
                    .widthIs(buttonWidth)
                    .heightIs(buttonHeight);
                }
            } else {
                button.sd_layout
                .leftSpaceToView(_buttonArray[index - 1] , 0)
                .topEqualToView(_buttonArray[index - 1])
                .widthIs(buttonWidth)
                .heightIs(buttonHeight);
            }
        }
        index ++;
    }
    _scrollView.sd_layout
    .topEqualToView(self)
    .leftSpaceToView(self, 0.0f)
    .rightSpaceToView(self , 0.0f)
    .heightRatioToView(_pageViewArray.lastObject , 1);
    [_scrollView setupAutoContentSizeWithRightView:_pageViewArray.lastObject rightMargin:0.0f];
    [_scrollView setupAutoContentSizeWithBottomView:_pageViewArray.lastObject bottomMargin:0.0f];
    _pageControl.sd_layout
    .leftEqualToView(self)
    .rightEqualToView(self)
    .topSpaceToView(_scrollView , 5.0f)
    .heightIs(10.0f);
    [self setupAutoHeightWithBottomView:_pageControl bottomMargin:0.0f];
}
#pragma mark - 分享按钮点击事件
- (void)shareButtonAction:(UIButton *)sender{
    __weak typeof(self) weakSelf = self;
    [LEEAlert closeWithCompletionBlock:^{
        if (!weakSelf) return;
        NSInteger index = [weakSelf.buttonArray indexOfObject:sender];
        ShareType type = (ShareType)[weakSelf.infoArray[index][@"type"] integerValue];
        if (weakSelf.openShareBlock) weakSelf.openShareBlock(type);
    }];
}
#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    self.pageControl.currentPage = scrollView.contentOffset.x / scrollView.width;
}
@end
