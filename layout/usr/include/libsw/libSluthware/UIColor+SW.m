//
//  UIColor+SW.m
//  sluthwareioslibrary
//
//  Created by Pat Sluth on 2015-04-17.
//  Copyright (c) 2015 Pat Sluth. All rights reserved.
//

#import "UIColor+SW.h"





@implementation UIColor(SW)

+ (UIColor *)randomColour
{
    CGFloat hue = (arc4random() % 256 / 256.0);  //  0.0 to 1.0
    CGFloat saturation = (arc4random() % 128 / 256.0) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = (arc4random() % 128 / 256.0) + 0.5;  //  0.5 to 1.0, away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1.0];
}

@end




