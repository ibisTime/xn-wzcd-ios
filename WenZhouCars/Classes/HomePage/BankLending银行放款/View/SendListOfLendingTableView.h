#import "TLTableView.h"
#import "AccessSingleModel.h"
@interface SendListOfLendingTableView : TLTableView
@property (nonatomic , strong)AccessSingleModel *model;
@property (nonatomic ,copy)NSString *imageData;
@end
