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
}

@end

@implementation ABTapGestureRecognizer

#pragma mark - Utility
+(id) singleTapGestureOnView:(UIView*)view block:(ABBlockVoid)block
{
    return [[self alloc] initWithTaps:1 view:view block:block];
}

+(id) tapGestureWithTaps:(NSUInteger)taps onView:(UIView*)view block:(ABBlockVoid)block
{
    return [[self alloc] initWithTaps:taps view:view block:block];
}


#pragma mark - Initializer
-(id) initWithTaps:(NSUInteger)taps view:(UIView*)view block:(ABBlockVoid)block
{
    self = [super initWithTarget:self action:@selector(handleGesture:)];
    if (self)
    {
        self.numberOfTapsRequired = taps;
        self.cancelsTouchesInView = NO; //Don't interfere with other gesture recognizers
        self.delegate = self;
        
        _block = [block copy];
        
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
