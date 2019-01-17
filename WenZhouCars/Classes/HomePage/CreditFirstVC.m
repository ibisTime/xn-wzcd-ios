#import "CreditFirstVC.h"
#import "CreditFirstTableView.h"
#import "SurveyInformationVC.h"
#import "SurveyDetailsModel.h"
@interface CreditFirstVC ()<RefreshDelegate>
{
}
@property (nonatomic , strong)CreditFirstTableView *tableView;
@property (nonatomic , strong)SurveyDetailsModel *model;
@property (nonatomic , strong)TLImagePicker *imagePicker;
@property (nonatomic , strong)NSMutableArray *imageArray;
@property (nonatomic , strong)NSMutableArray *peopleArray;
@end
@implementation CreditFirstVC
- (TLImagePicker *)imagePicker {
    if (!_imagePicker) {
        ProjectWeakSelf;
        _imagePicker = [[TLImagePicker alloc] initWithVC:self];
        _imagePicker.allowsEditing = YES;
        _imagePicker.pickFinish = ^(NSDictionary *info){
            UIImage *image = info[@"UIImagePickerControllerOriginalImage"];
            NSData *imgData = UIImageJPEGRepresentation(image, 0.1);
            TLUploadManager *manager = [TLUploadManager manager];
            manager.imgData = imgData;
            manager.image = image;
            [manager getTokenShowView:weakSelf.view succes:^(NSString *key) {
                WGLog(@"%@",key);
                [weakSelf setImage:image setData:key];
            } failure:^(NSError *error) {
            }];
        };
    }
    return _imagePicker;
}
-(void)setImage:(UIImage *)image setData:(NSString *)data
{
    [self.imageArray addObject:data];
    self.tableView.imageArray = self.imageArray;
    [self.tableView reloadData];
}
-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index selectRowState:(NSString *)state
{
    if ([state isEqualToString:@"add"])
    {
        [self.imagePicker picker];
    }else if([state isEqualToString:@"choose"])
    {
        if (sender.selected == YES) {
            [self.peopleArray addObject:self.model.creditUserList[index - 100]];
        }else
        {
            for (int i = 0; i < self.peopleArray.count; i++) {
                if ([self.peopleArray[index - 100][@"code"] isEqualToString:self.peopleArray[i][@"code"]]) {
                    [self.peopleArray removeObjectAtIndex:i];
                }
            }
        }
        NSLog(@"%@",self.peopleArray);
    }
    else{
        [self.imageArray removeObjectAtIndex:index - 1000];
        self.tableView.imageArray = self.imageArray;
        [self.tableView reloadData];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"征信初审";
    [self initTableView];
    [self loadData];
    self.imageArray = [NSMutableArray array];
    self.peopleArray = [NSMutableArray array];
}
- (void)initTableView {
    self.tableView = [[CreditFirstTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    self.tableView.backgroundColor = kBackgroundColor;
    [self.view addSubview:self.tableView];
}
-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}
-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index
{
    if (index == 10000) {
        [self CreditFirstWhetherThrough:@"1"];
    }
    else if (index == 10001)
    {
        [self CreditFirstWhetherThrough:@"0"];
    }
    else
    {
        SurveyInformationVC *vc = [SurveyInformationVC new];
        vc.dataDic = self.model.creditUserList[index - 123];
        [self.navigationController pushViewController:vc animated:YES];
    }
}
-(void)CreditFirstWhetherThrough:(NSString *)approveResult
{
    UITextField *textField = [self.view viewWithTag:1212];
    if (self.peopleArray.count == 0) {
        [TLAlert alertWithInfo:@"请选择征信人"];
        return;
    }
    if ([textField.text isEqualToString:@""]) {
        [TLAlert alertWithInfo:@"请输入审核意见"];
        return;
    }
    TLNetworking *http = [TLNetworking new];
    http.code = @"632113";
    http.showView = self.view;
    http.parameters[@"approveNote"] = textField.text;
    http.parameters[@"accessory"] = [self.tableView.imageArray componentsJoinedByString:@"||"];
    http.parameters[@"code"] = self.model.code;
    http.parameters[@"creditUserList"] = self.peopleArray;
    http.parameters[@"updater"] = [USERDEFAULTS objectForKey:USER_ID];
    http.parameters[@"operator"] = [USERDEFAULTS objectForKey:USER_ID];
    http.parameters[@"approveResult"] = approveResult;
    [http postWithSuccess:^(id responseObject) {
        if ([approveResult isEqualToString:@"1"]) {
            [TLAlert alertWithSucces:@"初审成功"];
        }else
        {
            [TLAlert alertWithSucces:@"初审不通过"];
        }
        NSNotification *notification =[NSNotification notificationWithName:LOADDATAPAGE object:nil userInfo:nil];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSError *error) {
        WGLog(@"%@",error);
    }];
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
@end
