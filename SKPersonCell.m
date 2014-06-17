#import <Preferences/Preferences.h>
#import "common.h"
#import "SKPersonCell.h"

@implementation SKPersonCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
	if((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])){
        UIImage *bkIm = [UIImage imageNamed:self.imageName inBundle:[NSBundle bundleForClass:self.class]];
        _background = [[UIImageView alloc] initWithImage:bkIm];
        _background.frame = CGRectMake(9, 18, 65, 65);
        [self addSubview:_background];
        
        CGRect frame = [self frame];
        
        label = [[UILabel alloc] initWithFrame:CGRectMake(frame.origin.x + 84, frame.origin.y + 18, frame.size.width, frame.size.height)];
        [label setText:self.name];
        [label setBackgroundColor:[UIColor clearColor]];
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
            [label setFont:[UIFont fontWithName:@"Helvetica Light" size:30]];
        else
            [label setFont:[UIFont fontWithName:@"Helvetica Light" size:21]];
        [self addSubview:label];
        
        label2 = [[UILabel alloc] initWithFrame:CGRectMake(frame.origin.x + 84, frame.origin.y + 42, frame.size.width, frame.size.height)];
        [label2 setText:self.personDescription];
        [label2 setBackgroundColor:[UIColor clearColor]];
        [label2 setFont:[UIFont fontWithName:@"Helvetica Light" size:15]];
        [self addSubview:label2];
    }
    return self;
}

-(NSString*)personDescription { return @""; }
-(NSString*)imageName { return @""; }
-(NSString*)name { return @""; }
-(NSString*)twitterHandle { return @""; }

-(void)updateImage
{
    UIImage *bkIm = [UIImage imageNamed:self.imageName inBundle:[NSBundle bundleForClass:self.class]];
    _background.image = bkIm;
}

@end