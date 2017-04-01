//
//  NSTimer+SW.h
//  sluthwareioslibrary
//
//  Created by Pat Sluth on 2015-04-17.
//  Copyright (c) 2015 Pat Sluth. All rights reserved.
//

#import <Foundation/Foundation.h>





@interface NSTimer(SW)

+ (id)scheduledTimerWithTimeInterval:(NSTimeInterval)inTimeInterval block:(void (^)())block repeats:(BOOL)repeats;
+ (id)timerWithTimeInterval:(NSTimeInterval)inTimeInterval block:(void (^)())block repeats:(BOOL)repeats;

@end




