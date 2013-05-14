//
//  NSArray+ABFramework.h
//  ABFramework
//
//  Created by Alexander Blunck on 4/17/13.
//  Copyright (c) 2013 Ablfx. All rights reserved.
//

#import "NSArray+ABFramework.h"

@implementation NSArray (ABFramework)

-(NSString*) jsonString
{
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:0 error:nil];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

-(id) safeObjectAtIndex:(NSUInteger)index
{
    if (self.count >= index+1)
    {
        return [self objectAtIndex:index];
    }
    NSLog(@"NSArray+ABFramework: Warning -> Attempted to access non existent index[%li]", (long)index);
    return nil;
}

-(NSArray*) arrayByAddingObject:(id)object
{
    NSMutableArray *array = [NSMutableArray arrayWithArray:self];
    [array addObject:object];
    return [NSArray arrayWithArray:array];
}

@end
