//
//  SWApplicationLauncher.xm
//  libsw
//
//  Created by Pat Sluth on 2015-04-25.
//
//

#import "SWApplicationLauncher.h"

#import "SWControlCenterHelper.h"

#import "SpringBoard/SBMainWorkspace.h"
#import "SpringBoard/SBApplication.h"
#import "SpringBoard/SBApplicationController.h"
#import "SpringBoard/SBUIController.h"
#import "SpringBoard/SBControlCenterController.h"

#import "Sluthware/Sluthware.h"




@implementation SWApplicationLauncher

+ (void)launchApplicationWithBundleID:(NSString *)bundleID
{
    SBApplicationController *applicationController = [%c(SBApplicationController) sharedInstance];
	id application = nil;
	
	if ([applicationController respondsToSelector:@selector(applicationWithBundleIdentifier:)]) {
		application = [applicationController applicationWithBundleIdentifier:bundleID];
	} else {
		NSLog(@"Could not launch application %@", bundleID);
	}
	
//    NSDictionary *applications = MSHookIvar<NSDictionary *>(applicationController, "_applicationsByBundleIdentifer");
//    id application = [applications valueForKey:bundleID];
	
    [%c(SWApplicationLauncher) launchApplication:application];
}

+ (void)launchApplication:(SBApplication *)application
{
	if (!application) {
        return;
    }
	
	SBMainWorkspace *sbMainWorkspace = [%c(SBMainWorkspace) sharedInstance];
	[%c(SWControlCenterHelper) dismissAnimated:YES];
	
	[sbMainWorkspace _attemptUnlockToApplication:application
									showPasscode:YES
										  origin:nil
									  completion:^(BOOL finished) {
										  if (finished) {
											  
											  id sbUIController = [%c(SBUIController) sharedInstanceIfExists];
											  
											  if ([sbUIController respondsToSelector:@selector(activateApplicationAnimated:)]) { //iOS < 9.0
												  [sbUIController activateApplicationAnimated:application];
											  } else if ([sbUIController respondsToSelector:@selector(activateApplication:)]) { //iOS > 9.0
												  [sbUIController activateApplication:application];
											  } else {
												  NSLog(@"Could not launch application %@", application);
											  }
											  
										  }
									  }];
}

@end




