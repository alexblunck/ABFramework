//
//  ABCommon.h
//  ABFramework
//
//  Created by Alexander Blunck on 8/27/12.
//  Copyright (c) 2012 Ablfx. All rights reserved.
//

#import <Foundation/Foundation.h>

//NSNumber Fast Creation
NSNumber* NSNumberInteger(NSInteger aInteger);
NSNumber* NSNumberDouble(double aDouble);
NSNumber* NSNumberFloat(CGFloat aFloat);
NSNumber* NSNumberBOOL(BOOL aBoolean);

//NSIndexPath Fast Creation
NSIndexPath* NSIndexPathMake(NSInteger section, NSInteger row);

//Localizable Strings
NSString* nsls(NSString *key);
    
//Type Checking
BOOL isNSArray(id object);
BOOL isNSDictionary(id object);
BOOL isClassOfType(id object, Class aClass);

//Toggle
/**
 * Pass in the memory address of a boolean to change said boolean
 * E.g. toggleBoolean(&myBool);
 */
BOOL toggledBoolean(BOOL aBoolean);

