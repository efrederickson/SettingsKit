#import "SKTintedCell.h"
#import "common.h"

@implementation SKTintedCell

- (void)layoutSubviews {
	[super layoutSubviews];
    if ([self respondsToSelector:@selector(tintColor)])
        self.textLabel.textColor = self.tintColor;
}

@end