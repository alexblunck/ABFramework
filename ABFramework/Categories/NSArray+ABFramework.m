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

@end
