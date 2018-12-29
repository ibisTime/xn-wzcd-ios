//
//  CollectionCell1.h
//  WenZhouCarLansB
//
//  Created by QinBao Zheng on 2018/9/11.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CustomCollectionDelegate <NSObject>

- (void)CustomCollection:(UICollectionView *)collectionView didSelectRowAtIndexPath:(NSIndexPath *)indexPath str:(NSString*)str;

-(void)UploadImagesBtn:(UIButton *)sender str:(NSString *)str;

@end

@interface CollectionCell1 : UITableViewCell

@property (nonatomic, assign) id<CustomCollectionDelegate> delegate;
@property (nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic,strong)NSArray *collectDataArray;
@property (nonatomic , copy)NSString *selectStr;

@end
