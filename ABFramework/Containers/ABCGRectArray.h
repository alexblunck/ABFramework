//
//  ABCGRectArray.h
//  Serrano iOS
//
//  Created by Alexander Blunck on 3/30/13.
//  Copyright (c) 2013 Serrano - Ablfx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ABCGRectArray : ABPrimitiveArray

//Utility
/**
 * Factory method for creating array of CGRects
 * NOTE! Terminate argument list with CGRectNull
 */
+(id) arrayWithRects:(CGRect)firstRect, ...;


//Initializer
/**
 * NOTE! Terminate argument list with CGRectNull
 */
-(id) initWithRects:(CGRect)firstRect, ...;


//Add
-(void) addRect:(CGRect)rect;
/**
 * NOTE! Terminate argument list with CGRectNull
 */
-(void) addRects:(CGRect)firstRect, ...;


//Remove
-(void) removeAllRects;
-(void) removeRectAtIndex:(NSUInteger)index;


//Query
-(CGRect) rectAtIndex:(NSUInteger)index;


//Enumeration
-(void) enumerateRectsUsingBlock:(void (^) (CGRect rect, NSUInteger idx))block;

@end
