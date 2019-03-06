#import "ImageBrowserViewController.h"
#import "PhotoView.h"
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
@interface ImageBrowserViewController ()<UIScrollViewDelegate,PhotoViewDelegate>{
    NSMutableArray *_subViewArray;
}
@property(nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,weak) UIViewController *handleVC;
@property (nonatomic,assign) PhotoBroswerVCType type;
@property (nonatomic,strong) NSArray *imagesArray;
@property (nonatomic,assign) NSUInteger index;
@property(nonatomic,strong) UIPageControl *pageControl;
@property(nonatomic,strong) UIButton *DownloadButton;
@property(nonatomic,strong) PhotoView *photoView;
@end
@implementation ImageBrowserViewController
-(instancetype)init{
    self=[super init];
    if (self) {
        _subViewArray = [NSMutableArray arrayWithCapacity:0];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor blackColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.scrollView.contentSize = CGSizeMake(WIDTH * self.imagesArray.count, 0);
    for (int i = 0; i < self.imagesArray.count; i++) {
        [_subViewArray addObject:[NSNull class]];
    }
    self.scrollView.contentOffset = CGPointMake(WIDTH*self.index, 0);
    if (self.imagesArray.count==1) {
        _pageControl.hidden=YES;
    }else{
        self.pageControl.currentPage=self.index;
    }
    [self loadPhote:self.index];
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideCurrentVC:)];
    [self.view addGestureRecognizer:tap];
}
-(void)hideCurrentVC:(UIGestureRecognizer *)tap{
    [self hideScanImageVC];
}
#pragma mark - 显示图片
-(void)loadPhote:(NSInteger)index{
    if (index<0 || index >=self.imagesArray.count) {
        return;
    }
    id currentPhotoView = [_subViewArray objectAtIndex:index];
    if (![currentPhotoView isKindOfClass:[PhotoView class]]) {
        CGRect frame = CGRectMake(index*_scrollView.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height);
        if ([[self.imagesArray firstObject] isKindOfClass:[UIImage class]]) {
            PhotoView *photoV = [[PhotoView alloc] initWithFrame:frame withPhotoImage:[self.imagesArray objectAtIndex:index]];
            photoV.delegate = self;
            [self.scrollView insertSubview:photoV atIndex:0];
            [_subViewArray replaceObjectAtIndex:index withObject:photoV];
            self.photoView=photoV;
        }else if ([[self.imagesArray firstObject] isKindOfClass:[NSString class]]){
            PhotoView *photoV = [[PhotoView alloc] initWithFrame:frame withPhotoUrl:[self.imagesArray objectAtIndex:index]];
            photoV.delegate = self;
            [self.scrollView insertSubview:photoV atIndex:0];
            [_subViewArray replaceObjectAtIndex:index withObject:photoV];
            self.photoView=photoV;
        }
    }
}
#pragma mark - 生成显示窗口
+(void)show:(UIViewController *)handleVC type:(PhotoBroswerVCType)type index:(NSUInteger)index imagesBlock:(NSArray *(^)())imagesBlock{
    NSArray *photoModels = imagesBlock();
    if(photoModels == nil || photoModels.count == 0) {
        return;
    }
    ImageBrowserViewController *imgBrowserVC = [[self alloc] init];
    if(index >= photoModels.count){
        return;
    }
    imgBrowserVC.index = index;
    imgBrowserVC.imagesArray = photoModels;
    imgBrowserVC.type =type;
    imgBrowserVC.handleVC = handleVC;
    [imgBrowserVC show]; 
}
-(void)show{
    switch (_type) {
        case PhotoBroswerVCTypePush://push
            [self pushPhotoVC];
            break;
        case PhotoBroswerVCTypeModal://modal
            [self modalPhotoVC];
            break;
        case PhotoBroswerVCTypeZoom://zoom
            [self zoomPhotoVC];
            break;
        default:
            break;
    }
}
-(void)pushPhotoVC{
    [_handleVC.navigationController pushViewController:self animated:YES];
}
-(void)modalPhotoVC{
    [_handleVC presentViewController:self animated:YES completion:nil];
}
-(void)zoomPhotoVC{
    UIWindow *window = _handleVC.view.window;
    if(window == nil){
        NSLog(@"错误：窗口为空！");
        return;
    }
    self.view.frame=[UIScreen mainScreen].bounds;
    [window addSubview:self.view]; 
    [_handleVC addChildViewController:self]; 
}
#pragma mark - 隐藏当前显示窗口
-(void)hideScanImageVC{
    switch (_type) {
        case PhotoBroswerVCTypePush://push
            [self.navigationController popViewControllerAnimated:YES];
            break;
        case PhotoBroswerVCTypeModal://modal
            [self dismissViewControllerAnimated:YES completion:NULL];
            break;
        case PhotoBroswerVCTypeZoom://zoom
            [self.view removeFromSuperview];
            [self removeFromParentViewController];
            break;
        default:
            break;
    }
}
#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat pageWidth = scrollView.frame.size.width;
    NSInteger page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    if (page<0||page>=self.imagesArray.count) {
        return;
    }
    self.pageControl.currentPage = page;
    for (UIView *view in scrollView.subviews) {
        if ([view isKindOfClass:[PhotoView class]]) {
            PhotoView *photoV=(PhotoView *)[_subViewArray objectAtIndex:page];
            if (photoV!=self.photoView) {
                [self.photoView.scrollView setZoomScale:1.0 animated:YES];
                self.photoView=photoV;
            }
        }
    }
    [self loadPhote:page];
}
#pragma mark - PhotoViewDelegate
-(void)tapHiddenPhotoView{
    [self hideScanImageVC];
}
#pragma mark - 懒加载
-(UIScrollView *)scrollView{
    if (_scrollView==nil) {
        _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
        _scrollView.delegate=self;
        _scrollView.pagingEnabled=YES;
        _scrollView.contentOffset=CGPointZero;
        _scrollView.maximumZoomScale=3;
        _scrollView.minimumZoomScale=1;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        [self.view addSubview:_scrollView];
    }
    return _scrollView;
}
-(UIPageControl *)pageControl{
    if (_pageControl==nil) {
        UIView *bottomView=[[UIView alloc] initWithFrame:CGRectMake(0, HEIGHT-40, WIDTH, 30)];
        bottomView.backgroundColor=[UIColor clearColor];
        _pageControl = [[UIPageControl alloc] initWithFrame:bottomView.bounds];
        _pageControl.currentPage = self.index;
        _pageControl.numberOfPages = self.imagesArray.count;
        _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
        _pageControl.pageIndicatorTintColor = [UIColor grayColor];
        [bottomView addSubview:_pageControl];
        [self.view addSubview:bottomView];
    }
    return _pageControl;
}
#pragma mark - 系统自带代码
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
