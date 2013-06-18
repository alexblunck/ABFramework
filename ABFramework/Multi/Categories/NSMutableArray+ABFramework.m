//
//  NSMutableArray+ABFramework.m
//  ABFramework
//
//  Created by Alexander Blunck on 6/17/13.
//  Copyright (c) 2013 Ablfx. All rights reserved.
//

#import "NSMutableArray+ABFramework.h"

@implementation NSMutableArray (ABFramework)

-(void) moveObjectAtIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex
{
    id object = [self objectAtIndex:fromIndex];
    [self removeObjectAtIndex:fromIndex];
    [self insertObject:object atIndex:toIndex];
}

@end
