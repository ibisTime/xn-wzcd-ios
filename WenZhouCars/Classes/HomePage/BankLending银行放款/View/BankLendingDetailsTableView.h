#import "TLTableView.h"
#import "AccessSingleModel.h"
@interface BankLendingDetailsTableView : TLTableView
@property (nonatomic , copy)NSString *date;
@property (nonatomic , strong)AccessSingleModel *model;
@end
