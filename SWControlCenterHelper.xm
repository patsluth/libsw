//
//  SWControlCenterHelper.xm
//  libsw
//
//  Created by Pat Sluth on 2015-04-25.
//
//

#import "SWControlCenterHelper.h"

#import "SpringBoard/SBControlCenterController.h"





@implementation SWControlCenterHelper

+ (void)dismissAnimated:(BOOL)animated
{
	id controlCenterController = [%c(SBControlCenterController) sharedInstanceIfExists];
	if (controlCenterController && [controlCenterController respondsToSelector:@selector(dismissAnimated:)]) {
		[controlCenterController dismissAnimated:animated];
	}
}

@end




