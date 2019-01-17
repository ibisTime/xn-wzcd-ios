#import <UIKit/UIKit.h>
#import "AppColorMacro.h"
#import "MJRefresh.h"
@class TLTableView;
@protocol RefreshDelegate <NSObject>
@optional
- (void)refreshTableView:(TLTableView*)refreshTableview didSelectRowAtIndexPath:(NSIndexPath*)indexPath;
- (void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index;
- (void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index selectRowState:(NSString *)state;
- (void)refreshTableViewButtonClick:(TLTableView *)refreshTablevi BarName:(NSString *)name;
@end
@interface  TLTableView: UITableView
@property (nonatomic, weak)   id<RefreshDelegate> refreshDelegate;  
+ (instancetype)tableViewWithFrame:(CGRect)frame
                               delegate:(id)delegate dataSource:(id)dataSource;
+ (instancetype)groupTableViewWithFrame:(CGRect)frame
                          delegate:(id)delegate dataSource:(id)dataSource;
- (void)addRefreshAction:(void(^)())refresh;
- (void)addLoadMoreAction:(void(^)())loadMore;
- (void)beginRefreshing;
- (void)endRefreshHeader;
- (void)endRefreshFooter;
- (void)endRefreshingWithNoMoreData_tl;
- (void)resetNoMoreData_tl;
@property (nonatomic, assign) BOOL hiddenFooter;
@property (nonatomic, assign) BOOL hiddenHeader;
@property (nonatomic,strong) UIView *placeHolderView;
- (void)reloadData_tl;
@property (nonatomic, assign) NSInteger minDisplayRowCount;
@end
