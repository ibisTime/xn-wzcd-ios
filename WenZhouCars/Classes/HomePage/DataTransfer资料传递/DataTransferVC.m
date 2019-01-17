#import "DataTransferVC.h"
#import "DataSentItemsVC.h"
#import "DataCollectedVC.h"
#import "GPSSentItemsVC.h"
#import "GPSCollectedVC.h"
@interface DataTransferVC ()<UIScrollViewDelegate>
@property (nonatomic, strong)UIScrollView *scroll;
@property (nonatomic, strong)UIButton *selectBtn;
@property (nonatomic, assign)NSInteger currentPages;
@property (nonatomic, strong)UILabel *WeiGreLabel;
@property (nonatomic, strong)DataSentItemsVC *vc1;
@property (nonatomic, strong)DataCollectedVC *vc2;
@property (nonatomic, strong)GPSSentItemsVC *vc3;
@property (nonatomic, strong)GPSCollectedVC *vc4;
#define kPageCount 4
#define kButton_H 50
#define kMrg 10
#define kTag 1000
@end
@implementation DataTransferVC
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"资料传递";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    [self setupScrollView];
    [self setupChildViewControll];
    [self setupPageButton];
    self.WeiGreLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 48 , SCREEN_WIDTH/4, 2)];
    self.WeiGreLabel.backgroundColor = MainColor;
    [self.view addSubview:self.WeiGreLabel];
    [self setupSelectBtn];
    [_scroll setContentOffset:CGPointMake(SCREEN_WIDTH * _currentPages, 0) animated:YES];
}
#pragma mark - 设置可以左右滑动的ScrollView
- (void)setupScrollView{
    self.scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, kButton_H , SCREEN_WIDTH, SCREEN_HEIGHT)];
    _scroll.pagingEnabled = YES;
    _scroll.delegate = self;
    _scroll.bounces = NO;
    _scroll.showsVerticalScrollIndicator = NO;
    _scroll.directionalLockEnabled = YES;
    _scroll.contentSize = CGSizeMake(SCREEN_WIDTH * kPageCount, SCREEN_HEIGHT/2);
    [self.view addSubview:_scroll];
}
#pragma mark - 设置控制的每一个子控制器
- (void)setupChildViewControll{
    self.vc1 = [[DataSentItemsVC alloc]init];
    self.vc2 = [[DataCollectedVC alloc]init];
    self.vc3 = [[GPSSentItemsVC alloc]init];
    self.vc4 = [[GPSCollectedVC alloc]init];
    [self addChildViewController:_vc1];
    [self addChildViewController:_vc2];
    [self addChildViewController:_vc3];
    [self addChildViewController:_vc4];
    [_scroll addSubview:_vc1.view];
    [_scroll addSubview:_vc2.view];
    [_scroll addSubview:_vc3.view];
    [_scroll addSubview:_vc4.view];
    _vc1.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    _vc2.view.frame = CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    _vc3.view.frame = CGRectMake(SCREEN_WIDTH * 2, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    _vc4.view.frame = CGRectMake(SCREEN_WIDTH * 3, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
}
#pragma mark - 设置分页按钮
- (void)setupPageButton{
    UIButton *btn = [self setupButtonWithTitle:@"资料发件" Index:0];
    [self setupButtonWithTitle:@"资料收件" Index:1];
    [self setupButtonWithTitle:@"GPS发件" Index:2];
    [self setupButtonWithTitle:@"GPS收件" Index:3];
    [btn setTitleColor:MainColor forState:(UIControlStateNormal)];
    self.selectBtn = btn;
}
- (UIButton *)setupButtonWithTitle:(NSString *)title Index:(NSInteger)index{
    CGFloat y = 0;
    CGFloat w = SCREEN_WIDTH / kPageCount;
    CGFloat h = kButton_H;
    CGFloat x = index * w;
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:(UIControlStateNormal)];
    btn.frame = CGRectMake(x, y, w, h);
    btn.titleLabel.font = HGboldfont(15);
    btn.tag = index + kTag;
    [btn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [btn addTarget:self action:@selector(pageClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:btn];
    return btn;
}
#pragma mark -- 按钮点击方法
- (void)pageClick:(UIButton *)btn
{
    self.currentPages = btn.tag - kTag;
    [self gotoCurrentPage];
}
#pragma mark - 设置选中button的样式
- (void)setupSelectBtn{
    UIButton *btn = [self.view viewWithTag:self.currentPages + kTag];
    if ([self.selectBtn isEqual:btn]) {
        return;
    }
    [self.selectBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    self.selectBtn = btn;
    [btn setTitleColor:MainColor forState:(UIControlStateNormal)];
    [UIView animateWithDuration:0.3 animations:^{
        self.WeiGreLabel.frame = CGRectMake(self.currentPages * SCREEN_WIDTH/4, 48 , SCREEN_WIDTH/4, 3);
    }];
}
#pragma mark -   进入当前的选定页面
- (void)gotoCurrentPage{
    CGRect frame;
    frame.origin.x = self.scroll.frame.size.width * self.currentPages;
    frame.origin.y = 0;
    frame.size = _scroll.frame.size;
    [_scroll scrollRectToVisible:frame animated:YES];
}
#pragma mark - ScrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat pageWidth = _scroll.frame.size.width;
    self.currentPages = floor((_scroll.contentOffset.x - pageWidth/2)/pageWidth) + 1;
    [self setupSelectBtn];
}
@end
