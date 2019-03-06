#import <UIKit/UIKit.h>
@protocol CustomCollectionDelegate <NSObject>
- (void)CustomCollection:(UICollectionView *)collectionView didSelectRowAtIndexPath:(NSIndexPath *)indexPath str:(NSString*)str;
-(void)UploadImagesBtn:(UIButton *)sender str:(NSString *)str;
@end
@interface CollectionViewCell : UITableViewCell
@property (nonatomic, assign) id<CustomCollectionDelegate> delegate;
@property (nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic,strong)NSArray *collectDataArray;
@property (nonatomic , copy)NSString *selectStr;
@end
