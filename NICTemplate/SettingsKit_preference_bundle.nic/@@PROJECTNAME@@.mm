#import <Preferences/Preferences.h>
#import <SettingsKit/SKListControllerProtocol.h>
#import <SettingsKit/SKTintedListController.h>

@interface @@PROJECTNAME@@ListController: SKTintedListController<SKListControllerProtocol>
@end

@implementation @@PROJECTNAME@@ListController

/*
 Want a tint color?
 -(UIColor*) tintColor { return [UIColor orangeColor]; }
 -(BOOL) tintNavigationTitleText { return NO; }
 */


-(NSString*) headerText { return @"@@PROJECTNAME@@"; }

-(NSString*) customTitle { return @"@@PROJECTNAME@@"; }
-(NSArray*) customSpecifiers
{
    return @[
             @{
                 @"cell": @"PSGroupCell",
                 @"label": @"@@PROJECTNAME@@ Settings"
                 },
             @{
                 @"cell": @"PSSwitchCell",
                 @"default": @YES,
                 @"defaults": @"@@PROJECTNAME@@",
                 @"key": @"enabled",
                 @"label": @"Enabled",
                 @"PostNotification": @"@@PROJECTNAME@@/reloadSettings",
                 @"cellClass": @"SKTintedSwitchCell"
                 }
             ];
}
@end
