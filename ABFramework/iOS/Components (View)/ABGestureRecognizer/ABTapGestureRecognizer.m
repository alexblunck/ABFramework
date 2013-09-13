//
//  ABTapGestureRecognizer.m
//  ABFramework
//
//  Created by Alexander Blunck on 4/16/13.
//  Copyright (c) 2013 Ablfx. All rights reserved.
//

#import "ABTapGestureRecognizer.h"

@interface ABTapGestureRecognizer () <UIGestureRecognizerDelegate>
{
    ABBlockVoid _block;
    __weak id _target;
    SEL _selector;
}

@end

@implementation ABTapGestureRecognizer

#pragma mark - Utility
+(id) singleTapGestureOnView:(UIView*)view block:(ABBlockVoid)block
{
    return [self tapGestureWithTaps:1 onView:view block:block];
}

+(id) singleTapGestureOnView:(UIView*)view target:(id)target action:(SEL)selector
{
    return [self tapGestureWithTaps:1 onView:view target:target action:selector];
}

+(id) tapGestureWithTaps:(NSUInteger)taps onView:(UIView*)view block:(ABBlockVoid)block
{
    return [[self alloc] initWithTaps:taps view:view block:block target:nil action:nil];
}

+(id) tapGestureWithTaps:(NSUInteger)taps onView:(UIView*)view target:(id)target action:(SEL)selector
{
    return [[self alloc] initWithTaps:taps view:view block:nil target:target action:selector];
}



#pragma mark - Initializer
-(id) initWithTaps:(NSUInteger)taps view:(UIView*)view block:(ABBlockVoid)block target:(id)target action:(SEL)selector
{
    self = [super initWithTarget:self action:@selector(handleGesture:)];
    if (self)
    {
        self.numberOfTapsRequired = taps;
        self.cancelsTouchesInView = NO; //Don't interfere with other gesture recognizers
        self.delegate = self;
        
        if (block) _block = [block copy];
        if (target) _target = target;
        if (selector) _selector = selector;
        
        [view addGestureRecognizer:self];
    }
    return self;
}



#pragma mark - Handle
-(void) handleGesture:(UIGestureRecognizer*)recognizer
{
    if (_block)
    {
        _block();
    }
    
    if (_target && _selector)
    {
        [_target performSelector:_selector withObject:self afterDelay:0];
    }
}



#pragma mark - UIGestureRecognizerDelegate
-(BOOL) gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([touch.view isKindOfClass:[ABButton class]])
    {
        return NO;
    }
    
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return ([self.allowedSimultaneousGestures containsObject:otherGestureRecognizer]);
}

@end
