//
//  ABButton.m
//  ABFramework
//
//  Created by Alexander Blunck on 2/4/13.
//  Copyright (c) 2013 Ablfx. All rights reserved.
//

#import "ABButton.h"

@interface ABButton () {
    void (^_actionBlock) ();
}
@end

@implementation ABButton

#pragma mark - Utility
+(id) buttonWithActionBlock:(void(^)())block
{
    return [[self alloc] initWithActionBlock:block];
}



#pragma mark - Initializer
-(id) initWithActionBlock:(void(^)())block
{
    self = [super init];
    if (self) {
        
        _actionBlock = block;
        
        [self addTarget:self action:@selector(selectedButton) forControlEvents:UIControlEventTouchUpInside];
        
    } return self;
}



#pragma mark - Button
-(void) selectedButton
{
    if (_actionBlock) {
        _actionBlock();
    }
}

@end
