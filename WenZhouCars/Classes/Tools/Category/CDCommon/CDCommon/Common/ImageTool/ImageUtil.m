#import "ImageUtil.h"
@implementation ImageUtil
+ (UIImage * )convertColorToImage:(UIColor *)color {
    if (!color) {
        return nil;
    }
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}
+ (CGSize)imageSizeByImageName:(NSString *)imageName {
    if ([imageName hasPrefix:@"http"]) {
        return CGSizeMake(4,3);
    } else {
        if ([imageName hasSuffix:@".jpg"] || [imageName hasSuffix:@".png"]) {
            NSString *urlName = [imageName substringWithRange:NSMakeRange(0, imageName.length - 4)];
            NSArray *arr = [urlName componentsSeparatedByString:@"_"];
            if (arr.count > 2) {
                CGFloat h = [arr[arr.count - 1] floatValue];
                CGFloat w = [arr[arr.count - 2] floatValue];
                return CGSizeMake(w, h);
            } else {
                return CGSizeMake(4, 3);
            }
        } else if ([imageName hasSuffix:@".jpeg"]) {
            NSString *urlName = [imageName substringWithRange:NSMakeRange(0, imageName.length - 5)];
            NSArray *arr = [urlName componentsSeparatedByString:@"_"];
            if (arr.count > 2) {
                CGFloat h = [arr[arr.count - 1] floatValue];
                CGFloat w = [arr[arr.count - 2] floatValue];
                return CGSizeMake(w, h);
            } else {
                return CGSizeMake(4, 3);
            }
        } else {
            return CGSizeMake(4, 3);
        }
    }
}
+ (NSString *)imageNameByImage:(UIImage *)img{
    CGSize imgSize = img.size;
    NSDate *now = [NSDate date];
    NSString *timestamp = [NSString stringWithFormat:@"%f",now.timeIntervalSince1970];
    timestamp = [timestamp stringByReplacingOccurrencesOfString:@"." withString:@""];
    NSString *imageName = [NSString stringWithFormat:@"iOS_%@_%.0f_%.0f.jpg",timestamp,imgSize.width,imgSize.height];
    return imageName;
}
+ (void)zipImageWithImage:(UIImage *)image begin:(void(^)())beginHandler end:(void(^)(UIImage *))endHandler {
    if (beginHandler) {
        beginHandler();
    }
    UIImage *oldImg = image;
    if (!oldImg) {
        endHandler(nil);
        return;
    }
    CGFloat H_W = oldImg.size.height/oldImg.size.width;
    if (H_W < 0.3333 || UIImageJPEGRepresentation(oldImg, 1).length < 0.5*1024*1024 ) {
        if (endHandler) {
            endHandler(oldImg);
            return;
        }
    }
    CGFloat zeroW_PX = 1080;
    CGFloat imgScale = oldImg.scale;
    CGFloat animationW = zeroW_PX/imgScale;
    if (oldImg.size.width <= animationW) {
        if (endHandler) {
            endHandler(oldImg);
            return;
        }
    }
    CGFloat zipScale = oldImg.size.width/animationW;
    CGSize targetSize = CGSizeMake(animationW, oldImg.size.height/zipScale);
    UIGraphicsBeginImageContext(targetSize);
    [oldImg drawInRect:CGRectMake(0, 0, targetSize.width,targetSize.height)];
    UIImage *newImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImage *lastImg = [UIImage imageWithData:UIImageJPEGRepresentation(newImg, 0.7)];
    if (endHandler) {
        endHandler(lastImg);
    }
}
+ (NSString *)convertImageUrl:(NSString *)imageUrl imageServerUrl:(NSString *)ServerUrl {
    if (!imageUrl) {
        return nil;
    }
    if ([imageUrl hasPrefix:@"http"] || [imageUrl hasPrefix:@"https"]) {
        return imageUrl;
    } else {
     return [[NSString stringWithFormat:@"%@/%@?imageMogr2/auto-orient/strip",ServerUrl,imageUrl] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    }
}
@end
