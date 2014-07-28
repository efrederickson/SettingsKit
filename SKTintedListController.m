#import <Social/SLComposeViewController.h>
#import <Social/SLServiceTypes.h>
#import "SKTintedListController.h"
#import "common.h"
#import "SKSpecifierParser.h"

@implementation SKTintedListController
- (id)specifiers {
	if(_specifiers == nil)
    {
        if ([self respondsToSelector:@selector(customSpecifiers)])
        {
            _specifiers = [SKSpecifierParser specifiersFromArray:self.customSpecifiers forTarget:self];
            if ([self respondsToSelector:@selector(customTitle)])
                self.title = self.customTitle;
        }
        else if ([self respondsToSelector:@selector(plistName)])
            _specifiers = [self loadSpecifiersFromPlistName:self.plistName target:self];
        else
            @throw [[NSException alloc] init];
        
        [self localizedSpecifiersWithSpecifiers:_specifiers];
    }
	return _specifiers;
}

- (id)navigationTitle {
	return [[self bundle] localizedStringForKey:[super title] value:[super title] table:nil];
}

- (id)localizedSpecifiersWithSpecifiers:(NSArray *)specifiers {
    NSLog(@"localizedSpecifiersWithSpecifiers");
	for(PSSpecifier *curSpec in specifiers) {
		NSString *name = [curSpec name];
		if(name) {
			[curSpec setName:[[self bundle] localizedStringForKey:name value:name table:nil]];
		}
		NSString *footerText = [curSpec propertyForKey:@"footerText"];
		if(footerText)
        [curSpec setProperty:[[self bundle] localizedStringForKey:footerText value:footerText table:nil] forKey:@"footerText"];
		id titleDict = [curSpec titleDictionary];
		if(titleDict) {
			NSMutableDictionary *newTitles = [[NSMutableDictionary alloc] init];
			for(NSString *key in titleDict) {
				NSString *value = [titleDict objectForKey:key];
				[newTitles setObject:[[self bundle] localizedStringForKey:value value:value table:nil] forKey: key];
			}
			[curSpec setTitleDictionary:newTitles];
		}
	}
	return specifiers;
}

-(void)loadView
{
    [super loadView];
    
    if (self.showHeartImage)
    {
        UIImage* image = [UIImage imageNamed:@"heart.png" inBundle:[NSBundle bundleForClass:SKTintedListController.class]];
        if ([self respondsToSelector:@selector(heartImageColor)])
            image = [image changeImageColor:self.heartImageColor];
        CGRect frameimg = CGRectMake(0, 0, image.size.width, image.size.height);
        UIButton *someButton = [[UIButton alloc] initWithFrame:frameimg];
        [someButton setBackgroundImage:image forState:UIControlStateNormal];
        
        [someButton addTarget:self action:@selector(heartWasTouched) forControlEvents:UIControlEventTouchUpInside];
        [someButton setShowsTouchWhenHighlighted:YES];
        UIBarButtonItem *heartButton = [[UIBarButtonItem alloc] initWithCustomView:someButton];
    
        if ([self respondsToSelector:@selector(shiftHeartImage)] && self.shiftHeartImage)
        {
            UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
            negativeSpacer.width = -16;
            [self.navigationItem setRightBarButtonItems:[NSArray arrayWithObjects:negativeSpacer, heartButton, nil] animated:NO];
        }
        else
            ((UINavigationItem*)self.navigationItem).rightBarButtonItem = heartButton;
    }
    
    [self setupHeader];
    
    BOOL tintSwitches_ = YES;
    
    if ([self respondsToSelector:@selector(tintSwitches)])
        tintSwitches_ = [self tintSwitches];
    
    if (tintSwitches_)
    {
        if ([self respondsToSelector:@selector(switchOnTintColor)])
            [UISwitch appearanceWhenContainedIn:self.class, nil].onTintColor = self.switchOnTintColor;
        else
            if ([self respondsToSelector:@selector(tintColor)])
                [UISwitch appearanceWhenContainedIn:self.class, nil].onTintColor = self.tintColor;
    
        if ([self respondsToSelector:@selector(switchTintColor)])
            [UISwitch appearanceWhenContainedIn:self.class, nil].tintColor = self.switchTintColor;
        else
            if ([self respondsToSelector:@selector(tintColor)])
                [UISwitch appearanceWhenContainedIn:self.class, nil].tintColor = self.tintColor;
    }
}

