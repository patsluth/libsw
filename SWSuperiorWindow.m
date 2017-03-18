//
//  SWSuperiorWindow.m
//  libsw
//
//  Created by Pat Sluth on 2015-04-25.
//
//

#import "SWSuperiorWindow.h"





@implementation SWSuperiorWindow

#pragma mark - Init

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.userInteractionEnabled = YES;
        self.backgroundColor = [UIColor clearColor];
        
        self.rootViewController = [[UIViewController alloc] init];
        self.rootViewController.view.backgroundColor = [UIColor clearColor];
        self.rootViewController.view.tag = 696969;
        
        //private method
        SEL selector = NSSelectorFromString(@"_setSecure:");
        [self performSelectorOnMainThread:selector withObject:@YES waitUntilDone:NO];
    }
    
    return self;
}

#pragma mark - Public

- (void)show
{
    self.hidden = NO;
    self.windowLevel = 9999;
    [self makeKeyAndVisible];
}

- (void)hide
{
    [self resignKeyWindow];
    self.hidden = YES;
}

@end




