//
//  SWMQuadratic.m
//  libSluthware
//
//  Created by Pat Sluth on 2015-04-21.
//  Copyright (c) 2015 Pat Sluth. All rights reserved.
//

#import "SWMQuadratic.h"

#import <math.h>






SWMQuadratic SWMQuadraticMake(CGFloat a, CGFloat b, CGFloat c)
{
    SWMQuadratic quadratic;
    quadratic.a = a;
    quadratic.b = b;
    quadratic.c = c;
    return quadratic;
}

CGPoint SWMQuadraticSolveRoots(SWMQuadratic quadratic)
{
    CGFloat descriminant = SWMQuadraticSolveDescriminant(quadratic);
    
    if (descriminant < 0){
        return CGPointMake(NAN, NAN);
    }
    
    CGFloat numeratorAdd = -quadratic.b + sqrt(descriminant);
    CGFloat numeratorSubtract = -quadratic.b - sqrt(descriminant);
    CGFloat denomenator = 2.0 * quadratic.a;
    
    return CGPointMake(numeratorAdd / denomenator,
                       numeratorSubtract / denomenator);
}

CGFloat SWMQuadraticSolveDescriminant(SWMQuadratic quadratic)
{
    return (quadratic.b * quadratic.b) - (4.0 * quadratic.a * quadratic.c);
}

CGFloat SWMQuadraticSolveForValue(SWMQuadratic quadratic, CGFloat value)
{
    return (quadratic.a * (value * value) ) + (quadratic.b * value) + (quadratic.c);
}

SWMQuadratic SWMQuadraticAdd(SWMQuadratic q1, SWMQuadratic q2)
{
    return SWMQuadraticMake(q1.a + q2.a,
                            q1.b + q2.b,
                            q1.c + q2.c);
}

NSString *NSStringFromSWMQuadratic(SWMQuadratic quadratic)
{
    return [NSString stringWithFormat:@"(%1.2f)x^2 + (%1.2f)x + (%1.2f) = 0",
            quadratic.a,
            quadratic.b,
            quadratic.c];
}




