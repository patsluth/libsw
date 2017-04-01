//
//  UIScrollView+SW.m
//  sluthwareioslibrary
//
//  Created by Pat Sluth on 2015-04-17.
//  Copyright (c) 2015 Pat Sluth. All rights reserved.
//

#import "UIScrollView+SW.h"





@implementation UIScrollView(SW)

- (SWPage)page
{
    if (!self.pagingEnabled){
        return SWPageMake(-69, -69);
    }
    
    CGFloat pageWidth = self.bounds.size.width;
    CGFloat pageHeight = self.bounds.size.height;
    
    float fractionalPageHorizontal = self.contentOffset.x / pageWidth;
    float fractionalPageVertical = self.contentOffset.y / pageHeight;
    
    return SWPageMake(lround(fractionalPageHorizontal), lround(fractionalPageVertical));
}

- (SWPage)pagesAvailable
{
    NSInteger x = -1;
    NSInteger y = -1;
    
    if (self.pagingEnabled && self.bounds.size.width > 0.0){
        x = lround(self.contentSize.width / self.bounds.size.width);
    }
    if (self.pagingEnabled && self.bounds.size.height > 0.0){
        y = lround(self.contentSize.height / self.bounds.size.height);
    }
    
    return SWPageMake(x, y);
}

- (SWPage)pageInCentre
{
    if (!self.pagingEnabled){
        return SWPageMake(-69, -69);
    }
    
    SWPage pagesAvailable = [self pagesAvailable];
    
    NSInteger x = (NSInteger)((CGFloat)pagesAvailable.x / 2.0);
    NSInteger y = (NSInteger)((CGFloat)pagesAvailable.y / 2.0);
    
    return SWPageMake(x, y);
}

- (CGPoint)contentOffsetForPage:(SWPage)page
{
    return CGPointMake(CGRectGetWidth(self.frame) * page.x, CGRectGetWidth(self.frame) * page.y);
}

@end




