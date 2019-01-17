#import "TLTableView.h"
#import "UIScrollView+TLAdd.h"
#define  adjustsContentInsets(scrollView)\
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
if ([UIScrollView instancesRespondToSelector:NSSelectorFromString(@"setContentInsetAdjustmentBehavior:")]) {\
[scrollView   performSelector:NSSelectorFromString(@"setContentInsetAdjustmentBehavior:") withObject:@(2)];\
}\
_Pragma("clang diagnostic pop") \
} while (0)
@interface TLTableView ()
@property (nonatomic, copy) void(^refresh)();
@property (nonatomic, copy) void(^loadMore)();
@end
@implementation TLTableView
{
    UIView *_placeholderV;
}
+ (instancetype)groupTableViewWithFrame:(CGRect)frame
                               delegate:(id)delegate dataSource:(id)dataSource {
    TLTableView *tableView = [[TLTableView alloc] initWithFrame:frame style:UITableViewStyleGrouped];
    tableView.delegate = delegate;
    tableView.dataSource = dataSource;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.estimatedRowHeight = 0;
    tableView.estimatedSectionHeaderHeight = 0;
    tableView.estimatedSectionFooterHeight = 0;
    [tableView adjustsContentInsets];
    return tableView;
}
+ (instancetype)tableViewWithFrame:(CGRect)frame
                          delegate:(id)delegate dataSource:(id)dataSource
{
    TLTableView *tableView = [[TLTableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    tableView.delegate = delegate;
    tableView.dataSource = dataSource;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.estimatedRowHeight = 0;
    tableView.estimatedSectionHeaderHeight = 0;
    tableView.estimatedSectionFooterHeight = 0;
    return tableView;
}
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        self.backgroundColor = BackColor;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.estimatedRowHeight = 0;
        self.estimatedSectionHeaderHeight = 0;
        self.estimatedSectionFooterHeight = 0;
        if (@available(iOS 11.0, *)) {
            self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return self;
}
- (void)addRefreshAction:(void (^)())refresh
{
    self.refresh = refresh;
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:self.refresh];
    self.mj_header = header;
}
- (void)addLoadMoreAction:(void (^)())loadMore
{
    self.loadMore = loadMore;
    MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:loadMore];
    UIImageView *logo = [[UIImageView  alloc] initWithFrame:footer.bounds];
    logo.image = [UIImage imageNamed:@"logo_small"];
    [footer addSubview:logo];
    footer.arrowView.hidden = YES;
    self.mj_footer = footer;
}
- (void)beginRefreshing
{
    if (self.mj_header == nil) {
        return;
    }
    [self.mj_header beginRefreshing];
}
- (void)endRefreshHeader
{
    if (self.mj_header == nil) {
    }else{
        [self.mj_header endRefreshing];
    }
}
- (void)endRefreshFooter
{
    if (!self.mj_footer) {
        NSLog(@"刷新尾部组件不存在");
        return;
    }
    [self.mj_footer endRefreshing];
}
- (void)endRefreshingWithNoMoreData_tl
{
    if (self.mj_footer) {
        [self.mj_footer endRefreshingWithNoMoreData];
    }
}
- (void)resetNoMoreData_tl
{
    if (self.mj_footer) {
        [self.mj_footer resetNoMoreData];
    }
}
- (void)setHiddenFooter:(BOOL)hiddenFooter
{
    _hiddenFooter = hiddenFooter;
    if (self.mj_footer) {
        self.mj_footer.hidden = hiddenFooter;
    }else{
        NSLog(@"footer不存在");
    }
}
- (void)setHiddenHeader:(BOOL)hiddenHeader
{
    _hiddenHeader = hiddenHeader;
    if (self.mj_header) {
        self.mj_header.hidden = hiddenHeader;
    }else{
        NSLog(@"header不存在");
    }
}
-(void)reloadData_tl
{
    [super reloadData];
    long sections = 1;
    BOOL isEmpty = YES; 
    if ([self.dataSource respondsToSelector:@selector(numberOfSectionsInTableView:)]){
        sections = [self.dataSource numberOfSectionsInTableView:self];
    }
    for ( int i = 0; i < sections; i++) {
        long numOfRow = 0;
        if ([self.dataSource respondsToSelector:@selector(tableView:numberOfRowsInSection:)]){
            numOfRow = [self.dataSource tableView:self numberOfRowsInSection:i];
        }
        if (numOfRow > 0) { 
            isEmpty = NO;
        }
    }
    if (isEmpty == YES) {
        if ( ABS((CGRectGetMinY(self.placeHolderView.frame) - CGRectGetHeight(self.tableHeaderView.frame))) > 1 ) {
            CGRect frame = self.placeHolderView.frame;
            frame.origin.y = self.tableHeaderView.frame.size.height;
            self.placeHolderView.frame = frame;
        }
        [self addSubview:self.placeHolderView];
    }else{
        [self.placeHolderView removeFromSuperview];
    }
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.refreshDelegate respondsToSelector:@selector(refreshTableView:didSelectRowAtIndexPath:)]) {
        [self.refreshDelegate refreshTableView:self didSelectRowAtIndexPath:indexPath];
    }
}
@end
