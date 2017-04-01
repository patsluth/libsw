//
//  UIScrollView+SW.h
//  sluthwareioslibrary
//
//  Created by Pat Sluth on 2015-04-17.
//  Copyright (c) 2015 Pat Sluth. All rights reserved.
//

#import <UIKit/UIKit.h>





struct SWPage
{
    NSInteger x;
    NSInteger y;
};
typedef struct SWPage SWPage;

static inline SWPage SWPageMake(NSInteger x, NSInteger y)
{
    SWPage p; p.x = x; p.y = y; return p;
}

static inline NSString *NSStringFromCGPage(SWPage p)
{
    return [NSString stringWithFormat:@"{ x=%ld, y=%ld }", (long)p.x, (long)p.y];
}





@interface UIScrollView(SW)

/**
 *  Calculate the current page that the UIScrollView is currently scrolled to. Will return -ve values if paging is not enabled
 *
 *  @return SWPage page
 */
- (SWPage)page;

- (SWPage)pagesAvailable;
- (SWPage)pageInCentre;

- (CGPoint)contentOffsetForPage:(SWPage)page;

@end




