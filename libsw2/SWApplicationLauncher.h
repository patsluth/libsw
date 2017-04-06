//
//  SWApplicationLauncher.h
//  libsw
//
//  Created by Pat Sluth on 2015-04-25.
//
//

@class SBApplication;





@interface SWApplicationLauncher : NSObject

+ (void)launchApplicationWithBundleID:(NSString *)bundleID;
+ (void)launchApplication:(SBApplication *)application;

@end




