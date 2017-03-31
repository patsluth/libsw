//
//  SWAppLauncher.m
//  libsw
//
//  Created by Pat Sluth on 2015-04-25.
//
//

#import "SWAppLauncher.h"

#import <Springboard/SBApplication.h>
#import <Springboard/SBApplicationController.h>
#import <Springboard/SBUIController.h>
#import <Springboard/SBDeviceLockController.h>
#import <Springboard/SBLockScreenManager.h>
#import <Springboard/SBLockScreenViewControllerBase.h>
#import <Springboard/SBLockScreenViewController.h>
#import <Springboard/SBControlCenterController.h>

static SBApplication *swAppLauncherAppToLaunchOnUnlock;




%hook SBLockScreenViewController

- (void)finishUIUnlockFromSource:(int)arg1
{
    %orig(arg1);
    
    if (swAppLauncherAppToLaunchOnUnlock) {
        [SWAppLauncher launchApp:swAppLauncherAppToLaunchOnUnlock];
        swAppLauncherAppToLaunchOnUnlock = nil;
    }
}

//- (void)lockScreenView:(id)arg1 didScrollToPage:(long long)arg2
//{
//    %orig();
//    
//    if ([[self lockScreenScrollView] page].x == 1) {
//        swAppLauncherAppToLaunchOnUnlock = nil;
//    }
//    
//    //0 is passcode view
//    //1 is main view. still main view even if no passcode view.
//}

%end





@implementation SWAppLauncher

+ (void)launchAppWithBundleID:(NSString *)bundleID
{
    NSLog(@"PAT %@", bundleID);
    
//    SBApplicationController *applicationController = [%c(SBApplicationController) sharedInstance];
//    NSLog(@"PAT %@", applicationController);
//    
//    NSDictionary *applications = MSHookIvar<NSDictionary *>(applicationController, "_applicationsByBundleIdentifer");
//    
//    NSLog(@"PAT %@", applications);
//    
//    id app = [applications valueForKey:bundleID];
//    
//    NSLog(@"PAT %@", app);
//    
//    if (app) {
//        [%c(SWAppLauncher) launchApp:app];
//    }
}

+ (void)launchApp:(SBApplication *)app
{
    if (!app) {
        return;
    }
    
    
    
    
    
    
    
    
//    unsigned int methodCount = 0;
//    Method *methods = class_copyMethodList(%c(SBUIController), &methodCount);
//    
//    NSLog(@"Found %d methods on '%s'\n", methodCount, class_getName(%c(SBUIController)));
//    
//    for (unsigned int i = 0; i < methodCount; i++) {
//        Method method = methods[i];
//        NSLog(@"METHOD %s", sel_getName(method_getName(method)));
//    }
    
    
    
    
    
    
    id sbUIController = [%c(SBUIController) sharedInstanceIfExists];
    
    if ([sbUIController respondsToSelector:@selector(activateApplicationAnimated:)]) { //iOS < 9.0
        [sbUIController activateApplicationAnimated:app];
    } else if ([sbUIController respondsToSelector:@selector(activateApplication:)]) { //iOS > 9.0
        [sbUIController activateApplication:app];
    } else {
        NSLog(@"libsw: Could not activate application %@", app);
    }
    
}

+ (void)launchAppWithBundleIDLockscreenFriendly:(NSString *)bundleID
{
    id app = [[%c(SBApplicationController) sharedInstance] applicationWithBundleIdentifier:bundleID];
    
    if (app) {
        [%c(SWAppLauncher) launchAppLockscreenFriendly:app];
    }
}

+ (void)launchAppLockscreenFriendly:(SBApplication *)app
{
    if (!app) {
        return;
    }
    
    swAppLauncherAppToLaunchOnUnlock = app;
    
    SBDeviceLockController *deviceLC = (SBDeviceLockController *)[%c(SBDeviceLockController) sharedController];
    
    if (deviceLC && deviceLC.isPasscodeLocked) {
        
        SBLockScreenManager *manager = (SBLockScreenManager *)[%c(SBLockScreenManager) sharedInstance];
        
        if (manager && manager.isUILocked) {
            
            SBLockScreenViewControllerBase *controller = [manager lockScreenViewController];
            
            if (controller) {
                
                SBControlCenterController *sbCC = (SBControlCenterController *)[%c(SBControlCenterController) sharedInstanceIfExists];
                
                if (sbCC) {
                    [sbCC dismissAnimated:YES];
                }
                
                [controller setPasscodeLockVisible:YES animated:YES completion:nil];
                
                return;
                
            }
        }
    }
    
    [SWAppLauncher launchApp:app];
}

@end




