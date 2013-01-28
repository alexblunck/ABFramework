//
//  NSString+ABFramework.m
//  ABFramework
//
//  Created by Alexander Blunck on 1/24/13.
//  Copyright (c) 2013 Ablfx. All rights reserved.
//

#import "NSString+ABFramework.h"

@implementation NSString (ABFramework)

-(BOOL) empty
{
    NSString *string = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return (string.length == 0) ? YES : NO;
}

@end
