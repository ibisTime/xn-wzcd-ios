#import "TLTableView.h"
#import "AccessSingleModel.h"
@interface AccessSingleTableView : TLTableView
@property (nonatomic , strong)NSMutableArray <AccessSingleModel *>*model;
@end
