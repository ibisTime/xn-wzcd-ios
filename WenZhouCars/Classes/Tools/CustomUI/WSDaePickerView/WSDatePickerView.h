#import <UIKit/UIKit.h>
#import "NSDate+Extension.h"
typedef enum{
    DateStyleShowYearMonthDayHourMinute  = 0,
    DateStyleShowMonthDayHourMinute,
    DateStyleShowYearMonthDay,
    DateStyleShowMonthDay,
    DateStyleShowHourMinute
}WSDateStyle;
@interface WSDatePickerView : UIView
@property (nonatomic,strong)UIColor *doneButtonColor;
@property (nonatomic,strong)UIColor *dateLabelColor;
@property (nonatomic,strong)UIColor *datePickerColor;
@property (nonatomic, retain) NSDate *maxLimitDate;
@property (nonatomic, retain) NSDate *minLimitDate;
@property (nonatomic, retain) UIColor *yearLabelColor;
-(instancetype)initWithDateStyle:(WSDateStyle)datePickerStyle CompleteBlock:(void(^)(NSDate *))completeBlock;
-(instancetype)initWithDateStyle:(WSDateStyle)datePickerStyle scrollToDate:(NSDate *)scrollToDate CompleteBlock:(void(^)(NSDate *))completeBlock;
-(void)show;
@end
