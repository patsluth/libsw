//
//  SWMCircle.m
//  libSluthware
//
//  Created by Pat Sluth on 2015-04-21.
//  Copyright (c) 2015 Pat Sluth. All rights reserved.
//

#import "SWMCircle.h"






extern SWMCircle SWMCircleMake(CGPoint hk, CGFloat r)
{
    SWMCircle circle;
    circle.hk = hk;
    circle.r = r;
    return circle;
}

extern CGPoint SWMCircleSolveWithY(SWMCircle circle, CGFloat y)
{
    //(x - h)^2 expands to x^2 - 2h + h^2
    SWMQuadratic xhExpanded = SWMQuadraticMake(1.0, (circle.hk.x * -2.0), (circle.hk.x * circle.hk.x));
    //(y - k)^2 expands to y^2 - 2k + k^2
    SWMQuadratic ykExpanded = SWMQuadraticMake(1.0, (circle.hk.y * -2.0), (circle.hk.y * circle.hk.y));
    
    CGFloat xhSolved = SWMQuadraticSolveForValue(xhExpanded, y);
    ykExpanded.c = ( ykExpanded.c + xhSolved -
                    (circle.r * circle.r)); //squared
    
    return SWMQuadraticSolveRoots(ykExpanded);
}

SWMQuadratic SWMCircleIntersectionWithSWMLine(SWMCircle circle, SWMLine line)
{
    //(x - h)^2 expands to x^2 - 2h + h^2
    SWMQuadratic xhExpanded = SWMQuadraticMake(1.0, (circle.hk.x * -2.0), (circle.hk.x * circle.hk.x));
    //(y - k)^2 expands to y^2 - 2k + k^2
    //SWMQuadratic ykExpanded = SWMQuadraticMake(1.0, (circle.hk.y * -2.0), (circle.hk.y * circle.hk.y));
    
    //sub y in (y - k)^2 with y = mx + b
    // (mx + b - k)^2
    SWMQuadratic ykSubbedAndExpanded = SWMQuadraticMake( (line.m * line.m), //squared
                                                        ( (line.m * (line.b - circle.hk.y)) * 2.0 ),
                                                        ( (line.b - circle.hk.y) * (line.b - circle.hk.y) ) //squared
                                                        );
    
    SWMQuadratic simplified = SWMQuadraticAdd(xhExpanded, ykSubbedAndExpanded);
    simplified.c -= (circle.r * circle.r); //squared
    
    return simplified;
}

NSString *NSStringFromSWMCircle(SWMCircle circle)
{
    return [NSString stringWithFormat:@"(x - %1.2f)^2 + (y - %1.2f)^2 = (%1.2f)^2",
            circle.hk.x,
            circle.hk.y,
            circle.r];
}




