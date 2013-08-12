//
//  NSObject+ABFramework.m
//  ABFramework
//
//  Created by Alexander Blunck on 1/27/13.
//  Copyright (c) 2013 Ablfx. All rights reserved.
//

#import <objc/runtime.h>
#import "NSObject+ABFramework.h"

@implementation NSObject (ABFramework)

@dynamic abUserData;

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



#pragma mark - Accessors
-(NSDictionary*) abUserData
{
    NSDictionary *dic = objc_getAssociatedObject(self, @"abUserData");
    return dic;
}
-(void) setAbUserData:(NSDictionary *)abUserData
{
    objc_setAssociatedObject(self, @"abUserData", abUserData, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
