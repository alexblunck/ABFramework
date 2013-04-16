//
//  ABTapGestureRecognizer.m
//  ABFramework
//
//  Created by Alexander Blunck on 4/16/13.
//  Copyright (c) 2013 Ablfx. All rights reserved.
//

#import "ABTapGestureRecognizer.h"

@interface ABTapGestureRecognizer ()
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



#pragma mark - Initializer
-(id) initWithTaps:(NSUInteger)taps view:(UIView*)view block:(ABBlockVoid)block
{
    self = [super initWithTarget:self action:@selector(handleGesture:)];
    if (self)
    {
        self.numberOfTapsRequired = taps;
        
        _block = [block copy];
        
        [view addGestureRecognizer:self];
    }
    return self;
}

-(void) handleGesture:(UIGestureRecognizer*)recognizer
{
    if (_block)
    {
        _block();
    }
}

@end
