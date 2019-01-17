#import "AccessSingleModel.h"
@implementation AccessSingleModel
- (NSArray *)pics1 {
    if (!_pics1) {
        NSArray *imgs = [self.carInvoice componentsSeparatedByString:@"||"];
        NSMutableArray *newImgs = [NSMutableArray arrayWithCapacity:imgs.count];
        [imgs enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj convertImageUrl]) {
                [newImgs addObject:[obj convertImageUrl]];
            }
        }];
        _pics1 = newImgs;
    }
    return _pics1;
}
- (NSArray *)pics2 {
    if (!_pics2) {
        NSArray *imgs = [self.carHgzPic componentsSeparatedByString:@"||"];
        NSMutableArray *newImgs = [NSMutableArray arrayWithCapacity:imgs.count];
        [imgs enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj convertImageUrl]) {
                [newImgs addObject:[obj convertImageUrl]];
            }
        }];
        _pics2 = newImgs;
    }
    return _pics2;
}
- (NSArray *)pics3 {
    if (!_pics3) {
        NSArray *imgs = [self.carJqx componentsSeparatedByString:@"||"];
        NSMutableArray *newImgs = [NSMutableArray arrayWithCapacity:imgs.count];
        [imgs enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj convertImageUrl]) {
                [newImgs addObject:[obj convertImageUrl]];
            }
        }];
        _pics3 = newImgs;
    }
    return _pics3;
}
- (NSArray *)pics4 {
    if (!_pics4) {
        NSArray *imgs = [self.carSyx componentsSeparatedByString:@"||"];
        NSMutableArray *newImgs = [NSMutableArray arrayWithCapacity:imgs.count];
        [imgs enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj convertImageUrl]) {
                [newImgs addObject:[obj convertImageUrl]];
            }
        }];
        _pics4 = newImgs;
    }
    return _pics4;
}
- (NSArray *)pics5 {
    if (!_pics4) {
        NSArray *imgs = [self.interviewOtherPdf componentsSeparatedByString:@"||"];
        NSMutableArray *newImgs = [NSMutableArray arrayWithCapacity:imgs.count];
        [imgs enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj convertImageUrl]) {
                [newImgs addObject:[obj convertImageUrl]];
            }
        }];
        _pics5 = newImgs;
    }
    return _pics5;
}
@end
