#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface ImageUtil : NSObject
+ (UIImage * )convertColorToImage:(UIColor *)color;
+ (CGSize)imageSizeByImageName:(NSString *)imageName;
+ (NSString *)imageNameByImage:(UIImage *)img;
+ (void)zipImageWithImage:(UIImage *)image begin:(void(^)())beginHandler end:(void(^)(UIImage *))endHandler;
+ (NSString *)convertImageUrl:(NSString *)imageUrl imageServerUrl:(NSString *)ServerUrl;
@end
