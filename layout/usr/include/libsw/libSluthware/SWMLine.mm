//
//  SWMLine.m
//  libSluthware
//
//  Created by Pat Sluth on 2015-04-21.
//  Copyright (c) 2015 Pat Sluth. All rights reserved.
//

#import "SWMLine.h"

#import <math.h>






SWMLine SWMLineMake(CGFloat m, CGFloat b)
{
    SWMLine line;
    line.m = m;
    line.b = b;
    return line;
}

SWMLine SWMLineMakeWithPoints(CGPoint p1, CGPoint p2)
{
    CGFloat m = SWMLineSlopeBetweenPoints(p1, p2);
    //point slope form
    //y - y2 = m(x - x2)
    //y =  m(x - x2) + y2
    //y = mx - mx2 + y2
    CGFloat b = (m * -p2.x) + p2.y;
    
    return SWMLineMake(m, b);
}

CGFloat SWMLineSolveWithX(SWMLine line, CGFloat x)
{
    //y = mx + b
    return (line.m * x) + line.b;
}

CGFloat SWMLineSolveWithY(SWMLine line, CGFloat y)
{
    //y = mx + b
    //y - b = mx
    //x = (y - b) / m
    return (y - line.b) / line.m;
}

CGFloat SWMLineSlopeBetweenPoints(CGPoint p1, CGPoint p2)
{
    CGFloat m = (p1.y - p2.y) / (p1.x - p2.x);
    return m;
}

CGFloat SWMLineLengthBetweenPoints(CGPoint p1, CGPoint p2)
{
    CGFloat rise = p1.y - p2.y;
    CGFloat run = p1.x - p2.x;
    //c^2 = a^2 + b^2
    CGFloat hypotenuseSquared = (rise * rise) + (run * run);
    
    return sqrtf(hypotenuseSquared);
}

NSString *NSStringFromSWMLine(SWMLine line)
{
    return [NSString stringWithFormat:@"y = (%1.2f)x + (%1.2f)", line.m, line.b];
}




