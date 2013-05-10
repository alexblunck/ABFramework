//
//  NSMutableDictionary+ABFramework.m
//  ABFramework
//
//  Created by Alexander Blunck on 1/23/13.
//  Copyright (c) 2013 Ablfx. All rights reserved.
//

#import "NSMutableDictionary+ABFramework.h"

@implementation NSMutableDictionary (ABFramework)

-(void) safeSetObject:(id)anObject forKey:(id<NSCopying>)aKey
{
    if (anObject != nil && anObject != [NSNull null] && anObject != NULL) {
        [self setObject:anObject forKey:aKey];
    }
}

@end
