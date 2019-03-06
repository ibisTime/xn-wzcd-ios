#import "InvoiceNotMatchDetailsVC.h"
#import "InvoiceNotMatchDetailsTableView.h"
#import "SurveyDetailsVC.h"
#import "AccessApplyModel.h"
@interface InvoiceNotMatchDetailsVC ()<RefreshDelegate>
@property (nonatomic , strong)AccessApplyModel *surveyModel;
@property (nonatomic , strong)InvoiceNotMatchDetailsTableView *tableView;
@end
@implementation InvoiceNotMatchDetailsVC
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTableView];
    self.title = @"详情";
    [self loadData];
}
- (void)initTableView {
    self.tableView = [[InvoiceNotMatchDetailsTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    self.tableView.backgroundColor = kBackgroundColor;
    [self.view addSubview:self.tableView];
}
-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        SurveyDetailsVC *vc =[SurveyDetailsVC new];
        vc.code = self.surveyModel.code;
        [self.navigationController pushViewController:vc animated:YES];
    }
}
-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index
{
}
-(void)loadData
{
    ProjectWeakSelf;
    TLNetworking *http = [TLNetworking new];
    http.code = @"632146";
    http.showView = self.view;
    http.parameters[@"code"] = _code;
    [http postWithSuccess:^(id responseObject) {
        self.surveyModel = [AccessApplyModel mj_objectWithKeyValues:responseObject[@"data"]];
        weakSelf.tableView.surveyModel = self.surveyModel;
        [weakSelf.tableView reloadData];
    } failure:^(NSError *error) {
        WGLog(@"%@",error);
    }];
}
@end
