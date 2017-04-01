//
//  libSluthware.h
//  libSluthware
//
//  Created by Pat Sluth on 2015-11-06.
//  Copyright © 2015 Pat Sluth. All rights reserved.
//

#ifndef libSluthware_h
#define libSluthware_h

#import <Foundation/Foundation.h>

#define SW_INLINE static inline
#define SW_EXTERN extern





#pragma mark - System Version

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

#pragma mark - Log

SW_INLINE NSString *NSStringFromBool(BOOL b)
{
    return (b == YES) ? @"YES" : @"NO";
}

#define LOG_METHOD_START							NSLog(@"");NSLog(@"");NSLog(@"****************************************************************"); \
													NSLog(@"[%@]", NSStringFromClass([((id)self) class])); \
													NSLog(@"%@]", NSStringFromSelector(_cmd)); \
													NSLog(@"----------------------------------------------------------------");
#define LOG_METHOD_END								NSLog(@"****************************************************************");NSLog(@"");NSLog(@"");





#endif /* libSluthware_h */




