#import "SKTintedControlCell.h"
#import "common.h"

@implementation SKTintedControlCell

- (void)layoutSubviews {
	[super layoutSubviews];
    if ([self respondsToSelector:@selector(tintColor)])
        self.textLabel.textColor = self.tintColor;
}

@end