#import "CollectionCell1.h"
@interface CollectionCell1 () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
{
    UIButton *photoBtn;
    NSArray *array;
}
@end
@implementation CollectionCell1
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake((SCREEN_WIDTH - 50)/3  , (SCREEN_WIDTH - 50)/3);
        layout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
        float numberToRound;
        int result;
        numberToRound = (array.count + 1.0)/3.0;
        result = (int)ceilf(numberToRound);
        NSLog(@"roundf(%.2f) = %d", numberToRound, result);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(10, 5, SCREEN_WIDTH - 20, result * ((SCREEN_WIDTH - 50)/3 + 10)) collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor redColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView setBackgroundColor:[UIColor whiteColor]];
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        [self.contentView addSubview:self.collectionView];
        NSLog(@"%@",self.collectDataArray);
    }
    return self;
}
-(void)setCollectDataArray:(NSArray *)collectDataArray
{
    array = collectDataArray;
    float numberToRound;
    int result;
    numberToRound = (array.count + 0.0)/3.0;
    result = (int)ceilf(numberToRound);
    _collectionView.frame = CGRectMake(10, 5, SCREEN_WIDTH - 20, result * ((SCREEN_WIDTH - 50)/3 + 10));
    [self.collectionView reloadData];
}
#pragma mark -- Collection delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return array.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier: @"cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    UIImageView *image = [[UIImageView alloc]initWithFrame: CGRectMake(0, 0, (SCREEN_WIDTH - 50)/3, (SCREEN_WIDTH - 50)/3)];
    kViewBorderRadius(image, 5, 1, HGColor(230, 230, 230));
    if ([array[indexPath.row] hasPrefix:@"http"]) {
        [image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",array[indexPath.row]]]];
    }else
    {
        [image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[array[indexPath.row] convertImageUrl]]]];
    }
    [cell addSubview:image];
    return cell;
}
-(void)setSelectStr:(NSString *)selectStr
{
    _selectStr = selectStr;
}
#pragma mark -- Collection delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"点击了 %ld ", indexPath.row);
    NSMutableArray *muArray = [NSMutableArray array];
    for (int i = 0; i < array.count; i++) {
        [muArray addObject:[array[i] convertImageUrl]];
    }
    NSArray *seleteArray = muArray;
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    [ImageBrowserViewController show:window.rootViewController type:PhotoBroswerVCTypeModal index:indexPath.row imagesBlock:^NSArray *{
        return seleteArray;
    }];
}
-(void)selectButtonClick:(UIButton *)sender
{
    [_delegate UploadImagesBtn:sender str:_selectStr];
}
@end
