#import <UIKit/UIKit.h>
@protocol HW3DBannerViewDelegate <NSObject>
-(void)HW3DBannerViewClick;
@end
@interface HW3DBannerView : UIView<UIScrollViewDelegate>
@property (nonatomic, assign) id <HW3DBannerViewDelegate> delegate;
+(instancetype)initWithFrame:(CGRect)frame
                imageSpacing:(CGFloat)imageSpacing
                  imageWidth:(CGFloat)imageWidth;
+(instancetype)initWithFrame:(CGRect)frame
                imageSpacing:(CGFloat)imageSpacing
                  imageWidth:(CGFloat)imageWidth
                        data:(NSArray *)data;
@property (nonatomic, copy) void (^clickImageBlock)(NSInteger currentIndex);
@property(nonatomic, assign) CGFloat imageRadius;
@property (nonatomic,strong) NSArray *data;
@property (nonatomic, assign) CGFloat imageHeightPoor;
@property (nonatomic, assign) CGFloat initAlpha;
@property (nonatomic, assign) BOOL showPageControl;
@property(nonatomic,retain)UIColor *curPageControlColor;
@property(nonatomic,retain)UIColor *otherPageControlColor;
@property (nonatomic,strong) UIImage  *placeHolderImage;
@property(nonatomic) BOOL hidesForSinglePage;
@property (nonatomic, assign) CGFloat autoScrollTimeInterval;
@property (nonatomic,assign) BOOL autoScroll;
@end
#pragma mark - 使用方法
