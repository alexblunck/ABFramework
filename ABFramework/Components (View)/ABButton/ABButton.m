//
//  ABButton.m
//  ABFramework
//
//  Created by Alexander Blunck on 2/4/13.
//  Copyright (c) 2013 Ablfx. All rights reserved.
//

#import "ABButton.h"

@interface ABButton () {
    ABBlockVoid _actionBlock;
}
@end

@implementation ABButton

#pragma mark - Utility
+(id) buttonWithActionBlock:(ABBlockVoid)actionBlock
{
    return [[self alloc] initWithActionBlock:actionBlock];
}



#pragma mark - Initializer
-(id) initWithActionBlock:(ABBlockVoid)actionBlock
{
    self = [super init];
    if (self) {
        
        _actionBlock = actionBlock;
        
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
