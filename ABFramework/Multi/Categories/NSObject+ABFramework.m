//
//  NSObject+ABFramework.m
//  ABFramework
//
//  Created by Alexander Blunck on 1/27/13.
//  Copyright (c) 2013 Ablfx. All rights reserved.
//

#import "NSObject+ABFramework.h"

@implementation NSObject (ABFramework)

#pragma mark - Subscript Support
#pragma mark - Dictionary Style
-(id) objectForKeyedSubscript:(id)key
{
    return nil;
}

-(void) setObject:(id)obj forKeyedSubscript:(id <NSCopying>)key
{
    
}

#pragma mark - Array Style
-(id) objectAtIndexedSubscript:(NSUInteger)index
{
    return nil;
}

-(void) setObject:(id)obj atIndexedSubscript:(NSUInteger)idx
{
    
}

@end
