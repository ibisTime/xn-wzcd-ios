#import <Foundation/Foundation.h>
@protocol BaseModelDelegate <NSObject>
-(void)TheReturnValueStr:(NSString *)Str selectDic:(NSDictionary *)dic selectSid:(NSInteger)sid;
@end
@interface BaseModel : NSObject
@property (nonatomic, assign) id <BaseModelDelegate> ModelDelegate;
+ (instancetype)user;
- (BOOL)isLogin;
+ (BOOL) isBlankString:(NSString *)string;
+ (NSString*)convertNull:(id)object;
- (void)saveUserInfo:(NSDictionary *)userInfo;
- (void)updateUserInfoWithNotification;
- (void)CustomBouncedView:(NSMutableArray *)nameArray setState:(NSString *)state;
-(void )ReturnsParentKeyAnArray:(NSString *)parentKey;
-(NSString *)note:(NSString *)curNodeCode;
-(NSString *)setParentKey:(NSString *)parentKey setDkey:(NSString *)dkey;
@end
