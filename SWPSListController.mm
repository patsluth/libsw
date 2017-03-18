//
//  SWPSListController.m
//  libsw
//
//  Created by Pat Sluth on 2015-05-02.
//
//

#import "SWPSListController.h"
#import "SWPSListControllerHeaderView.h"
#import "SWPSTwitterCell.h"

#import "Sluthware/Sluthware.h"
#import "Sluthware/SWPrefs.h"
#import <libpackageinfo/libpackageinfo.h>

#import <Social/Social.h>

#include <spawn.h>
#include <signal.h>






@interface SWPSListController()
{
}

@property (readwrite, strong, nonatomic) SWPSListControllerHeaderView *header;
@property (strong, nonatomic) PIDebianPackage *packageDEB;

- (void)updateHeader;

@end





@implementation SWPSListController

#pragma mark - Init

- (void)loadView
{
    [super loadView];
    
    NSBundle *bundle = [NSBundle bundleWithPath:@"/System/Library/PrivateFrameworks/FuseUI.framework"];
    UIImage *heartImage = [UIImage imageNamed:@"NowPlayingLoveHateControlLoved" inBundle:bundle compatibleWithTraitCollection:nil];
    UIBarButtonItem *item;
    
    if (heartImage) {
        
        item = [[UIBarButtonItem alloc] initWithImage:heartImage
                                                style:UIBarButtonItemStylePlain
                                               target:self
                                               action:@selector(shareButtonAction)];
        
    } else {
        
        item = [[UIBarButtonItem alloc] initWithTitle:@"Share"
                                                style:UIBarButtonItemStylePlain
                                               target:self
                                               action:@selector(shareButtonAction)];
        
    }
    
    self.navigationItem.rightBarButtonItem = item;
    
}

- (id)specifiers
{
    if(!_specifiers) {
        _specifiers = [self loadSpecifiersFromPlistName:NSStringFromClass([self class]) target:self];
    }
    
    return _specifiers;
}

- (NSArray *)loadSpecifiersFromPlistName:(NSString *)plistName target:(id)target
{
    NSArray *specifiers = [super loadSpecifiersFromPlistName:plistName target:target];
    return specifiers;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // Hide because we have beutiful headers to show
    self.navigationItem.title = @"";
    
    self.table.showsHorizontalScrollIndicator = NO;
    self.table.showsVerticalScrollIndicator = NO;
    
    if (!self.header) {
        
        UIImage *bannerBG = [UIImage imageWithContentsOfFile:[self.bundle pathForResource:@"Prefs_Banner_Background" ofType:@"png"]];
        UIImage *bannerIcon = [UIImage imageWithContentsOfFile:[self.bundle pathForResource:@"Prefs_Banner_Icon" ofType:@"png"]];
        
        self.header = [[SWPSListControllerHeaderView alloc] initWithImage:bannerBG];
        self.header.icon.image = bannerIcon;
        self.header.label.text = self.title;
        
        self.table.tableHeaderView = nil;
        self.table.contentInset = UIEdgeInsetsMake(kStretchTableHeaderHeight, 0, 0, 0);
        
        //if (self.table.contentOffset.y == 0.0) { // Only modify if user hasn't scrolled, so when returning to this VC the offset persists
            self.table.contentOffset = CGPointMake(0, -kStretchTableHeaderHeight);
        //}
        
        [self.table addSubview:self.header];
        
    }
	
	
    //libpackageinfo
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0ul);
    dispatch_async(queue, ^{
        
        self.packageDEB = [PIDebianPackage packageForFile:self.bundle.bundlePath];
        
        dispatch_sync(dispatch_get_main_queue(), ^{
			
			PSSpecifier *spec = [self specifierForID:@"Version"];
			[self reloadSpecifier:spec animated:YES];
			
        });
    });
	
	
	[self reloadSpecifiers];
    
}

- (void)viewDidDisappear:(BOOL)animated
{
    if (self.header) {
        [self.header removeFromSuperview];
        self.header = nil;
    }
    
    self.packageDEB = nil;
    
    [super viewDidDisappear:animated];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    [self updateHeader];
}

