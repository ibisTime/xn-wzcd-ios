#import "SurveyInformationVC.h"
#import "SurveyInformationTableView.h"
#import "BankCreditReportVC.h"
@interface SurveyInformationVC ()<RefreshDelegate>
@property (nonatomic , strong)SurveyInformationTableView *tableView;
@end
@implementation SurveyInformationVC
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"征信人";
    [self initTableView];
    [self navigativeView];
}
-(void)navigativeView
{
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = -10;
    self.navigationItem.rightBarButtonItems = @[negativeSpacer, [[UIBarButtonItem alloc] initWithCustomView:self.RightButton]];
    [self.RightButton setTitle:@"征信报告" forState:(UIControlStateNormal)];
    [self.RightButton addTarget:self action:@selector(rightButtonClick) forControlEvents:(UIControlEventTouchUpInside)];
}
-(void)rightButtonClick
{
    BankCreditReportVC *vc = [BankCreditReportVC new];
    vc.dataDic = self.dataDic;
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)initTableView {
    self.tableView = [[SurveyInformationTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    self.tableView.backgroundColor = kBackgroundColor;
    self.tableView.model = [SurvuyPeopleModel mj_objectWithKeyValues:_dataDic];
    [self.view addSubview:self.tableView];
}
-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}
-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index
{
}
@end
