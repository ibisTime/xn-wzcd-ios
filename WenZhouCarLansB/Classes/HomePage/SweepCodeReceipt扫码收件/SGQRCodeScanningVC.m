#import "SGQRCodeScanningVC.h"
#import "SGQRCode.h"
@interface SGQRCodeScanningVC () <SGQRCodeScanManagerDelegate, SGQRCodeAlbumManagerDelegate>
@property (nonatomic, strong) SGQRCodeScanManager *manager;
@property (nonatomic, strong) SGQRCodeScanningView *scanningView;
@property (nonatomic, strong) UIButton *flashlightBtn;
@property (nonatomic, strong) UILabel *promptLabel;
@property (nonatomic, assign) BOOL isSelectedFlashlightBtn;
@property (nonatomic, strong) UIView *bottomView;

@property (nonatomic , strong)UIButton *backButton;
@property (nonatomic , strong)UILabel *titleLabel;

@end

@implementation SGQRCodeScanningVC

-(UIButton *)backButton
{
    if (!_backButton) {
        _backButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _backButton.frame = CGRectMake(0, kStatusBarHeight, 44, 44);
        [_backButton setImage:HGImage(@"返回") forState:(UIControlStateNormal)];
        [_backButton addTarget:self action:@selector(backButtonCLick) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _backButton;
}



#pragma mark -- 返回按钮点击方法
-(void)backButtonCLick
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -- 标题懒加载
-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, kStatusBarHeight, SCREEN_WIDTH, 44)];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.font = HGboldfont(18);
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.text = @"扫一扫";
    }
    return _titleLabel;
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.scanningView addTimer];
    [_manager resetSampleBufferDelegate];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.scanningView removeTimer];
    [self removeFlashlightBtn];
    [_manager cancelSampleBufferDelegate];
//    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    [_manager startRunning];
//    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;

    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [_manager startRunning];
}

- (void)dealloc {
    NSLog(@"SGQRCodeScanningVC - dealloc");
    [self removeScanningView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor clearColor];
//    self.automaticallyAdjustsScrollViewInsets = NO;
//    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    [self.view addSubview:self.scanningView];
    [self setupNavigationBar];
    [self setupQRCodeScanning];
    [self.view addSubview:self.promptLabel];
    /// 为了 UI 效果
    [self.view addSubview:self.bottomView];
    [self.view addSubview:self.backButton];
    [self.view addSubview:self.titleLabel];
    
}

- (void)setupNavigationBar {
    self.navigationItem.title = @"扫一扫";
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"相册" style:(UIBarButtonItemStyleDone) target:self action:@selector(rightBarButtonItenAction)];
}



- (SGQRCodeScanningView *)scanningView {
    if (!_scanningView) {
        _scanningView = [[SGQRCodeScanningView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 0.9 * self.view.frame.size.height)];
        //        _scanningView.scanningImageName = @"SGQRCode.bundle/QRCodeScanningLineGrid";
        //        _scanningView.scanningAnimationStyle = ScanningAnimationStyleGrid;
        //        _scanningView.cornerColor = [UIColor orangeColor];
    }
    return _scanningView;
}
- (void)removeScanningView {
    [self.scanningView removeTimer];
    [self.scanningView removeFromSuperview];
    self.scanningView = nil;
}

//- (void)rightBarButtonItenAction {
//    SGQRCodeAlbumManager *manager = [SGQRCodeAlbumManager sharedManager];
//    [manager readQRCodeFromAlbumWithCurrentController:self];
//    manager.delegate = self;
//
//    if (manager.isPHAuthorization == YES) {
//        [self.scanningView removeTimer];
//    }
//}

- (void)setupQRCodeScanning {
    self.manager = [SGQRCodeScanManager sharedManager];
    NSArray *arr = @[AVMetadataObjectTypeQRCode, AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code];
    // AVCaptureSessionPreset1920x1080 推荐使用，对于小型的二维码读取率较高
    [_manager setupSessionPreset:AVCaptureSessionPreset1920x1080 metadataObjectTypes:arr currentController:self];
//        [_manager cancelSampleBufferDelegate];
    _manager.delegate = self;
}

//#pragma mark - - - SGQRCodeAlbumManagerDelegate
//- (void)QRCodeAlbumManagerDidCancelWithImagePickerController:(SGQRCodeAlbumManager *)albumManager {
//    [self.view addSubview:self.scanningView];
//}
//
//- (void)QRCodeAlbumManager:(SGQRCodeAlbumManager *)albumManager didFinishPickingMediaWithResult:(NSString *)result {
//
//    if ([result hasPrefix:@"http"]) {
//
////        ScanSuccessJumpVC *jumpVC = [[ScanSuccessJumpVC alloc] init];
////        NSLog(@"result ======  %@",result);
////        jumpVC.jump_URL = result;
////        [self.navigationController pushViewController:jumpVC animated:YES];
//
//    }
//    else
//    {
//        [SVProgressHUD setMinimumDismissTimeInterval:2];
//        [SVProgressHUD showErrorWithStatus:@"暂不支持次二维码"];
//
////        ScanSuccessJumpVC *jumpVC = [[ScanSuccessJumpVC alloc] init];
////        jumpVC.jump_bar_code = result;
////        [self.navigationController pushViewController:jumpVC animated:YES];
//    }
//}

