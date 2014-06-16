#import "SKTintedSwitchCell.h"
#import "common.h"

@implementation SKTintedSwitchCell

- (void)layoutSubviews {
	[super layoutSubviews];
    
    if ([self respondsToSelector:@selector(tintColor)])
        ((UILabel*)self.titleTextLabel).textColor = self.tintColor;
}

@end