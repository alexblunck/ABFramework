//
//  NSString+ABFramework.m
//  ABFramework
//
//  Created by Alexander Blunck on 1/24/13.
//  Copyright (c) 2013 Ablfx. All rights reserved.
//

#import "NSString+ABFramework.h"

@implementation NSString (ABFramework)

+(NSString*) uniqueString;
{
    CFUUIDRef uuidObj = CFUUIDCreate(nil);
    NSString *uuidString = (NSString*)CFBridgingRelease(CFUUIDCreateString(nil, uuidObj));
    CFRelease(uuidObj);
    return uuidString;
}

-(BOOL) empty
{
    NSString *string = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return (string.length == 0) ? YES : NO;
}

-(NSString*) encodedString:(NSStringEncoding)encoding
{
    return (__bridge NSString *)(CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)self, NULL, (CFStringRef)@"!*'\"();:@&=+$,/?%#[]% ", CFStringConvertNSStringEncodingToEncoding(encoding)));
}

-(NSString*) asciiEncodedString
{
    return [self encodedString:NSASCIIStringEncoding];
}

-(NSString*) utf8EncodedString
{
    return [self encodedString:NSUTF8StringEncoding];
}

@end
