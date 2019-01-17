#import "TLTableView.h"
#import "GPSInstallationModel.h"
#import "GPSInstallationDetailsModel.h"
@interface InstallationDetailsTableView : TLTableView
@property (nonatomic , strong)GPSInstallationModel *model;
@property (nonatomic , strong)GPSInstallationDetailsModel *detailsModel;
@end
