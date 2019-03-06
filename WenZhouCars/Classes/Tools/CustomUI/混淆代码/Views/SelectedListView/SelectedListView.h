#import <UIKit/UIKit.h>
#import "SelectedListModel.h"
@interface SelectedListView : UITableView
@property (nonatomic , strong ) NSArray<SelectedListModel *>* array;
@property (nonatomic , copy ) void (^selectedBlock)(NSArray <SelectedListModel *>*);
@property (nonatomic , copy ) void (^changedBlock)(NSArray <SelectedListModel *>*);
@property (nonatomic , assign ) BOOL isSingle;
- (void)finish;
@end
