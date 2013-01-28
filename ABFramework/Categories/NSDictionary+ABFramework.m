//
//  NSDictionary+ABFramework.m
//  ABFramework
//
//  Created by Alexander Blunck on 1/23/13.
//  Copyright (c) 2013 Ablfx. All rights reserved.
//

#import "NSDictionary+ABFramework.h"

@implementation NSDictionary (ABFramework)

-(id) safeObjectForKey:(id)key
{
    id anObject = [self objectForKey:key];
    if (anObject != nil && anObject != [NSNull null] && anObject != NULL) {
        return  anObject;
    }
    return nil;
}

@end
