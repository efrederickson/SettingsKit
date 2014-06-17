#import <Preferences/Preferences.h>
#import "SKTintedListController.h"
#import "SKListControllerProtocol.h"
#import <MessageUI/MFMailComposeViewController.h>

// Assumes localization.

@interface SKStandardController : SKTintedListController<SKListControllerProtocol, MFMailComposeViewControllerDelegate>
-(NSString*) postNotification;
-(NSString*) defaultsFileName;
-(NSString*) enabledDescription;

-(NSString*) emailAddress;
-(NSString*) emailBody;
-(NSString*) emailSubject;

-(void) loadSettingsListController;
-(void) loadMakersListController;
-(void) showSupportDialog;
@end