//
//  SWPSListController.h
//  acapellaprefs
//
//  Created by Pat Sluth on 2015-05-02.
//
//

#import <Preferences/Preferences.h>

@class SWPrefs, SWPSListControllerHeaderView;

static const CGFloat kStretchTableHeaderHeight = 150;





@interface SWPSListController : PSListController <UIScrollViewDelegate>

@property (strong, nonatomic) SWPrefs *prefs;
@property (strong, nonatomic, readonly) SWPSListControllerHeaderView *header;

- (void)showRespringButton:(BOOL)show;
- (void)resetAllSettings:(PSSpecifier *)specifier;

@end




