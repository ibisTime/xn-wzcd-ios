#import "FinancialEndowmentDetailsVC.h"
#import "FinancialEndowmentDetailsTableView.h"
#import "SurveyDetailsVC.h"
@interface FinancialEndowmentDetailsVC ()<RefreshDelegate>
@property (nonatomic , strong)FinancialEndowmentDetailsTableView *tableView;
@end
@implementation FinancialEndowmentDetailsVC
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTableView];
    self.title = @"垫资详情";
}
- (void)initTableView {
    self.tableView = [[FinancialEndowmentDetailsTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    self.tableView.backgroundColor = kBackgroundColor;
    self.tableView.surveyModel = self.surveyModel;
    [self.view addSubview:self.tableView];
}
-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        SurveyDetailsVC *vc =[SurveyDetailsVC new];
        vc.code = self.surveyModel.budgetCode;
        [self.navigationController pushViewController:vc animated:YES];
    }
}
-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index
{
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
