#import <UIKit/UIKit.h>
#import "SurveyModel.h"
#import "AccessSingleModel.h"
@interface ListCell : UITableViewCell
@property (nonatomic , strong)UIButton *button;
@property (nonatomic , strong)UILabel *codeLabel;
@property (nonatomic , strong)UILabel *stateLabel;
@property (nonatomic , strong)UILabel *nameLabel;
@property (nonatomic , strong)UILabel *InformationLabel;
@property (nonatomic , strong)SurveyModel *surveyModel;
@property (nonatomic , strong)AccessSingleModel *accessSingleModel;
@end
