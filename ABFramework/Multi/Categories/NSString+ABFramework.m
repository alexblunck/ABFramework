//
//  NSString+ABFramework.m
//  ABFramework
//
//  Created by Alexander Blunck on 1/24/13.
//  Copyright (c) 2013 Ablfx. All rights reserved.
//

#import "NSString+ABFramework.h"

@implementation NSString (ABFramework)

#pragma mark - Utility
+(NSString*) uniqueString;
{
    CFUUIDRef uuidObj = CFUUIDCreate(nil);
    NSString *uuidString = (NSString*)CFBridgingRelease(CFUUIDCreateString(nil, uuidObj));
    CFRelease(uuidObj);
    return uuidString;
}



#pragma mark - Checking / Comparing
-(BOOL) isEqualToStringU:(NSString *)aString
{
    return [[self lowercaseString] isEqualToString:[aString lowercaseString]];
}

-(BOOL) empty
{
    NSString *string = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return (string.length == 0) ? YES : NO;
}



#pragma mark - Replace
-(NSString*) stringByTrimmingWhiteSpace:(NSString*)string
{
    return [self stringByReplacingOccurrencesOfString:@" " withString:@""];
}



#pragma mark - Encoding
-(NSString*) encodedString:(NSStringEncoding)encoding
{
    return (__bridge_transfer NSString *)(CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)self, NULL, (CFStringRef)@"!*'\"();:@&=+$,/?%#[]% ", CFStringConvertNSStringEncodingToEncoding(encoding)));
}

-(NSString*) asciiEncodedString
{
    return [self encodedString:NSASCIIStringEncoding];
}

-(NSString*) utf8EncodedString
{
    return [self encodedString:NSUTF8StringEncoding];
}



#pragma mark - Regular Expressions
-(NSString*) substringAtGroupIndex:(NSUInteger)index forPattern:(NSString*)regexPattern
{
    NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regexPattern options:NSRegularExpressionCaseInsensitive error:&error];
    
    NSTextCheckingResult *result = [regex firstMatchInString:self options:0 range:NSMakeRange(0, [self length])];
    
    //Make sure index isn't out of range
    if (index <= [result numberOfRanges]-1)
    {
        return [self substringWithRange:[result rangeAtIndex:index]];
    }
    
    NSLog(@"NSString+ABFramework: WARNING -> substringAtGroupIndex:forPattern: -> Index out of range!");
    return nil;
}

-(BOOL) matchesPattern:(NSString*)regexPattern
{
    NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regexPattern options:NSRegularExpressionCaseInsensitive error:&error];
    
    NSUInteger numberOfMatches = [regex numberOfMatchesInString:self options:0 range:NSMakeRange(0, [self length])];
    
    if (numberOfMatches != 0)
    {
        return YES;
    }
    return NO;
}


#pragma mark - Conversion
-(NSURL*) url
{
    return [NSURL URLWithString:self];
}

-(NSURLRequest*) urlRequest
{
    return [NSURLRequest requestWithURL:[self url]];
}

-(NSAttributedString*) attributedString
{
    return [[NSAttributedString alloc] initWithString:self];
}

-(NSAttributedString*) attributedStringWithFont:(UIFont*)font
{
    return [self attributedStringWithAttributes:@{NSFontAttributeName: font}];
}

-(NSAttributedString*) attributedStringWithAttributes:(NSDictionary*)attributes
{
    return [[NSAttributedString alloc] initWithString:self attributes:attributes];
}

@end
