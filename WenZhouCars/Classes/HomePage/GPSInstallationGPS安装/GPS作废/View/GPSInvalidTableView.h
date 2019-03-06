#import "TLTableView.h"
#import "GPSInstallationModel.h"
@interface GPSInvalidTableView : TLTableView
@property (nonatomic , strong)GPSInstallationModel *model;
@property (nonatomic , copy)NSString *GPS;
@end
