//
//  ABSwipeGestureRecognizer.m
//  ABFramework
//
//  Created by Alexander Blunck on 4/19/13.
//  Copyright (c) 2013 Ablfx. All rights reserved.
//

#import "ABSwipeGestureRecognizer.h"

@interface ABSwipeGestureRecognizer () <UIGestureRecognizerDelegate>
{
    ABBlockVoid _block;
}
@end

@implementation ABSwipeGestureRecognizer

#pragma mark - Utility
+(id) rightSwipeGestureOnView:(UIView*)view block:(ABBlockVoid)block
{
    return [[self alloc] initWithSwipeDirection:UISwipeGestureRecognizerDirectionRight view:view block:block];
}

+(id) downSwipeGestureOnView:(UIView*)view block:(ABBlockVoid)block
{
    return [[self alloc] initWithSwipeDirection:UISwipeGestureRecognizerDirectionDown view:view block:block];
}



#pragma mark - Initializer
-(id) initWithSwipeDirection:(UISwipeGestureRecognizerDirection)direction view:(UIView*)view block:(ABBlockVoid)block
{
    self = [super initWithTarget:self action:@selector(handleGesture:)];
    if (self)
    {
        self.direction = direction;
        
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
    if (!gestureRecognizer.enabled) {
        return NO;
    }
    return YES;
}

@end
