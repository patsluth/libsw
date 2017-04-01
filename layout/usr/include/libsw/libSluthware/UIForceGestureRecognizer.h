//
//  UIForceGestureRecognizer.h
//  libSluthware
//
//  Created by Pat Sluth on 2015-10-25.
//  Copyright © 2015 Pat Sluth. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIKit/UIGestureRecognizerSubclass.h>

#define SW_PEEK_THESHOLD_DEFAULT 0.45
#define SW_POP_THESHOLD_DEFAULT 0.9

@protocol UIForceGestureRecognizerDelegate;

typedef NS_ENUM(NSInteger, UIForceType) {
    UIForceTypeNone,
    UIForceTypePeek,
    UIForceTypePop
};





@protocol UIForceGestureRecognizer <NSObject>

@required

@property (weak, nonatomic) id<UIForceGestureRecognizerDelegate> forceDelegate;

@property (readonly, nonatomic) UIForceType forceType;

@property (readonly, nonatomic) CGFloat force;
@property (readonly, nonatomic) CGFloat maximumPossibleForce;

/**
 *  Percentage between 0.0 and 1.0, 1.0 being maximumPossibleForce
 */
@property (readonly, nonatomic) CGFloat forcePercentage;

/**
 *  The value that forcePercentage needs to reach to be considered 'peeking'. After this threshold is reached, it is the minimum 
 *  value that forcePercentage will return until the gesture is reset
 *  @defaults 0.3 or 30%
 */
@property (readwrite, nonatomic) CGFloat forcePercentagePeekThreshold;
/**
 *  The value that forcePercentage needs to reach to be considered 'popping'. After this threshold is reached, it is the minimum
 *  value that forcePercentage will return until the gesture is reset
 *  @defaults 0.8 or 80%
 */
@property (readwrite, nonatomic) CGFloat forcePercentagePopThreshold;

@end




