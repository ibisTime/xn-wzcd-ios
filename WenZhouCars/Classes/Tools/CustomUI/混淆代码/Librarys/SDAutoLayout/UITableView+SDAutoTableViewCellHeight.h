#import <UIKit/UIKit.h>
#import "UIView+SDAutoLayout.h"
@class SDCellAutoHeightManager;
typedef void (^AutoCellHeightDataSettingBlock)(UITableViewCell *cell);
#define kSDModelCellTag 199206
#pragma mark - UITableView 方法，返回自动计算出的cell高度
@interface UITableView (SDAutoTableViewCellHeight)
@property (nonatomic, strong) SDCellAutoHeightManager *cellAutoHeightManager;
- (CGFloat)cellHeightForIndexPath:(NSIndexPath *)indexPath model:(id)model keyPath:(NSString *)keyPath cellClass:(Class)cellClass contentViewWidth:(CGFloat)contentViewWidth;
- (CGFloat)cellHeightForIndexPath:(NSIndexPath *)indexPath cellClass:(Class)cellClass cellContentViewWidth:(CGFloat)width cellDataSetting:(AutoCellHeightDataSettingBlock)cellDataSetting;
- (void)reloadDataWithExistedHeightCache;
- (void)reloadDataWithInsertingDataAtTheBeginingOfSection:(NSInteger)section newDataCount:(NSInteger)count;
- (void)reloadDataWithInsertingDataAtTheBeginingOfSections:(NSArray *)sectionNumsArray newDataCounts:(NSArray *)dataCountsArray;
- (CGFloat)cellsTotalHeight;
@property (nonatomic, copy) AutoCellHeightDataSettingBlock cellDataSetting;
@end
#pragma mark - UITableViewController 方法，返回自动计算出的cell高度
@interface UITableViewController (SDTableViewControllerAutoCellHeight)
- (CGFloat)cellHeightForIndexPath:(NSIndexPath *)indexPath cellContentViewWidth:(CGFloat)width;
@end
#pragma mark - NSObject 方法，返回自动计算出的cell高度
@interface NSObject (SDAnyObjectAutoCellHeight)
- (CGFloat)cellHeightForIndexPath:(NSIndexPath *)indexPath cellContentViewWidth:(CGFloat)width tableView:(UITableView *)tableView;
@end
@interface SDCellAutoHeightManager : NSObject
@property (nonatomic, assign) BOOL shouldKeepHeightCacheWhenReloadingData;
@property (nonatomic, assign) CGFloat contentViewWidth;
@property (nonatomic, assign) Class cellClass;
@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, strong) UITableViewCell *modelCell;
@property (nonatomic, strong) NSMutableDictionary *subviewFrameCacheDict;
@property (nonatomic, strong, readonly) NSDictionary *heightCacheDict;
@property (nonatomic, copy) AutoCellHeightDataSettingBlock cellDataSetting;
- (void)clearHeightCache;
- (void)clearHeightCacheOfIndexPaths:(NSArray *)indexPaths;
- (void)deleteThenResetHeightCache:(NSIndexPath *)indexPathToDelete;
- (void)insertNewDataAtTheBeginingOfSection:(NSInteger)section newDataCount:(NSInteger)count;
- (void)insertNewDataAtIndexPaths:(NSArray *)indexPaths;
- (NSNumber *)heightCacheForIndexPath:(NSIndexPath *)indexPath;
- (CGFloat)cellHeightForIndexPath:(NSIndexPath *)indexPath model:(id)model keyPath:(NSString *)keyPath;
- (CGFloat)cellHeightForIndexPath:(NSIndexPath *)indexPath model:(id)model keyPath:(NSString *)keyPath cellClass:(Class)cellClass;
- (NSMutableArray *)subviewFrameCachesWithIndexPath:(NSIndexPath *)indexPath;;
- (void)setSubviewFrameCache:(CGRect)rect WithIndexPath:(NSIndexPath *)indexPath;
- (instancetype)initWithCellClass:(Class)cellClass tableView:(UITableView *)tableView;
+ (instancetype)managerWithCellClass:(Class)cellClass tableView:(UITableView *)tableView;
@end
