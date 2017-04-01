//
//  UILongPressWithForceGestureRecognizer.m
//  libSluthware
//
//  Created by Pat Sluth on 2015-10-25.
//  Copyright © 2015 Pat Sluth. All rights reserved.
//

#import "UILongPressWithForceGestureRecognizer.h"

#import "libSluthware.h"





@interface UILongPressWithForceGestureRecognizer()
{
}

@property (readwrite, nonatomic) CGFloat force;
@property (readwrite, nonatomic) CGFloat maximumPossibleForce;

@property (readwrite, nonatomic) UIForceType forceType;

@property (readwrite, nonatomic) CGFloat forcePercentage;

@end





@implementation UILongPressWithForceGestureRecognizer

#pragma mark - Init

- (id)init
{
    self = [super init];
    
    if (self){
        [self swInitialize];
    }
    
    return self;
}

- (id)initWithTarget:(id)target action:(SEL)action
{
    self = [super initWithTarget:target action:action];
    
    if (self){
        [self swInitialize];
    }
    
    return self;
}

- (void)swInitialize
{
    self.forcePercentage = 0.0;
    self.maximumPossibleForce = 1.0;
    
    self.forceType = UIForceTypeNone;
    
    [self reset];
    
    self.forcePercentagePeekThreshold = SW_PEEK_THESHOLD_DEFAULT;
    self.forcePercentagePopThreshold = SW_POP_THESHOLD_DEFAULT;
}

#pragma mark - Force

- (void)setForce:(CGFloat)force
{
    if (force < 0.0) force = 0.0;
    if (force > self.maximumPossibleForce) force = self.maximumPossibleForce;
    
    _force = force;
    
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"9.0")){
        
        CGFloat newForcePercentage = _force / self.maximumPossibleForce;
        
        //dont go below the highest force threshold this touch
        if (self.forcePercentage >= self.forcePercentagePopThreshold){
            self.forcePercentage = fmax(newForcePercentage, self.forcePercentagePopThreshold);
            self.forceType = UIForceTypePop;
        } else if (self.forcePercentage >= self.forcePercentagePeekThreshold){
            self.forcePercentage = fmax(newForcePercentage, self.forcePercentagePeekThreshold);
            self.forceType = UIForceTypePeek;
        } else {
            self.forcePercentage = newForcePercentage;
            self.forceType = UIForceTypeNone;
        }
        
    }
}

- (CGFloat)maximumPossibleForce
{
    //make sure we dont divide by 0 on unsupported devices
    return (_maximumPossibleForce == 0.0) ? 1.0 : _maximumPossibleForce;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"9.0")){
        
        self.maximumPossibleForce = touches.anyObject.maximumPossibleForce;
        self.force = touches.anyObject.force;
        
        if ([self.forceDelegate respondsToSelector:@selector(onForceChange:)]){
            [self.forceDelegate onForceChange:self];
        }
        
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
    
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"9.0")){
        
        self.maximumPossibleForce = touches.anyObject.maximumPossibleForce;
        self.force = touches.anyObject.force;
        
        if ([self.forceDelegate respondsToSelector:@selector(onForceChange:)]){
            [self.forceDelegate onForceChange:self];
        }
        
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"9.0")){
        
        if ([self.forceDelegate respondsToSelector:@selector(onForceChange:)]){
            [self.forceDelegate onForceChange:self];
        }
        
    }
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesCancelled:touches withEvent:event];
    
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"9.0")){
        
        if ([self.forceDelegate respondsToSelector:@selector(onForceChange:)]){
            [self.forceDelegate onForceChange:self];
        }
        
    }
}

- (void)touchesEstimatedPropertiesUpdated:(NSSet * _Nonnull)touches NS_AVAILABLE_IOS(9_1)
{
    [super touchesEstimatedPropertiesUpdated:touches];
}

- (void)reset
{
    [super reset];
    
    self.forcePercentage = 0.0;
}

@end




