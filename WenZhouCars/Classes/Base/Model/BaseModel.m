#import "BaseModel.h"
#import "SelectedListView.h"
#import "LEEAlert.h"
@implementation BaseModel
+ (instancetype)user{
    static BaseModel *user = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        user = [[BaseModel alloc] init];
    });
    return user;
}
- (BOOL)isLogin {
    NSString *userId = [USERDEFAULTS objectForKey:USER_ID];
    NSString *token = [USERDEFAULTS objectForKey:TOKEN_ID];
    NSLog(@"%@===%@",userId,token);
    if ([BaseModel isBlankString:userId] == NO && [BaseModel isBlankString:token] == NO) {
        return YES;
    } else {
        return NO;
    }
}
+ (BOOL) isBlankString:(NSString *)string {
    if (string == nil || string == NULL || [string isEqualToString:@""])
    {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]])
    {
        return YES;
    }
    return NO;
}
+ (NSString*)convertNull:(id)object{
    if ([object isEqual:[NSNull null]]) {
        return @"";
    }
    else if ([object isKindOfClass:[NSNull class]])
    {
        return @"";
    }
    else if ([object isEqualToString:@"(null)"])
    {
        return @"";
    }
    else if (object==nil){
        return @"";
    }
    return object;
}
- (BOOL) deptNumInputShouldNumber:(NSString *)str
{
    if (str.length == 0) {
        return NO;
    }
    NSString *regex = @"[0-9]*";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    if ([pred evaluateWithObject:str]) {
        return YES;
    }
    return NO;
}
-(NSString *)note:(NSString *)curNodeCode
{
    NSString *name;
    NSArray *array = [USERDEFAULTS objectForKey:NODE];
    for (int i = 0; i < array.count; i ++) {
        if ([array[i][@"code"] isEqualToString:curNodeCode]) {
            name = array[i][@"name"];
        }
    }
    return name;
}
-(void)ReturnsParentKeyAnArray:(NSString *)parentKey
{
    NSMutableArray *dataArray = [NSMutableArray array];
    NSArray *array = [USERDEFAULTS objectForKey:BOUNCEDDATA];
    for (int i = 0; i < array.count; i ++) {
        if ([array[i][@"parentKey"] isEqualToString:parentKey]) {
            [dataArray addObject:array[i]];
        }
    }
    NSMutableArray *array1 = [NSMutableArray array];
    for (int i = 0; i < dataArray.count; i ++) {
        [array1 addObject:dataArray[i]];
    }
    [self CustomBouncedView:array1 setState:@""];
}
-(void)CustomBouncedView:(NSMutableArray *)nameArray setState:(NSString *)state
{
    NSMutableArray *dvalueArray = [NSMutableArray array];
    if ([state isEqualToString:@"100"]) {
        dvalueArray = nameArray;
    }else
    {
        for (int i = 0; i < nameArray.count ; i ++) {
            [dvalueArray addObject:nameArray[i][@"dvalue"]];
        }
    }
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0;  i < dvalueArray.count; i ++) {
        [array addObject:[[SelectedListModel alloc] initWithSid:i Title:[NSString stringWithFormat:@"%@",dvalueArray[i]]]];
    }
    SelectedListView *view = [[SelectedListView alloc] initWithFrame:CGRectMake(0, 0, 280, 0) style:UITableViewStylePlain];
    view.isSingle = YES;
    view.array = array;
    view.selectedBlock = ^(NSArray<SelectedListModel *> *array) {
        [LEEAlert closeWithCompletionBlock:^{
            NSLog(@"选中的%@" , array);
            SelectedListModel *model = array[0];
            [self.ModelDelegate TheReturnValueStr:model.title selectDic:nameArray[model.sid] selectSid:model.sid];
        }];
    };
    [LEEAlert alert].config
    .LeeTitle(@"选择")
    .LeeItemInsets(UIEdgeInsetsMake(20, 0, 20, 0))
    .LeeCustomView(view)
    .LeeItemInsets(UIEdgeInsetsMake(0, 0, 0, 0))
    .LeeHeaderInsets(UIEdgeInsetsMake(10, 0, 0, 0))
    .LeeClickBackgroundClose(YES)
    .LeeShow();
}
-(NSString *)setParentKey:(NSString *)parentKey setDkey:(NSString *)dkey
{
    if ([BaseModel isBlankString:dkey] == YES) {
        return @"";
    }
    NSString *dvalue;
    NSMutableArray *dataArray = [NSMutableArray array];
    NSArray *array = [USERDEFAULTS objectForKey:BOUNCEDDATA];
    for (int i = 0; i < array.count; i ++) {
        if ([array[i][@"parentKey"] isEqualToString:parentKey]) {
            [dataArray addObject:array[i]];
        }
    }
    for (int i = 0; i < dataArray.count; i ++) {
        if ([dataArray[i][@"dkey"] isEqualToString:dkey]) {
            dvalue = dataArray[i][@"dvalue"];
        }
    }
    return dvalue;
}
@end
