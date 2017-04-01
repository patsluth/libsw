//
//  SWMLine.h
//  libSluthware
//
//  Created by Pat Sluth on 2015-04-21.
//  Copyright (c) 2015 Pat Sluth. All rights reserved.
//

#ifndef SWMLine_h
#define SWMLine_h





#import "libSluthware.h"

#import <CoreGraphics/CoreGraphics.h>





/**
 *  y = mx + b
 */
struct SWMLine {
    CGFloat m;
    CGFloat b;
};
typedef struct SWMLine SWMLine;

/**
 *  Construct a line
 *
 *  @param m (slope)
 *  @param b (y intercept)
 *
 *  @return SWLine
 */
SW_EXTERN SWMLine SWMLineMake(CGFloat m, CGFloat b);

/**
 *  Construct a line from point 1 to point 2
 *
 *  @param p1
 *  @param p2
 *
 *  @return SWLine
 */
SW_EXTERN SWMLine SWMLineMakeWithPoints(CGPoint p1, CGPoint p2);

/**
 *  Solve for y in terms of x
 *
 *  @param line
 *  @param x
 *
 *  @return y
 */
SW_EXTERN CGFloat SWMLineSolveWithX(SWMLine line, CGFloat x);

/**
 *  Solve for x in terms of y
 *
 *  @param line
 *  @param y
 *
 *  @return x
 */
SW_EXTERN CGFloat SWMLineSolveWithY(SWMLine line, CGFloat y);

/**
 *  Get slope of a line between 2 points
 *
 *  @param x
 *  @param y
 *
 *  @return m (slope)
 */
SW_EXTERN CGFloat SWMLineSlopeBetweenPoints(CGPoint p1, CGPoint p2);

/**
 *  Get length of a line between 2 points
 *
 *  @param x
 *  @param y
 *
 *  @return length
 */
SW_EXTERN CGFloat SWMLineLengthBetweenPoints(CGPoint p1, CGPoint p2);

SW_EXTERN NSString *NSStringFromSWMLine(SWMLine line);





#endif




