#import "TLTableView.h"
#import "GPSInstallationModel.h"
@interface GPSInstallationDetailsTableView : TLTableView
@property (nonatomic , strong)GPSInstallationModel *model;
@property (nonatomic , strong)NSArray *peopleAray;
@property (nonatomic , copy)NSString *date;
@property (nonatomic , copy)NSString *GPS;
@property (nonatomic , copy)NSString *location;
@end
