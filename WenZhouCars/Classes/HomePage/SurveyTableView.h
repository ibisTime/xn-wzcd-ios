#import "TLTableView.h"
#import "SurveyModel.h"
@protocol SurveyDelegate <NSObject>
-(void)selectButtonClick:(NSInteger)index;
@end
@interface SurveyTableView : TLTableView
@property (nonatomic, assign) id <SurveyDelegate> selectDelegate;
@property (nonatomic , strong)NSMutableArray <SurveyModel *>*model;
@end
