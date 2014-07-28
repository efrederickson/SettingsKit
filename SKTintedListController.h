#import <Preferences/Preferences.h>
#import "SKListControllerProtocol.h"

@interface SKTintedListController : PSListController<SKListControllerProtocol>
- (id)localizedSpecifiersWithSpecifiers:(NSArray *)specifiers;
-(NSString*)localizedString:(NSString*)string;
@end