//
//  NSTimer+SW.m
//  sluthwareioslibrary
//
//  Created by Pat Sluth on 2015-04-17.
//  Copyright (c) 2015 Pat Sluth. All rights reserved.
//

#import "NSTimer+SW.h"





@implementation NSTimer(SW)

+ (id)scheduledTimerWithTimeInterval:(NSTimeInterval)inTimeInterval block:(void (^)())block repeats:(BOOL)repeats
{
    id ret = [self scheduledTimerWithTimeInterval:inTimeInterval
                                           target:self
                                         selector:@selector(swExecuteBlock:)
                                         userInfo:block
                                          repeats:repeats];
    return ret;
}

+ (id)timerWithTimeInterval:(NSTimeInterval)inTimeInterval block:(void (^)())block repeats:(BOOL)repeats
{
    id ret = [self timerWithTimeInterval:inTimeInterval
                                  target:self
                                selector:@selector(swExecuteBlock:)
                                userInfo:block
                                 repeats:repeats];
    return ret;
}

+ (void)swExecuteBlock:(NSTimer *)timer;
{
    if([timer userInfo])
    {
        void (^block)() = (void (^)())[timer userInfo];
        block();
    }
}

@end




