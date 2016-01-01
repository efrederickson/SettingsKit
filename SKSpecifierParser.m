#import <Preferences/Preferences.h>
#import "SKSpecifierParser.h"
#import <objc/runtime.h>
#import "common.h"

@interface PSListController (Maybe)
-(UIColor*)iconColor;
-(UIColor*)tintColor;
@end

@implementation SKSpecifierParser
+(PSCellType)PSCellTypeFromString:(NSString*)str
{
    if ([str isEqual:@"PSGroupCell"])
        return PSGroupCell;
    if ([str isEqual:@"PSLinkCell"])
        return PSLinkCell;
    if ([str isEqual:@"PSLinkListCell"])
        return PSLinkListCell;
    if ([str isEqual:@"PSListItemCell"])
        return PSListItemCell;
    if ([str isEqual:@"PSTitleValueCell"])
        return PSTitleValueCell;
    if ([str isEqual:@"PSSliderCell"])
        return PSSliderCell;
    if ([str isEqual:@"PSSwitchCell"])
        return PSSwitchCell;
    if ([str isEqual:@"PSStaticTextCell"])
        return PSStaticTextCell;
    if ([str isEqual:@"PSEditTextCell"])
        return PSEditTextCell;
    if ([str isEqual:@"PSSegmentCell"])
        return PSSegmentCell;
    if ([str isEqual:@"PSGiantIconCell"])
        return PSGiantIconCell;
    if ([str isEqual:@"PSGiantCell"])
        return PSGiantCell;
    if ([str isEqual:@"PSSecureEditTextCell"])
        return PSSecureEditTextCell;
    if ([str isEqual:@"PSButtonCell"])
        return PSButtonCell;
    if ([str isEqual:@"PSEditTextViewCell"])
        return PSEditTextViewCell;
    
    return PSGroupCell;
}

+(NSArray*)specifiersFromArray:(NSArray*)array forTarget:(PSListController*)target
{
    NSMutableArray *specifiers = [NSMutableArray array];
    for (NSDictionary *dict in array)
    {
        PSCellType cellType = [SKSpecifierParser PSCellTypeFromString:dict[@"cell"]];
        PSSpecifier *spec = nil;
        if (cellType == PSGroupCell)
        {
            if (dict[@"label"] != nil)
            {
                spec = [PSSpecifier groupSpecifierWithName:dict[@"label"]];
                [spec setProperty:dict[@"label"] forKey:@"label"];
            }
            else
                spec = [PSSpecifier emptyGroupSpecifier];
            
            if (dict[@"footerText"] != nil)
                [spec setProperty:dict[@"footerText"] forKey:@"footerText"];
            
            [spec setProperty:@"PSGroupCell" forKey:@"cell"];
        }
        else
        {
            NSString *label = dict[@"label"] == nil ? @"" : dict[@"label"];
            Class detail = dict[@"detail"] == nil ? nil : NSClassFromString(dict[@"detail"]);
            Class edit = dict[@"pane"] == nil ? nil : NSClassFromString(dict[@"pane"]);
            SEL set = dict[@"set"] == nil ? @selector(setPreferenceValue:specifier:) : NSSelectorFromString(dict[@"set"]);
            SEL get = dict[@"get"] == nil ? @selector(readPreferenceValue:) : NSSelectorFromString(dict[@"get"]);
            SEL action = dict[@"action"] == nil ? nil : NSSelectorFromString(dict[@"action"]);
            spec = [PSSpecifier preferenceSpecifierNamed:label target:target set:set get:get detail:detail cell:cellType edit:edit];
            spec->action = action;
            
            NSArray *validTitles = dict[@"validTitles"];
            NSArray *validValues = dict[@"validValues"];
            if (validTitles && validValues)
                [spec setValues:validValues titles:validTitles];
            
            for (NSString *key in dict)
            {
                if ([key isEqual:@"cellClass"])
                {
                    NSString *s = dict[key];
                    [spec setProperty:NSClassFromString(s) forKey:key];
                }
                else if ([key isEqual:@"validValues"] || [key isEqual:@"validTitles"])
                    continue;
                else
                    [spec setProperty:dict[key] forKey:key];
            }
        }
        
        
        if (dict[@"icon"])
        {
            /*id value = dict[@"icon"];
            UIImage *image = nil;
            if ([value isKindOfClass:[UIImage class]] == NO)
            {
                UIImage *image = [UIImage imageNamed:value inBundle:[NSBundle bundleForClass:target.class]];
                if (image == nil)
                    image = [UIImage imageNamed:value inBundle:[NSBundle bundleForClass:self.class]];
            }
            else
                image = value;

            if ([target respondsToSelector:@selector(iconColor)])
                image = [image changeImageColor:target.iconColor];
            else if ([target respondsToSelector:@selector(tintColor)])
                image = [image changeImageColor:target.tintColor]; 

            [spec setProperty:image forKey:@"iconImage"];*/

            UIImage *image = [dict[@"icon"] isKindOfClass:[UIImage class]] ? dict[@"icon"] : nil;
            if (image == nil)
                image = [UIImage imageNamed:dict[@"icon"] inBundle:[NSBundle bundleForClass:target.class]];
            if (image == nil)
                image = [UIImage imageNamed:dict[@"icon"] inBundle:[NSBundle bundleForClass:self.class]];
            
            if ([target respondsToSelector:@selector(iconColor)])
                image = [image changeImageColor:target.iconColor];
            else if ([target respondsToSelector:@selector(tintColor)])
                image = [image changeImageColor:target.tintColor];
            
            [spec setProperty:image forKey:@"iconImage"];
        }
        if (dict[@"leftImage"])
        {
            UIImage *image = [UIImage imageNamed:dict[@"leftImage"] inBundle:[NSBundle bundleForClass:target.class]];
            if (image == nil)
                image = [UIImage imageNamed:dict[@"leftImage"] inBundle:[NSBundle bundleForClass:self.class]];
            
            [spec setProperty:image forKey:@"leftImage"];
        }
        if (dict[@"rightImage"])
        {
            UIImage *image = [UIImage imageNamed:dict[@"rightImage"] inBundle:[NSBundle bundleForClass:target.class]];
            if (image == nil)
                image = [UIImage imageNamed:dict[@"rightImage"] inBundle:[NSBundle bundleForClass:self.class]];
            
            [spec setProperty:image forKey:@"rightImage"];
        }
        
        if (dict[@"id"])
            [spec setProperty:dict[@"id"] forKey:@"id"];
        else
            [spec setProperty:dict[@"label"] forKey:@"id"];
        spec.target = target;
        
        [specifiers addObject:spec];
    }
    return specifiers;
}
@end