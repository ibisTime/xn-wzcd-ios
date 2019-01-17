#import <UIKit/UIKit.h>
@interface UITableView (AddForPlaceholder)
@property (nonatomic, copy) void(^defaultNoDataViewDidClickBlock)(UIView *view);
@property (nonatomic, copy) NSString *defaultNoDataText;
@property (nonatomic, strong) UIImage *defaultNoDataImage;
@property (nonatomic, strong) UIView *customNoDataView;
@end