#pragma mark - - - SGQRCodeScanManagerDelegate

- (void)QRCodeScanManager:(SGQRCodeScanManager *)scanManager didOutputMetadataObjects:(NSArray *)metadataObjects {
    NSLog(@"metadataObjects - - %@", metadataObjects);
    if (metadataObjects != nil && metadataObjects.count > 0) {
        [scanManager palySoundName:@"SGQRCode.bundle/sound.caf"];
        
        
        AVMetadataMachineReadableCodeObject *obj = metadataObjects[0];
        WGLog(@"%@",metadataObjects);
        WGLog(@"%@",[obj stringValue]);
        [scanManager stopRunning];
//        [scanManager videoPreviewLayerRemoveFromSuperlayer];
        NSMutableString *code = [NSMutableString string];
        code = [NSMutableString stringWithFormat:@"%@",[obj stringValue]];;


//        [string substringToIndex:7];//截取掉下标7之后的字符串
//
//        [string substringFromIndex:2];//截取掉下标2之前的字符串
//
//        [string substringWithRange:range];//截取范围类的字符串
//
//        遇到一个问题,
//        如何直接截取某串字符串的后8位??

        NSString *first = [code substringToIndex:1];
        NSMutableString *codeList = [NSMutableString string];
        codeList = [NSMutableString stringWithFormat:@"%@",[obj stringValue]];
        [codeList deleteCharactersInRange:NSMakeRange(0, 1)];
        NSLog(@"%@   %@   %@",[obj stringValue],first,codeList);

        [self.navigationController popViewControllerAnimated:YES];

        NSDictionary *dic = @{
                              @"first":first,
                              @"codeList":codeList
                              };
        NSNotification *notification =[NSNotification notificationWithName:@"SweepCodeReceipt" object:nil userInfo:dic];
        [[NSNotificationCenter defaultCenter] postNotification:notification];


    }
}


- (void)QRCodeScanManager:(SGQRCodeScanManager *)scanManager brightnessValue:(CGFloat)brightnessValue {
    if (brightnessValue < - 1) {
        [self.view addSubview:self.flashlightBtn];
    } else {
        if (self.isSelectedFlashlightBtn == NO) {
            [self removeFlashlightBtn];
        }
    }
}

- (UILabel *)promptLabel {
    if (!_promptLabel) {
        _promptLabel = [[UILabel alloc] init];
        _promptLabel.backgroundColor = [UIColor clearColor];
        CGFloat promptLabelX = 0;
        CGFloat promptLabelY = 0.73 * self.view.frame.size.height;
        CGFloat promptLabelW = self.view.frame.size.width;
        CGFloat promptLabelH = 25;
        _promptLabel.frame = CGRectMake(promptLabelX, promptLabelY, promptLabelW, promptLabelH);
        _promptLabel.textAlignment = NSTextAlignmentCenter;
        _promptLabel.font = [UIFont boldSystemFontOfSize:13.0];
        _promptLabel.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.6];
        _promptLabel.text = @"将二维码放入框内,即可自动扫描";
    }
    return _promptLabel;
}

- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.scanningView.frame), self.view.frame.size.width, self.view.frame.size.height - CGRectGetMaxY(self.scanningView.frame))];
        _bottomView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    }
    return _bottomView;
}

#pragma mark - - - 闪光灯按钮
- (UIButton *)flashlightBtn {
    if (!_flashlightBtn) {
        // 添加闪光灯按钮
        _flashlightBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        CGFloat flashlightBtnW = 30;
        CGFloat flashlightBtnH = 30;
        CGFloat flashlightBtnX = 0.5 * (self.view.frame.size.width - flashlightBtnW);
        CGFloat flashlightBtnY = 0.55 * self.view.frame.size.height;
        _flashlightBtn.frame = CGRectMake(flashlightBtnX, flashlightBtnY, flashlightBtnW, flashlightBtnH);
        [_flashlightBtn setBackgroundImage:[UIImage imageNamed:@"SGQRCodeFlashlightOpenImage"] forState:(UIControlStateNormal)];
        [_flashlightBtn setBackgroundImage:[UIImage imageNamed:@"SGQRCodeFlashlightCloseImage"] forState:(UIControlStateSelected)];
        [_flashlightBtn addTarget:self action:@selector(flashlightBtn_action:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _flashlightBtn;
}

- (void)flashlightBtn_action:(UIButton *)button {
    if (button.selected == NO) {
        [SGQRCodeHelperTool SG_openFlashlight];
        self.isSelectedFlashlightBtn = YES;
        button.selected = YES;
    } else {
        [self removeFlashlightBtn];
    }
}

- (void)removeFlashlightBtn {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SGQRCodeHelperTool SG_CloseFlashlight];
        self.isSelectedFlashlightBtn = NO;
        self.flashlightBtn.selected = NO;
        [self.flashlightBtn removeFromSuperview];
    });
}



@end

