#import "TLTableView.h"
@protocol SelectButtonDelegate <NSObject>
-(void)selectButtonClick:(UIButton *)sender;
@end
@interface ADPeopleTableView : TLTableView
@property (nonatomic, assign) id <SelectButtonDelegate> ButtonDelegate;
@property (nonatomic , copy)NSString *idNoFront;
@property (nonatomic , copy)NSString *idNoReverse;
@property (nonatomic , strong)NSDictionary *dataDic;
@property (nonatomic , assign)NSInteger selectRow;
@property (nonatomic , copy)NSString *CerStr;
@property (nonatomic , copy)NSString *FaceStr;
@property (nonatomic , copy)NSString *loanRole;
@property (nonatomic , copy)NSString *relation;
@end