-(void) heartWasTouched
{
    SLComposeViewController *composeController = [SLComposeViewController
                                                  composeViewControllerForServiceType:SLServiceTypeTwitter];
    
    if ([self respondsToSelector:@selector(shareMessage)])
        [composeController setInitialText:self.shareMessage];
    else
        [composeController setInitialText:@"Someone needs to change their [SKTintedListController shareMessage]!"];
    
    [self presentViewController:composeController
                       animated:YES completion:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    if ([self respondsToSelector:@selector(tintColor)])
        self.view.tintColor = self.tintColor;
    if ([self respondsToSelector:@selector(navigationTintColor)])
        self.navigationController.navigationBar.tintColor = self.navigationTintColor;
    else
        if ([self respondsToSelector:@selector(tintColor)])
            self.navigationController.navigationBar.tintColor = self.tintColor;
    
    BOOL tintNavText = YES;
    if ([self respondsToSelector:@selector(tintNavigationTitleText)])
        tintNavText = self.tintNavigationTitleText;
    
    if (tintNavText)
    {
        if ([self respondsToSelector:@selector(navigationTitleTintColor)])
            self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: self.   navigationTitleTintColor };
        else
            if ([self respondsToSelector:@selector(tintColor)])
                self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: self.tintColor };
    }
    
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
    
    self.view.tintColor = nil;
    self.navigationController.navigationBar.tintColor = nil;
    self.navigationController.navigationBar.titleTextAttributes = @{};
}

-(void) setupHeader
{
    UIView *header = nil;
    
    if ([self respondsToSelector:@selector(headerImage)])
    {
        header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 100)];
        
        UIImage *headerImage = [UIImage imageNamed:self.headerImage inBundle:[NSBundle bundleForClass:self.class]];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:headerImage];
        imageView.frame = CGRectMake(imageView.frame.origin.x, 10, imageView.frame.size.width, headerImage.size.height);
        
        [header addSubview:imageView];
    }
    
    if ([self respondsToSelector:@selector(headerText)])
    {
        header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 60)];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 17, header.frame.size.width, header.frame.size.height - 10)];
        label.text = self.headerText;
        label.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:48];
        label.backgroundColor = [UIColor clearColor];
        if ([self respondsToSelector:@selector(tintColor)])
            label.textColor = self.tintColor;
        if ([self respondsToSelector:@selector(headerColor)])
            label.textColor = self.headerColor;
        
        label.textAlignment = NSTextAlignmentCenter;
        
        if ([self respondsToSelector:@selector(headerSubText)])
        {
            header.frame = CGRectMake(header.frame.origin.x, header.frame.origin.y, header.frame.size.width, header.frame.size.height + 35);
            
            label.frame = CGRectMake(label.frame.origin.x, 10, label.frame.size.width, label.frame.size.height - 5);
            [header addSubview:label];
            
            UILabel *subText = [[UILabel alloc] initWithFrame:CGRectMake(header.frame.origin.x, label.frame.origin.y + label.frame.size.height, header.frame.size.width, 20)];
            subText.text = self.headerSubText;
            subText.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:16];
            subText.backgroundColor = [UIColor clearColor];
            if ([self respondsToSelector:@selector(tintColor)])
                subText.textColor = self.tintColor;
            if ([self respondsToSelector:@selector(headerColor)])
                subText.textColor = self.headerColor;
            
            subText.textAlignment = NSTextAlignmentCenter;
            
            [header addSubview:subText];
        }
        else
        {
            label.frame = CGRectMake(label.frame.origin.x, 5, label.frame.size.width, label.frame.size.height);
            [header addSubview:label];
        }
    }
    
    if ([self respondsToSelector:@selector(headerView)])
    {
        header = self.headerView;
    }
    
    if (header)
    {
        header.backgroundColor = [UIColor clearColor];
        [self.table setTableHeaderView:header];
    }
}

-(BOOL) showHeartImage { return YES; }
-(BOOL) shiftHeartImage { return YES; }
-(UIColor*) heartImageColor
{
    if ([self respondsToSelector:@selector(navigationTintColor)])
        return self.navigationTintColor;
    else if ([self respondsToSelector:@selector(tintColor)])
        return self.tintColor;
    else
        return SYSTEM_TINT;
}

@end