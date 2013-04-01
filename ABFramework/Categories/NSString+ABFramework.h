//
//  NSString+ABFramework.h
//  ABFramework
//
//  Created by Alexander Blunck on 1/24/13.
//  Copyright (c) 2013 Ablfx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (ABFramework)

+(NSString*) uniqueString;

-(BOOL) empty;

-(NSString*) encodedString:(NSStringEncoding)encoding;
-(NSString*) asciiEncodedString;
-(NSString*) utf8EncodedString;

@end
