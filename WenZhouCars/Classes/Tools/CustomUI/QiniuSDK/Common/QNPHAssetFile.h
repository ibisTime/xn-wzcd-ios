#import <Foundation/Foundation.h>
#import "QNFileDelegate.h"
#if (defined(__IPHONE_OS_VERSION_MAX_ALLOWED) && __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000)
@class PHAsset;
@interface QNPHAssetFile : NSObject <QNFileDelegate>
- (instancetype)init:(PHAsset *)phAsset
               error:(NSError *__autoreleasing *)error;
@end
#endif
