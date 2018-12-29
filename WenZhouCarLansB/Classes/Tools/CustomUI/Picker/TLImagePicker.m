//
//  TLImagePicker.m
//  ZHBusiness
//
//  Created by  tianlei on 2016/12/16.
//  Copyright © 2016年  tianlei. All rights reserved.
//

#import "TLImagePicker.h"

@interface TLImagePicker ()

@property (nonatomic,strong) UIViewController *vc;

@end

@implementation TLImagePicker

- (instancetype)initWithVC:(UIViewController *)ctrl{

    if (self = [super init]) {
        
        self.vc = ctrl;
        
    }
    return self;

}

- (void)picker {
    
    UIImagePickerController *pickCtrl = [[UIImagePickerController alloc] init];
    pickCtrl.delegate = self;
    pickCtrl.allowsEditing = self.allowsEditing;

    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {
        [action setValue:HGColor(138, 138, 138) forKey:@"titleTextColor"];
    }];
    UIAlertAction* fromPhotoAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault                                                                 handler:^(UIAlertAction * action) {

        pickCtrl.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self.vc presentViewController:pickCtrl animated:YES completion:nil];

    }];
    UIAlertAction* fromPhotoAction1 = [UIAlertAction actionWithTitle:@"从手机相册选择" style:UIAlertActionStyleDefault                                                                 handler:^(UIAlertAction * action) {

        pickCtrl.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self.vc presentViewController:pickCtrl animated:YES completion:nil];

    }];
    [cancelAction setValue:GaryTextColor forKey:@"_titleTextColor"];
    [fromPhotoAction setValue:MainColor forKey:@"_titleTextColor"];
    [fromPhotoAction1 setValue:MainColor forKey:@"_titleTextColor"];
    [alertController addAction:cancelAction];
    [alertController addAction:fromPhotoAction];
    [alertController addAction:fromPhotoAction1];
    [self.vc presentViewController:alertController animated:YES completion:nil];

}


-(void)videoPicker
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {
        [action setValue:HGColor(138, 138, 138) forKey:@"titleTextColor"];
    }];
    UIAlertAction* fromPhotoAction = [UIAlertAction actionWithTitle:@"拍摄" style:UIAlertActionStyleDefault                                                                 handler:^(UIAlertAction * action) {

        UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
        ipc.sourceType = UIImagePickerControllerSourceTypeCamera;//sourcetype有三种分别是camera，photoLibrary和photoAlbum
        NSArray *availableMedia = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];//Camera所支持的Media格式都有哪些,共有两个分别是@"public.image",@"public.movie"
        ipc.mediaTypes = [NSArray arrayWithObject:availableMedia[1]];//设置媒体类型为public.movie
        [self.vc presentViewController:ipc animated:YES completion:nil];
        ipc.videoMaximumDuration = 30.0f;//30秒
        ipc.delegate = self;//设置委托

    }];
    UIAlertAction* fromPhotoAction1 = [UIAlertAction actionWithTitle:@"从手机相册选择" style:UIAlertActionStyleDefault                                                                 handler:^(UIAlertAction * action) {

        UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
        ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;//sourcetype有三种分别是camera，photoLibrary和photoAlbum
        NSArray *availableMedia = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];//Camera所支持的Media格式都有哪些,共有两个分别是@"public.image",@"public.movie"
        ipc.mediaTypes = [NSArray arrayWithObject:availableMedia[1]];//设置媒体类型为public.movie
        [self.vc presentViewController:ipc animated:YES completion:nil];
        ipc.delegate = self;//设置委托

    }];
    [cancelAction setValue:GaryTextColor forKey:@"_titleTextColor"];
    [fromPhotoAction setValue:MainColor forKey:@"_titleTextColor"];
    [fromPhotoAction1 setValue:MainColor forKey:@"_titleTextColor"];
    [alertController addAction:cancelAction];
    [alertController addAction:fromPhotoAction];
    [alertController addAction:fromPhotoAction1];
    [self.vc presentViewController:alertController animated:YES completion:nil];
}

- (CGFloat) getFileSize:(NSString *)path
{
    NSLog(@"%@",path);
    NSFileManager *fileManager = [NSFileManager defaultManager];
    float filesize = -1.0;
    if ([fileManager fileExistsAtPath:path]) {
        NSDictionary *fileDic = [fileManager attributesOfItemAtPath:path error:nil];//获取文件的属性
        unsigned long long size = [[fileDic objectForKey:NSFileSize] longLongValue];
        filesize = 1.0*size/1024;
    }else{
        NSLog(@"找不到文件");
    }
    return filesize;
}

//此方法可以获取文件的大小，返回的是单位是KB。
//- (CGFloat) getVideoLength:(NSURL *)URL
//{
//    AVURLAsset *avUrl = [AVURLAsset assetWithURL:URL];
//    CMTime time = [avUrl duration];
//    int second = ceil(time.value/time.timescale);
//    return second;
//}//此方法可以获取视频文件的时长。



- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {

    [picker dismissViewControllerAnimated:YES completion:nil];
    
    if (self.pickFinish) {
        _pickFinish(info);
    }
}


@end
