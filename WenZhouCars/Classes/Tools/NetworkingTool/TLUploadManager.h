#import <Foundation/Foundation.h>
#import "QiniuSDK.h"
#import <UIKit/UIKit.h>
@interface TLUploadManager : NSObject
@property (nonatomic, strong) NSData *imgData;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, copy) NSString *videoData;
+ (instancetype)manager;
+ (NSString *)imageNameByImage:(UIImage *)img;
- (void)getTokenShowView:(UIView *)showView succes:(void(^)(NSString * token))success
                 failure:(void(^)(NSError *error))failure;
- (void)getTokenShowView1:(UIView *)showView succes:(void(^)(NSString * token))success
                 failure:(void(^)(NSError *error))failure;
- (void)getTokenShowViewFile:(UIView *)showView succes:(void(^)(NSString * token))success
                     failure:(void(^)(NSError *error))failure;
@end
