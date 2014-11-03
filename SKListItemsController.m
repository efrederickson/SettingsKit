#import "SKListItemsController.h"
#import "common.h"

@implementation SKListItemsController
- (void)viewWillAppear:(BOOL)animated {
    if ([self respondsToSelector:@selector(tintColor)])
    {
        self.view.tintColor = self.tintColor;
        [[UIApplication sharedApplication] keyWindow].tintColor = self.tintColor;
    }

    if ([self respondsToSelector:@selector(navigationTintColor)])
    {
        self.navigationController.navigationBar.tintColor = self.navigationTintColor;
        [[UIApplication sharedApplication] keyWindow].tintColor = self.navigationTintColor;
    }
    else
    {
        if ([self respondsToSelector:@selector(tintColor)])
        {
            self.navigationController.navigationBar.tintColor = self.tintColor;
        }
    }
    
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
    

    [[UIApplication sharedApplication] keyWindow].tintColor = nil;
    self.view.tintColor = nil;
    self.navigationController.navigationBar.tintColor = nil;
    self.navigationController.navigationBar.titleTextAttributes = @{};
}
@end