//
//  SWAppLauncher.h
//  acapellaprefs
//
//  Created by Pat Sluth on 2015-04-25.
//
//

@class SBApplication;





@interface SWAppLauncher : NSObject

+ (void)launchAppWithBundleID:(NSString *)bundleID;
+ (void)launchApp:(SBApplication *)app;
+ (void)launchAppWithBundleIDLockscreenFriendly:(NSString *)bundleID;
+ (void)launchAppLockscreenFriendly:(SBApplication *)app;

@end




