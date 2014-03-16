//
//  ABPair.m
//  ABFramework
//
//  Created by Alexander Blunck on 2/23/13.
//  Copyright (c) 2013 Ablfx. All rights reserved.
//

#import "ABPair.h"

@implementation ABPair

#pragma mark - Utility
+(id) pairWithObjectA:(id)a andObjectB:(id)b
{
    return [[self alloc] initWithA:a andB:b];
}

+(id) pairWithIntegerA:(NSInteger)a andIntegerB:(NSInteger)b;
{
    NSNumber *numberA = [NSNumber numberWithInteger:a];
    NSNumber *numberB = [NSNumber numberWithInteger:b];
    return [[self alloc] initWithA:numberA andB:numberB];
}



#pragma mark - Initializer
-(id) initWithA:(id)a andB:(id)b
{
    self = [super init];
    if (self)
    {
        self.a = a;
        self.b = b;
    }
    return self;
}



#pragma mark - Subscript Support
-(id) objectAtIndexedSubscript:(NSUInteger)index
{
    if (index == 0)
    {
        return self.a;
    }
    else if (index == 1)
    {
        return self.b;
    }
    
    NSLog(@"ABPair: WARNING -> ABPair only contains 2 objects, use myPair[0] or myPair[1]");
    return nil;
}

-(void) setObject:(id)obj atIndexedSubscript:(NSUInteger)idx
{
    if (idx == 0)
    {
        self.a = obj;
    }
    else if (idx == 1)
    {
        self.b = obj;
    }
    else
    {
        NSLog(@"ABPair: WARNING -> ABPair only contains 2 objects, use myPair[0] or myPair[1]");
    }
}

@end
