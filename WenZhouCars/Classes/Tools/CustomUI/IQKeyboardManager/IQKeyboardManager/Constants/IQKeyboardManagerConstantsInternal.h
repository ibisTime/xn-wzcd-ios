#ifndef IQKeyboardManagerConstantsInternal_h
#define IQKeyboardManagerConstantsInternal_h
typedef NS_ENUM(NSInteger, IQLayoutGuidePosition) {
    IQLayoutGuidePositionNone,
    IQLayoutGuidePositionTop,
    IQLayoutGuidePositionBottom,
};
#define IQ_IS_IOS10_OR_GREATER ([[NSProcessInfo processInfo] operatingSystemVersion].majorVersion >= 10)
#define IQ_IS_IOS11_OR_GREATER ([[NSProcessInfo processInfo] operatingSystemVersion].majorVersion >= 11)
#endif
