#import <Preferences/Preferences.h>

@interface PSListController (SettingsKit)
-(UIView*)view;
-(UINavigationController*)navigationController;
-(void)viewWillAppear:(BOOL)animated;
-(void)viewWillDisappear:(BOOL)animated;

- (void)presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion;
- (void)dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion;
-(UINavigationController*)navigationController;

-(void)loadView;
@end

@interface UIImage (SettingsKit)
+ (UIImage *)imageNamed:(NSString *)named inBundle:(NSBundle *)bundle;
@end

@interface PSTableCell (SettingsKit)
@property (nonatomic) UIView *backgroundView;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier specifier:(PSSpecifier *)specifier;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

-(UILabel*)textLabel;
@end

@interface UIPreferencesTable : UITableView // wat
@end