#pragma mark - Header

- (void)updateHeader
{
    CGRect headerRect = CGRectMake(0, -kStretchTableHeaderHeight, CGRectGetWidth(self.table.bounds), kStretchTableHeaderHeight);
    
    if (self.table.contentOffset.y < -kStretchTableHeaderHeight) {
        headerRect.origin.y = self.table.contentOffset.y;
        headerRect.size.height = -self.table.contentOffset.y;
    }
    
    self.header.frame = headerRect;
}

#pragma mark - UIScrollView

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self updateHeader];
}

#pragma mark - libpackageinfo

- (id)getVersionNumberForSpecifier:(PSSpecifier *)specifier
{
    if (self.packageDEB) {
        return self.packageDEB.version;
    }
    
    return @"...";
}

#pragma mark - Share

- (void)shareButtonAction
{
    NSString *message = [NSString stringWithFormat:@"Check out this awesome tweak #%@ by %@", self.packageDEB.name, @"@patsluth"];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://cydia.saurik.com/package/%@/", self.packageDEB.storeIdentifier]];
    
    SLComposeViewController *composeController = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
    [composeController setInitialText:message];
    [composeController addURL:url];
    
    [self presentViewController:composeController animated:YES completion:nil];
}

#pragma mark - Respring

- (void)showRespringButton:(BOOL)show
{
    if (show) {
        if (![self specifierForID:@"Respring"]) {
            PSSpecifier *respringGroup = [PSSpecifier preferenceSpecifierNamed:@""
                                                                        target:nil
                                                                           set:nil
                                                                           get:nil
                                                                        detail:nil
                                                                          cell:PSGroupCell
                                                                          edit:nil];
            PSSpecifier *respring = [PSSpecifier preferenceSpecifierNamed:@"Respring"
                                                                   target:self
                                                                      set:nil
                                                                      get:nil
                                                                   detail:nil
                                                                     cell:PSButtonCell
                                                                     edit:nil];
            respring->action = @selector(respring:);
            
            [self insertContiguousSpecifiers:@[respringGroup, respring] atIndex:0 animated:YES];
            
        }
    } else {
        if ([self specifierForID:@"Respring"]) {
            [self removeContiguousSpecifiers:@[[self specifierAtIndex:0], [self specifierAtIndex:1]] animated:YES];
        }
    }
}

- (void)respring:(PSSpecifier *)specifier
{
    if ([self respondsToSelector:@selector(suspend)]) {
        [self performSelector:@selector(suspend)];
    }
    
    const char *command[] = {
        "killall",
        "backboardd",
        NULL
    };
    
    posix_spawn(NULL, command[0], NULL, NULL, (char *const *)command, NULL);
    
}

#pragma mark - Preferences

- (void)resetAllSettings:(PSSpecifier *)specifier
{
	if (self.prefs) {
		[self.prefs writeDefaults:self.prefs.defaults overwriteExisting:YES];
	}
	
	[self reloadSpecifiers];
}

- (void)setPreferenceValue:(id)value specifier:(PSSpecifier *)specifier
{
    [super setPreferenceValue:value specifier:specifier];
	
	if (self.prefs) {
		
		NSString *key = specifier.properties[@"key"];
		//NSString *defaults = specifier.properties[@"defaults"];
		
		[self.prefs savePreferenceValue:value forKey:key synchronize:YES];
		
	}
}

- (id)readPreferenceValue:(PSSpecifier *)specifier
{
	if (self.prefs) {
		
		NSString *key = specifier.properties[@"key"];
		id value = [self.prefs.preferences valueForKey:key];
		
		if (value) {
			return value;
		}
		
	}
	
	return [super readPreferenceValue:specifier];
}

#pragma mark - SWPSTwitterCell

- (void)viewTwitterProfile:(PSSpecifier *)specifier
{
    [SWPSTwitterCell performActionWithSpecifier:specifier];
}

@end




