#import <Preferences/Preferences.h>
#import "common.h"

@interface SKSharedHelper : NSObject
+(void) openTwitter:(NSString*)userName;
+(void) openGitHub:(NSString*)userName;
+(void) openEmail:(NSString*)to subject:(NSString*)subject;
@end