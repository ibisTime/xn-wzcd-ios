#import "TLTableView.h"
#import "SettlementAuditModel.h"
@interface HistoryUserTableView : TLTableView
@property (nonatomic , strong)NSMutableArray <SettlementAuditModel *>*model;
@end
