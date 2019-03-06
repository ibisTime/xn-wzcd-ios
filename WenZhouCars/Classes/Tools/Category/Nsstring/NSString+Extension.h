#import <Foundation/Foundation.h>
@interface NSString (Extension)
+ (NSString *)convertNullOrNil:(NSString *)str;
+ (NSString *)serializeMessage:(id)message;
+ (id)deserializeMessageJSON:(NSString *)messageJSON;
+ (NSString *)stringWithRegularExpression:(NSString *)regularStr string:(NSString *)string;
+ (NSString *)MD5:(NSString *)sourceString;
+ (NSString *)stringWithReturnCode:(NSInteger)returnCode;
- (NSString *)convertImageUrl;
- (NSString *)convertImageUrlWithScale:(NSInteger)scale;
- (NSAttributedString *)attrStr;
- (NSString *)md5String;
- (NSString *)convertToSysMoney;
- (NSString *)subNumber:(NSString *)number;
- (NSString *)divNumber:(NSString *)number leaveNum:(NSInteger)num;
- (NSString *)convertToSimpleRealMoney;
- (NSString *)convertToRealMoneyWithNum:(NSInteger)num;
+ (NSString *)getWifiMacAddress;
+ (NSString *)getIPAddress:(BOOL)preferIPv4;
+ (NSString *)appVersionString;
@end
