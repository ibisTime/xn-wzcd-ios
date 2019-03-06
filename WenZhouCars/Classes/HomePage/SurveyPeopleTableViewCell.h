#import <UIKit/UIKit.h>
@protocol SurveyPeopleDelegate <NSObject>
-(void)SurveyPeopleSelectButton:(UIButton *)sender;
@end
@interface SurveyPeopleTableViewCell : UITableViewCell
@property (nonatomic, assign) id <SurveyPeopleDelegate> delegate;
@property (nonatomic , strong)NSArray *GPSArray;
@property (nonatomic , strong)NSArray *peopleArray;
@property (nonatomic , copy)NSString *name;
@property (nonatomic , copy)NSString *btnStr;
@property (nonatomic , strong)UILabel *nameLbl;
@property (nonatomic , strong)UIButton *photoBtn;
@end
