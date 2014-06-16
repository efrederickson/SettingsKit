@protocol SKListControllerProtocol

-(BOOL) showHeartImage;

@optional

-(NSString*)plistName;
-(NSArray*)customSpecifiers;
-(NSString*)customTitle;

-(BOOL) shiftHeartImage;
-(NSString*) shareMessage;

-(BOOL) tintNavigationTitleText;
-(BOOL) tintSwitches;

-(UIColor*) tintColor;
-(UIColor*) navigationTintColor;
-(UIColor*) navigationTitleTintColor;
-(UIColor*) switchTintColor;
-(UIColor*) switchOnTintColor;

-(NSString*) headerImage;
-(NSString*) headerText;
-(NSString*) headerSubText;
-(UIView*) headerView;
@end