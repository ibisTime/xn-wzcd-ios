#import <UIKit/UIKit.h>
#import "SurveyDetailsModel.h"
@protocol SelectADPeopleDelegate <NSObject>
-(void)SelectADPeopleTableViewCellButton:(UIButton *)sender;
-(void)ChooseButton:(UIButton *)sender;
@end
@interface SelectADPeopleTableViewCell : UITableViewCell
@property (nonatomic, assign) id <SelectADPeopleDelegate> Delegate;
@property (nonatomic , strong)SurveyDetailsModel *model;
@end
