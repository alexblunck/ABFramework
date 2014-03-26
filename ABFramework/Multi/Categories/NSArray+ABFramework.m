//
//  NSArray+ABFramework.h
//  ABFramework
//
//  Created by Alexander Blunck on 4/17/13.
//  Copyright (c) 2013 Ablfx. All rights reserved.
//

#import "NSArray+ABFramework.h"

@implementation NSArray (ABFramework)

#pragma mark - Conversion
-(NSString*) jsonString
{
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:0 error:nil];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}



#pragma mark - Safe Access
-(id) safeObjectAtIndex:(NSInteger)index
{
    return [self safeObjectAtIndex:index verbose:YES];
}

-(id) safeObjectAtIndex:(NSInteger)index verbose:(BOOL)verbose
{
    if (index >= 0 && self.count >= index + 1)
    {
        return [self objectAtIndex:index];
    }
    if (verbose) NSLog(@"NSArray+ABFramework: Warning -> Attempted to access non existent index[%li] in Array: %@", (long)index, self);
    return nil;
}



#pragma mark - Add
-(NSArray*) arrayByAddingObject:(id)object
{
    NSMutableArray *array = [NSMutableArray arrayWithArray:self];
    [array addObject:object];
    return [NSArray arrayWithArray:array];
}



#pragma mark - Remove
-(NSArray*) arrayByRemovingObject:(id)object
{
    NSMutableArray *array = [NSMutableArray arrayWithArray:self];
    [array removeObject:object];
    return [NSArray arrayWithArray:array];
}

@end
