#import <Foundation/Foundation.h>
@interface GPSClaimsModel : NSObject
@property (nonatomic , assign)NSInteger status;
@property (nonatomic , copy)NSString *applyUserName;
@property (nonatomic , copy)NSString *applyReason;
@property (nonatomic , copy)NSString *code;
@property (nonatomic , copy)NSString *companyCode;
@property (nonatomic , copy)NSString *applyUser;
@property (nonatomic , copy)NSString *applyCount;
@property (nonatomic , copy)NSString *type;
@property (nonatomic , copy)NSString *companyName;
@property (nonatomic , copy)NSString *applyDatetime;
@property (nonatomic , strong)NSArray *gpsList;
@end
