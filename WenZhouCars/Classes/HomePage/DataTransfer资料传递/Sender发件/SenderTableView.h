#import "TLTableView.h"
#import "DataTransferModel.h"
@interface SenderTableView : TLTableView
@property (nonatomic , strong)DataTransferModel *model;
@property (nonatomic , copy)NSString *distributionStr;
@property (nonatomic , copy)NSString *CourierCompanyStr;
@property (nonatomic , copy)NSString *date;
@end
