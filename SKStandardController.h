#import <Preferences/Preferences.h>
#import "SKTintedListController.h"
#import "SKListControllerProtocol.h"

// Assumes localization.

@interface SKStandardController : SKTintedListController<SKListControllerProtocol>
-(NSString*)postNotification;
-(NSString*)defaultsFileName;

-(NSString*) emailAddress;
-(NSString*) emailBody;
-(NSString*) emailSubject;

-(void) loadSettingsListController;
-(void) loadMakersListController;
-(void) showSupportDialog;
@end