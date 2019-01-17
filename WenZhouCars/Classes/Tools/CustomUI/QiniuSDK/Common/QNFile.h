#import "QNFileDelegate.h"
#import <Foundation/Foundation.h>
@interface QNFile : NSObject <QNFileDelegate>
- (instancetype)init:(NSString *)path
               error:(NSError *__autoreleasing *)error;
@end
