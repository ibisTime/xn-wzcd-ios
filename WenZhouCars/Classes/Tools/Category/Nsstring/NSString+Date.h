#import <Foundation/Foundation.h>
@interface NSString (Date)
+ (NSString *)stringFromDate:(NSDate *)date formatter:(NSString *)formatter;
+ (NSDate *)dateFromString:(NSString *)dateString formatter:(NSString *)formatter;
+ (NSDate *)getLoaclDateWithFormatter:(NSString *)formatter;
+ (NSString*)stringFromTimeStamp:(NSString*)timeStampStr;
+ (NSString*)stringFromTimeStamp:(NSString *)timeStampStr formatter:(NSString *)formatter;
- (NSDateComponents*)timeIntetvalStringToDateComponents;
+ (NSDateComponents*)getCurrentComponents;
+ (NSString*)stringWithTimeStamp:(NSString *)timeStampStr;
+ (NSString*)stringWithTimeStamp:(NSString *)timeStampStr formatter:(NSString *)formatter;
+ (NSString *)stringWithTimeString:(NSString *)timeString timeFormatter:(NSString *)timeFormatter fotmatter:(NSString *)formatter;
+ (NSString *)stringWithTimeStr:(NSString *)timeStampStr format:(NSString *)format;
- (NSString *)convertToDetailDate; 
- (NSString *)convertToTimelineDate;
- (NSString *)convertDate;
- (NSDate *)convertToSysDate;
- (NSString *)convertDateWithFormat:(NSString *)format;
@end
FOUNDATION_EXTERN NSString  * const kCDSysTimeFormat;
