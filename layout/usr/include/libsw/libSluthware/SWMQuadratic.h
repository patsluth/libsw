//
//  SWMQuadratic.h
//  libSluthware
//
//  Created by Pat Sluth on 2015-04-21.
//  Copyright (c) 2015 Pat Sluth. All rights reserved.
//

#ifndef SWMQuadratic_h
#define SWMQuadratic_h





#import "libSluthware.h"

#import <CoreGraphics/CoreGraphics.h>





/**
 *  ax^2 + bx + c = 0
 */
struct SWMQuadratic {
    CGFloat a;
    CGFloat b;
    CGFloat c;
};
typedef struct SWMQuadratic SWMQuadratic;

/**
 *  Construct a quadratic
 *
 *  @param m (slope)
 *  @param b (y intercept)
 *
 *  @return SWLine
 */
SW_EXTERN SWMQuadratic SWMQuadraticMake(CGFloat a, CGFloat b, CGFloat c);

/**
 *  Uses the quadratic equation [-b +- sqrt(b^2 - 4ac) / 2a] to solve for x
 *
 *  @param quadratic
 *
 *  @return CGPoint containing both roots. NAN if does not exist
 */
SW_EXTERN CGPoint SWMQuadraticSolveRoots(SWMQuadratic quadratic);

/**
 *  b^2 - 4ac
 *
 *  @param quadratic
 *
 *  @return descriminant
 */
SW_EXTERN CGFloat SWMQuadraticSolveDescriminant(SWMQuadratic quadratic);

/**
 *  Plugs value into 'x' and solves
 *
 *  @param value
 *
 *  @return solved
 */
SW_EXTERN CGFloat SWMQuadraticSolveForValue(SWMQuadratic quadratic, CGFloat value);

/**
 *  Add 2 quadratics
 *
 *  @param q1
 *  @param q2
 *
 *  @return quadratic
 */
SW_EXTERN SWMQuadratic SWMQuadraticAdd(SWMQuadratic q1, SWMQuadratic q2);

SW_EXTERN NSString *NSStringFromSWMQuadratic(SWMQuadratic quadratic);





#endif




