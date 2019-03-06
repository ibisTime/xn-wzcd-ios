#import "AppDelegate.h"
#import "HomeVC.h"
@interface AppDelegate ()
@end
@implementation AppDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    if([BaseModel user].isLogin == NO) {
        LoginVC *VC = [[LoginVC alloc]init];
        self.window.rootViewController = VC;
    }else
    {
        HomeVC *VC = [[HomeVC alloc]init];
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:VC];
        self.window.rootViewController = nav;
    }
    [self.window makeKeyAndVisible];
    return YES;
}
- (void)applicationWillResignActive:(UIApplication *)application {
}
- (void)applicationDidEnterBackground:(UIApplication *)application {
}
- (void)applicationWillEnterForeground:(UIApplication *)application {
}
- (void)applicationDidBecomeActive:(UIApplication *)application {
}
- (void)applicationWillTerminate:(UIApplication *)application {
}
@end
