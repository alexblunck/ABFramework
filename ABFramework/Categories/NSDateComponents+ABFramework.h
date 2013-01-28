//
//  NSDateComponents+ABFramework.h
//  ABFramework
//
//  Created by Alexander Blunck on 11/3/12.
//  Copyright (c) 2012 Ablfx. All rights reserved.
//
//  Contains Source Code From:
//  NSDate+MTDates.h
//  Created by Adam Kirk on 4/21/11.
//  Copyright 2011 Mysterious Trousers, LLC. All rights reserved.

#import <Foundation/Foundation.h>

@interface NSDateComponents (ABFramework)

+ (NSDateComponents *)componentsFromString:(NSString *)string;
- (NSString *)stringValue;
- (BOOL)isEqualToDateComponents:(NSDateComponents *)components;

@end
