#import <Foundation/Foundation.h>
#import "TLTableView.h"
@interface TLPageDataHelper : NSObject
@property (nonatomic, assign) NSInteger start;
@property (nonatomic, assign) NSInteger limit;
@property (nonatomic, copy) NSString *code;
@property (nonatomic, strong) UIView *showView; 
@property (nonatomic, assign) BOOL isDeliverCompanyCode; 
@property (nonatomic, assign) BOOL isList;
@property (nonatomic, assign) BOOL isCurrency;
@property (nonatomic, weak) TLTableView *tableView;
@property (nonatomic, weak) UICollectionView *collectionView;
@property (nonatomic, copy) id(^dealWithPerModel)(id model);
@property (nonatomic,strong) NSMutableDictionary *parameters;
- (void)modelClass:(Class)className;
- (void)refresh:(void(^)(NSMutableArray *objs,BOOL stillHave))refresh failure:(void(^)(NSError *error))failure;
- (void)loadMore:(void(^)(NSMutableArray *objs,BOOL stillHave))loadMore failure:(void(^)(NSError *error))failure;
@end
