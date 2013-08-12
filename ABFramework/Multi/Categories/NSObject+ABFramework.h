//
//  NSObject+ABFramework.h
//  ABFramework
//
//  Created by Alexander Blunck on 1/27/13.
//  Copyright (c) 2013 Ablfx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (ABFramework)

/**
 * Subscript support (Dictionary Style)
 * Override following methods for subscript support on custom objects e.g. :
 * myObject[@"string"]
 */
-(id) objectForKeyedSubscript:(id)key;
-(void) setObject:(id)obj forKeyedSubscript:(id <NSCopying>)key;

/**
 * Subscript support (Array Style)
 * Override following methods for subscript support on custom objects e.g. :
 * myObject[4]
 */
-(id) objectAtIndexedSubscript:(NSUInteger)index;
-(void) setObject:(id)obj atIndexedSubscript:(NSUInteger)idx;

@property (nonatomic, strong) NSDictionary *abUserData;

@end
