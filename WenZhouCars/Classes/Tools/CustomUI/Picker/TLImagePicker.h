#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger, ImageType) {
    ImageTypeAll = 0,   
    ImageTypePhoto,     
    ImageTypeCamera,    
};
@interface TLImagePicker : NSObject<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic,copy)  void(^pickFinish)(NSDictionary *info);
@property (nonatomic, assign) ImageType imageType;
- (instancetype)initWithVC:(UIViewController *)ctrl;
@property (nonatomic,assign) BOOL allowsEditing;
- (void)picker;
- (void)videoPicker;
@end
