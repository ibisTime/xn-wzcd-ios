#import "SurvuyPeopleModel.h"
@implementation SurvuyPeopleModel
- (NSArray *)pics1 {
    if (!_pics1) {
        NSArray *imgs = [self.authPdf componentsSeparatedByString:@"||"];
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
        NSArray *imgs = [self.interviewPic componentsSeparatedByString:@"||"];
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
        NSArray *imgs = [self.bankCreditResultPdf componentsSeparatedByString:@"||"];
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
@end
