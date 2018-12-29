//
//  SendListOfLendingVC.m
//  WenZhouCarLansB
//
//  Created by QinBao Zheng on 2018/9/14.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "SendListOfLendingVC.h"
#import "SendListOfLendingTableView.h"
@interface SendListOfLendingVC ()<RefreshDelegate>

@property (nonatomic , strong)SendListOfLendingTableView *tableView;
@property (nonatomic , strong)TLImagePicker *imagePicker;
@end

@implementation SendListOfLendingVC



- (TLImagePicker *)imagePicker {

    if (!_imagePicker) {
        ProjectWeakSelf;
        _imagePicker = [[TLImagePicker alloc] initWithVC:self];

        _imagePicker.allowsEditing = YES;
        _imagePicker.pickFinish = ^(NSDictionary *info){
            UIImage *image = info[@"UIImagePickerControllerOriginalImage"];
            NSData *imgData = UIImageJPEGRepresentation(image, 0.1);

                //进行上传
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
    self.tableView.imageData = data;
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initTableView];
    self.title = @"发送放款名单";
}

- (void)initTableView {
    self.tableView = [[SendListOfLendingTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    self.tableView.backgroundColor = kBackgroundColor;
    self.tableView.model = self.model;
    [self.view addSubview:self.tableView];
}

-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index selectRowState:(NSString *)state
{
    [self.imagePicker picker];
}

-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index
{
    UITextField *textFid1 = [self.view viewWithTag:1100];
    UITextField *textFid2 = [self.view viewWithTag:1101];
    if ([textFid1.text isEqualToString:@""]) {
        [TLAlert alertWithInfo:@"请输入对账单日期"];
        return;
    }
    if ([textFid2.text isEqualToString:@""]) {
        [TLAlert alertWithInfo:@"请输入银行还款日期"];
        return;
    }
    if ([BaseModel isBlankString:self.tableView.imageData] == YES) {
        [TLAlert alertWithInfo:@"请上传已放款图片"];
        return;
    }
    TLNetworking *http = [TLNetworking new];
    http.code = @"632144";
    http.showView = self.view;
    http.parameters[@"code"] = _model.code;
    http.parameters[@"billDatetime"] = textFid1.text;
    http.parameters[@"repayBankDate"] = textFid2.text;
    http.parameters[@"code"] = self.model.code;
    http.parameters[@"codeList"] = @[self.model.code];
    http.parameters[@"hasLoanListPic"] = self.tableView.imageData;
    
    http.parameters[@"operator"] = [USERDEFAULTS objectForKey:USER_ID];
    http.parameters[@"updater"] = [USERDEFAULTS objectForKey:USER_ID];

    [http postWithSuccess:^(id responseObject) {
        [TLAlert alertWithSucces:@"提交成功"];
        NSNotification *notification =[NSNotification notificationWithName:LOADDATAPAGE object:nil userInfo:nil];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
        [self.navigationController popViewControllerAnimated:YES];

    } failure:^(NSError *error) {
        WGLog(@"%@",error);
    }];
}

@end
