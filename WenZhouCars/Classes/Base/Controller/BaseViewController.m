#import "BaseViewController.h"
@interface BaseViewController ()
@end
@implementation BaseViewController
-(UIButton *)LeftBackbButton
{
    if (!_LeftBackbButton) {
        _LeftBackbButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _LeftBackbButton.frame = CGRectMake(0, 0, 44, 44);
        _LeftBackbButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_LeftBackbButton setImage:HGImage(@"返回") forState:(UIControlStateNormal)];
    }
    return _LeftBackbButton;
}
-(UIButton *)RightButton
{
    if (!_RightButton) {
        _RightButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _RightButton.frame = CGRectMake(0, 0, 44, 44);
        _RightButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        _RightButton.titleLabel.font = HGfont(16);
    }
    return _RightButton;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor  =[UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO; self.navigationController.navigationBar.titleTextAttributes=@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:18]};
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = kNavBarBackgroundColor;
    self.navigationController.navigationBar.backIndicatorImage = [UIImage imageNamed:@"返回"];
    self.navigationController.navigationBar.backIndicatorTransitionMaskImage = [UIImage imageNamed:@"返回"];
    self.navigationItem.backBarButtonItem = item;
}
@end
