//
//  NSString+ABFramework.h
//  ABFramework
//
//  Created by Alexander Blunck on 1/24/13.
//  Copyright (c) 2013 Ablfx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (ABFramework)

//Utility
+(NSString*) uniqueString;

//Checking / Comparing
-(BOOL) isEqualToStringU:(NSString *)aString; 
-(BOOL) empty;

//Replace
-(NSString*) stringByTrimmingWhiteSpace:(NSString*)string;

//Encoding
-(NSString*) encodedString:(NSStringEncoding)encoding;
-(NSString*) asciiEncodedString;
-(NSString*) utf8EncodedString;

//Regular Expressions
-(NSString*) substringAtGroupIndex:(NSUInteger)index forPattern:(NSString*)regexPattern;
-(BOOL) matchesPattern:(NSString*)regexPattern;

//Conversion
-(NSURL*) url;
-(NSURLRequest*) urlRequest;

@end
