#import <UIKit/UIKit.h>
#import "SurveyDetailsModel.h"
@protocol CreditReportingPersonInformationDelegate <NSObject>
-(void)CreditReportingPersonInformationButton:(UIButton *)sender;
@end
@interface CreditReportingPersonInformationCell : UITableViewCell
@property (nonatomic, assign) id <CreditReportingPersonInformationDelegate> Delegate;
@property (nonatomic , strong)SurveyDetailsModel *model;
@end
