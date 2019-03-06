#import <Foundation/Foundation.h>
#import "QNRecorderDelegate.h"
extern const UInt32 kQNBlockSize;
typedef NSString * (^QNUrlConvert)(NSString *url);
@class QNConfigurationBuilder;
@class QNDnsManager;
@class QNZone;
typedef void (^QNConfigurationBuilderBlock)(QNConfigurationBuilder *builder);
@interface QNConfiguration : NSObject
@property (copy, nonatomic, readonly) QNZone *zone;
@property (readonly) UInt32 chunkSize;
@property (readonly) UInt32 putThreshold;
@property (readonly) UInt32 retryMax;
@property (readonly) UInt32 timeoutInterval;
@property (nonatomic, assign) BOOL useHttps;
@property (nonatomic, readonly) id<QNRecorderDelegate> recorder;
@property (nonatomic, readonly) QNRecorderKeyGenerator recorderKeyGen;
@property (nonatomic, readonly) NSDictionary *proxy;
@property (nonatomic, readonly) QNUrlConvert converter;
@property (nonatomic, readonly) QNDnsManager *dns;
@property (readonly) BOOL disableATS;
+ (instancetype)build:(QNConfigurationBuilderBlock)block;
@end
typedef void (^QNPrequeryReturn)(int code);
@class QNUpToken;
@class QNZoneInfo;
@interface QNZone : NSObject
@property (nonatomic, strong) NSArray<NSString *> *upDomainList;
@property (nonatomic, strong) QNZoneInfo *zoneInfo;
- (void)preQuery:(QNUpToken *)token
              on:(QNPrequeryReturn)ret;
- (NSString *)up:(QNUpToken *)token
         isHttps:(BOOL)isHttps
    frozenDomain:(NSString *)frozenDomain;
@end
@interface QNZoneInfo : NSObject
@property (readonly, nonatomic) long ttl;
@property (readonly, nonatomic) NSMutableArray<NSString *> *upDomainsList;
@property (readonly, nonatomic) NSMutableDictionary *upDomainsDic;
- (instancetype)init:(long)ttl
       upDomainsList:(NSMutableArray<NSString *> *)upDomainsList
        upDomainsDic:(NSMutableDictionary *)upDomainsDic;
- (QNZoneInfo *)buildInfoFromJson:(NSDictionary *)resp;
@end
@interface QNFixedZone : QNZone
+ (instancetype)zone0;
+ (instancetype)zone1;
+ (instancetype)zone2;
+ (instancetype)zoneNa0;
+ (instancetype)zoneAs0;
- (instancetype)initWithupDomainList:(NSArray<NSString *> *)upList;
+ (instancetype)createWithHost:(NSArray<NSString *> *)upList;
- (void)preQuery:(QNUpToken *)token
              on:(QNPrequeryReturn)ret;
- (NSString *)up:(QNUpToken *)token
         isHttps:(BOOL)isHttps
    frozenDomain:(NSString *)frozenDomain;
@end
@interface QNAutoZone : QNZone
- (instancetype)initWithDns:(QNDnsManager *)dns;
- (NSString *)up:(QNUpToken *)token
         isHttps:(BOOL)isHttps
    frozenDomain:(NSString *)frozenDomain;
@end
@interface QNConfigurationBuilder : NSObject
@property (nonatomic, strong) QNZone *zone;
@property (assign) UInt32 chunkSize;
@property (assign) UInt32 putThreshold;
@property (assign) UInt32 retryMax;
@property (assign) UInt32 timeoutInterval;
@property (nonatomic, assign) BOOL useHttps;
@property (nonatomic, strong) id<QNRecorderDelegate> recorder;
@property (nonatomic, strong) QNRecorderKeyGenerator recorderKeyGen;
@property (nonatomic, strong) NSDictionary *proxy;
@property (nonatomic, strong) QNUrlConvert converter;
@property (nonatomic, strong) QNDnsManager *dns;
@property (assign) BOOL disableATS;
@end
