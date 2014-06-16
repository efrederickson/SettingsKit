#import <Preferences/Preferences.h>
@interface SKSpecifierParser : NSObject
+(PSCellType)PSCellTypeFromString:(NSString*)str;
+(NSArray*)specifiersFromArray:(NSArray*)array forTarget:(PSListController*)target;
@end