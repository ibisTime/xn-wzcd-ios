#ifndef AppMacro_h
#define AppMacro_h
#pragma mark - ToolsMacros
#define PASS_NULL_TO_NIL(instance) (([instance isKindOfClass:[NSNull class]]) ? nil : instance)
#define STRING_NIL_NULL(x) if(x == nil || [x isKindOfClass:[NSNull class]]){x = @"";}
#define ARRAY_NIL_NULL(x) \
if(x == nil || [x isKindOfClass:[NSNull class] ]) \
{x = @[];}
#ifdef DEBUG
#define NSLog(...) printf("%s\n\n", [[NSString stringWithFormat:__VA_ARGS__] UTF8String]);
#else
#define NSLog(...)
#endif
#define ArtDEPRECATED(instead) NS_DEPRECATED(2_0, 2_0, 2_0, 2_0, instead)
#pragma mark - HttpMacros
#endif 
