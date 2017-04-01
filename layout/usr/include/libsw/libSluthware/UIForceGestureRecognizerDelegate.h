//
//  UIForceGestureRecognizerDelegate.h
//  libSluthware
//
//  Created by Pat Sluth on 2015-10-25.
//  Copyright © 2015 Pat Sluth. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIKit/UIGestureRecognizerSubclass.h>

@protocol UIForceGestureRecognizer;





@protocol UIForceGestureRecognizerDelegate <NSObject>

@optional

- (void)onForceChange:(UIGestureRecognizer<UIForceGestureRecognizer> * _Nonnull)forceGestureRecognizer;

@end




