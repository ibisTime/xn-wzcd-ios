#import "TLTableView.h"
#import "DataTransferModel.h"
@interface DataTransferTableView : TLTableView
@property (nonatomic , strong)NSMutableArray <DataTransferModel *>*model;
@end
