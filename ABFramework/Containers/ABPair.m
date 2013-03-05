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

@end
