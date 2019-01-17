#import "SurveyDetailsVC.h"
#import "SurveyDetailsTableView.h"
#import "SurveyInformationVC.h"
#import "SurveyDetailsModel.h"
@interface SurveyDetailsVC ()<RefreshDelegate>
@property (nonatomic , strong)SurveyDetailsTableView *tableView;
@property (nonatomic , strong)SurveyDetailsModel *model;
@end
@implementation SurveyDetailsVC
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"征信详情";
    [self initTableView];
    [self loadData];
}
- (void)initTableView {
    self.tableView = [[SurveyDetailsTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    self.tableView.backgroundColor = kBackgroundColor;
    [self.view addSubview:self.tableView];
}
-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}
-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index
{
    SurveyInformationVC *vc = [SurveyInformationVC new];
    vc.dataDic = self.model.creditUserList[index - 123];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)loadData
{
    ProjectWeakSelf;
    TLNetworking *http = [TLNetworking new];
    http.code = @"632117";
    http.showView = self.view;
    http.parameters[@"code"] = _code;
    [http postWithSuccess:^(id responseObject) {
        self.model = [SurveyDetailsModel mj_objectWithKeyValues:responseObject[@"data"]];
        weakSelf.tableView.surveyDetailsModel = self.model;
        [weakSelf.tableView reloadData];
    } failure:^(NSError *error) {
        WGLog(@"%@",error);
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
