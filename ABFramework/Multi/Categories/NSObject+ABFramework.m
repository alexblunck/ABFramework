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

@dynamic abUserData, abUserObject;

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



#pragma mark - Perform Block
-(void) performBlock:(ABBlockVoid)block afterDelay:(NSTimeInterval)delay
{
    [self performSelector:@selector(executeBlock:) withObject:[block copy] afterDelay:delay];
}

-(void) executeBlock:(ABBlockVoid)block
{
    block();
}



#pragma mark - Collections
-(BOOL) isFirstObject:(NSArray*)collection
{
    if ([collection isKindOfClass:[NSArray class]])
    {
        return ([collection indexOfObject:self] == 0);
    }
    return NO;
}

-(BOOL) isLastObject:(NSArray*)collection
{
    if ([collection isKindOfClass:[NSArray class]])
    {
        return ([collection indexOfObject:self] == collection.count - 1);
    }
    return NO;
}



#pragma mark - Accessors
-(NSDictionary*) abUserData
{
    return objc_getAssociatedObject(self, @"abUserData");
}
-(void) setAbUserData:(NSDictionary *)abUserData
{
    objc_setAssociatedObject(self, @"abUserData", abUserData, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSDictionary*) abUserObject
{
    return objc_getAssociatedObject(self, @"abUserObject");
}
-(void) setAbUserObject:(id)abUserObject
{
    objc_setAssociatedObject(self, @"abUserObject", abUserObject, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
