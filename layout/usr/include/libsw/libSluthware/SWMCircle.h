//
//  SWMCircle.h
//  libSluthware
//
//  Created by Pat Sluth on 2015-04-21.
//  Copyright (c) 2015 Pat Sluth. All rights reserved.
//

#ifndef SWMCircle_h
#define SWMCircle_h





#import "libSluthware.h"

#import "SWMLine.h"
#import "SWMQuadratic.h"

#import <CoreGraphics/CoreGraphics.h>





/**
 *  (x - h)^2 + (y - k)^2 = r^2
 */
struct SWMCircle {
    CGPoint hk; //center
    CGFloat r; //radius
};
typedef struct SWMCircle SWMCircle;

/**
 *  Construct a circle
 *
 *  @param m (slope)
 *  @param b (y intercept)
 *
 *  @return SWLine
 */
SW_EXTERN SWMCircle SWMCircleMake(CGPoint hk, CGFloat r);

/**
 *  Solve for x in terms of y
 *
 *  @param circle
 *  @param y
 *
 *  @return point with both x values
 */
SW_EXTERN CGPoint SWMCircleSolveWithY(SWMCircle circle, CGFloat y);

/**
 *  Get quadratic representing intersection of a circle and a line
 *
 *  @param circle
 *  @param line
 *
 *  @return quadratic
 */
SW_EXTERN SWMQuadratic SWMCircleIntersectionWithSWMLine(SWMCircle circle, SWMLine line);

SW_EXTERN NSString *NSStringFromSWMCircle(SWMCircle circle);





#endif




