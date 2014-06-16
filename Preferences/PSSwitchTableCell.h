/*
 This header is not included in rpetrich's iphoneheaders.
 Why not? Who knows, probably because his headers are old.
 Anyway, here is the iOS 7 class PSSwitchTableCell, inherited by AppellancyTintedSwitchCell
 */

@class UIActivityIndicatorView;

@interface PSSwitchTableCell : PSControlTableCell  {
    UIActivityIndicatorView *_activityIndicator;
}

@property BOOL loading;


- (BOOL)loading;
- (void)setLoading:(BOOL)arg1;
- (id)controlValue;
- (id)newControl;
- (void)setCellEnabled:(BOOL)arg1;
- (void)refreshCellContentsWithSpecifier:(id)arg1;
- (id)initWithStyle:(int)arg1 reuseIdentifier:(id)arg2 specifier:(id)arg3;
- (void)reloadWithSpecifier:(id)arg1 animated:(BOOL)arg2;
- (BOOL)canReload;
- (void)dealloc;
- (void)prepareForReuse;
- (void)layoutSubviews;
- (void)setValue:(id)arg1;

@end