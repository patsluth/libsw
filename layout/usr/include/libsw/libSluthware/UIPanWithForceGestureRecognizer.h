//
//  UIPanWithForceGestureRecognizer.h
//  libSluthware
//
//  Created by Pat Sluth on 2015-10-25.
//  Copyright © 2015 Pat Sluth. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIForceGestureRecognizer.h"
#import "UIForceGestureRecognizerDelegate.h"





@interface UIPanWithForceGestureRecognizer : UIPanGestureRecognizer <UIForceGestureRecognizer>

@property (weak, nonatomic) id<UIForceGestureRecognizerDelegate> forceDelegate;

@property (readonly, nonatomic) UIForceType forceType;

@property (readwrite, nonatomic) CGFloat forcePercentagePeekThreshold;
@property (readwrite, nonatomic) CGFloat forcePercentagePopThreshold;

@end




