#import <UIKit/UIKit.h>
@class SDAutoLayoutModel, SDUIViewCategoryManager;
typedef SDAutoLayoutModel *(^MarginToView)(id viewOrViewsArray, CGFloat value);
typedef SDAutoLayoutModel *(^Margin)(CGFloat value);
typedef SDAutoLayoutModel *(^MarginEqualToView)(UIView *toView);
typedef SDAutoLayoutModel *(^WidthHeight)(CGFloat value);
typedef SDAutoLayoutModel *(^WidthHeightEqualToView)(UIView *toView, CGFloat ratioValue);
typedef SDAutoLayoutModel *(^AutoHeightWidth)(CGFloat ratioValue);
typedef SDAutoLayoutModel *(^SameWidthHeight)();
typedef SDAutoLayoutModel *(^Offset)(CGFloat value);
typedef void (^SpaceToSuperView)(UIEdgeInsets insets);
@interface SDAutoLayoutModel : NSObject
@property (nonatomic, copy, readonly) MarginToView leftSpaceToView;
@property (nonatomic, copy, readonly) MarginToView rightSpaceToView;
@property (nonatomic, copy, readonly) MarginToView topSpaceToView;
@property (nonatomic, copy, readonly) MarginToView bottomSpaceToView;
@property (nonatomic, copy, readonly) Margin xIs;
@property (nonatomic, copy, readonly) Margin yIs;
@property (nonatomic, copy, readonly) Margin centerXIs;
@property (nonatomic, copy, readonly) Margin centerYIs;
@property (nonatomic, copy, readonly) WidthHeight widthIs;
@property (nonatomic, copy, readonly) WidthHeight heightIs;
@property (nonatomic, copy, readonly) WidthHeight maxWidthIs;
@property (nonatomic, copy, readonly) WidthHeight maxHeightIs;
@property (nonatomic, copy, readonly) WidthHeight minWidthIs;
@property (nonatomic, copy, readonly) WidthHeight minHeightIs;
@property (nonatomic, copy, readonly) MarginEqualToView leftEqualToView;
@property (nonatomic, copy, readonly) MarginEqualToView rightEqualToView;
@property (nonatomic, copy, readonly) MarginEqualToView topEqualToView;
@property (nonatomic, copy, readonly) MarginEqualToView bottomEqualToView;
@property (nonatomic, copy, readonly) MarginEqualToView centerXEqualToView;
@property (nonatomic, copy, readonly) MarginEqualToView centerYEqualToView;
@property (nonatomic, copy, readonly) WidthHeightEqualToView widthRatioToView;
@property (nonatomic, copy, readonly) WidthHeightEqualToView heightRatioToView;
@property (nonatomic, copy, readonly) SameWidthHeight widthEqualToHeight;
@property (nonatomic, copy, readonly) SameWidthHeight heightEqualToWidth;
@property (nonatomic, copy, readonly) AutoHeightWidth autoHeightRatio;
@property (nonatomic, copy, readonly) AutoHeightWidth autoWidthRatio;
@property (nonatomic, copy, readonly) SpaceToSuperView spaceToSuperView;
@property (nonatomic, copy, readonly) Offset offset;
@property (nonatomic, weak) UIView *needsAutoResizeView;
@end
#pragma mark - UIView 高度、宽度自适应相关方法
@interface UIView (SDAutoHeightWidth)
- (void)setupAutoHeightWithBottomView:(UIView *)bottomView bottomMargin:(CGFloat)bottomMargin;
- (void)setupAutoWidthWithRightView:(UIView *)rightView rightMargin:(CGFloat)rightMargin;
- (void)setupAutoHeightWithBottomViewsArray:(NSArray *)bottomViewsArray bottomMargin:(CGFloat)bottomMargin;
- (void)updateLayout;
- (void)updateLayoutWithCellContentView:(UIView *)cellContentView;
- (void)clearAutoHeigtSettings;
- (void)clearAutoWidthSettings;
@property (nonatomic) CGFloat autoHeight;
@property (nonatomic, readonly) SDUIViewCategoryManager *sd_categoryManager;
@property (nonatomic, readonly) NSMutableArray *sd_bottomViewsArray;
@property (nonatomic) CGFloat sd_bottomViewBottomMargin;
@property (nonatomic) NSArray *sd_rightViewsArray;
@property (nonatomic) CGFloat sd_rightViewRightMargin;
@end
#pragma mark - UIView 设置圆角半径、自动布局回调block等相关方法
@interface UIView (SDLayoutExtention)
@property (nonatomic) void (^didFinishAutoLayoutBlock)(CGRect frame);
- (void)sd_addSubviews:(NSArray *)subviews;
@property (nonatomic, strong) NSNumber *sd_cornerRadius;
@property (nonatomic, strong) NSNumber *sd_cornerRadiusFromWidthRatio;
@property (nonatomic, strong) NSNumber *sd_cornerRadiusFromHeightRatio;
@property (nonatomic, strong) NSArray *sd_equalWidthSubviews;
@end
#pragma mark - UIView 九宫格浮动布局效果
@interface UIView (SDAutoFlowItems)
- (void)setupAutoWidthFlowItems:(NSArray *)viewsArray withPerRowItemsCount:(NSInteger)perRowItemsCount verticalMargin:(CGFloat)verticalMargin horizontalMargin:(CGFloat)horizontalMagin verticalEdgeInset:(CGFloat)vInset horizontalEdgeInset:(CGFloat)hInset;
- (void)clearAutoWidthFlowItemsSettings;
- (void)setupAutoMarginFlowItems:(NSArray *)viewsArray withPerRowItemsCount:(NSInteger)perRowItemsCount itemWidth:(CGFloat)itemWidth verticalMargin:(CGFloat)verticalMargin verticalEdgeInset:(CGFloat)vInset horizontalEdgeInset:(CGFloat)hInset;
- (void)clearAutoMarginFlowItemsSettings;
@end
#pragma mark - UIView 设置约束、更新约束、清空约束、从父view移除并清空约束、开启cell的frame缓存等相关方法
@interface UIView (SDAutoLayout)
- (SDAutoLayoutModel *)sd_layout;
- (SDAutoLayoutModel *)sd_resetLayout;
- (SDAutoLayoutModel *)sd_resetNewLayout;
@property (nonatomic, getter = sd_isClosingAutoLayout) BOOL sd_closeAutoLayout;
- (void)removeFromSuperviewAndClearAutoLayoutSettings;
- (void)sd_clearAutoLayoutSettings;
- (void)sd_clearViewFrameCache;
- (void)sd_clearSubviewsAutoLayoutFrameCaches;
@property (nonatomic, strong) NSNumber *fixedWidth;
@property (nonatomic, strong) NSNumber *fixedHeight;
- (void)useCellFrameCacheWithIndexPath:(NSIndexPath *)indexPath tableView:(UITableView *)tableview;
@property (nonatomic) UITableView *sd_tableView;
@property (nonatomic) NSIndexPath *sd_indexPath;
- (NSMutableArray *)autoLayoutModelsArray;
- (void)addAutoLayoutModel:(SDAutoLayoutModel *)model;
@property (nonatomic) SDAutoLayoutModel *ownLayoutModel;
@property (nonatomic, strong) NSNumber *sd_maxWidth;
@property (nonatomic, strong) NSNumber *autoHeightRatioValue;
@property (nonatomic, strong) NSNumber *autoWidthRatioValue;
@end
#pragma mark - UIScrollView 内容竖向自适应、内容横向自适应方法
@interface UIScrollView (SDAutoContentSize)
- (void)setupAutoContentSizeWithBottomView:(UIView *)bottomView bottomMargin:(CGFloat)bottomMargin;
- (void)setupAutoContentSizeWithRightView:(UIView *)rightView rightMargin:(CGFloat)rightMargin;
@end
#pragma mark - UILabel 开启富文本布局、设置单行文本label宽度自适应、 设置label最多可以显示的行数
@interface UILabel (SDLabelAutoResize)
@property (nonatomic) BOOL isAttributedContent;
- (void)setSingleLineAutoResizeWithMaxWidth:(CGFloat)maxWidth;
- (void)setMaxNumberOfLinesToShow:(NSInteger)lineCount;
@end
#pragma mark - UIButton 设置button根据单行文字自适应
@interface UIButton (SDExtention)
- (void)setupAutoSizeWithHorizontalPadding:(CGFloat)hPadding buttonHeight:(CGFloat)buttonHeight;
@end
#pragma mark - 其他方法（如果有需要可以自己利用以下接口拓展更多功能）
@interface SDAutoLayoutModelItem : NSObject
@property (nonatomic, strong) NSNumber *value;
@property (nonatomic, weak) UIView *refView;
@property (nonatomic, assign) CGFloat offset;
@property (nonatomic, strong) NSArray *refViewsArray;
@end
@interface UIView (SDChangeFrame)
@property (nonatomic) BOOL shouldReadjustFrameBeforeStoreCache;
@property (nonatomic) CGFloat left_sd;
@property (nonatomic) CGFloat top_sd;
@property (nonatomic) CGFloat right_sd;
@property (nonatomic) CGFloat bottom_sd;
@property (nonatomic) CGFloat centerX_sd;
@property (nonatomic) CGFloat centerY_sd;
@property (nonatomic) CGFloat width_sd;
@property (nonatomic) CGFloat height_sd;
@property (nonatomic) CGPoint origin_sd;
@property (nonatomic) CGSize size_sd;
@property (nonatomic) CGFloat left;
@property (nonatomic) CGFloat top;
@property (nonatomic) CGFloat right;
@property (nonatomic) CGFloat bottom;
@property (nonatomic) CGFloat centerX;
@property (nonatomic) CGFloat centerY;
@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;
@property (nonatomic) CGPoint origin;
@property (nonatomic) CGSize size;
@end
@interface SDUIViewCategoryManager : NSObject
@property (nonatomic, strong) NSArray *rightViewsArray;
@property (nonatomic, assign) CGFloat rightViewRightMargin;
@property (nonatomic, weak) UITableView *sd_tableView;
@property (nonatomic, strong) NSIndexPath *sd_indexPath;
@property (nonatomic, assign) BOOL hasSetFrameWithCache;
@property (nonatomic) BOOL shouldReadjustFrameBeforeStoreCache;
@property (nonatomic, assign, getter = sd_isClosingAutoLayout) BOOL sd_closeAutoLayout;
@property (nonatomic, strong) NSArray *flowItems;
@property (nonatomic, assign) CGFloat verticalMargin;
@property (nonatomic, assign) CGFloat horizontalMargin;
@property (nonatomic, assign) NSInteger perRowItemsCount;
@property (nonatomic, assign) CGFloat lastWidth;
@property (nonatomic, assign) CGFloat flowItemWidth;
@property (nonatomic, assign) BOOL shouldShowAsAutoMarginViews;
@property (nonatomic) CGFloat horizontalEdgeInset;
@property (nonatomic) CGFloat verticalEdgeInset;
@end
