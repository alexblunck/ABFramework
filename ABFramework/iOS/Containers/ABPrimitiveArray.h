//
//  ABPrimitiveArray.h
//  ABFramework
//
//  Created by Alexander Blunck on 3/30/13.
//  Copyright (c) 2013 Ablfx. All rights reserved.
//

#import <Foundation/Foundation.h>

//Terminators
#define CGFLOAT_TERM -12345.6789f
#define CGRECT_TERM CGRectNull

typedef enum {
    ABPrimitiveArrayTypeNone,
    ABPrimitiveArrayTypeCGFloat,
    ABPrimitiveArrayTypeCGRect
} ABPrimitiveArrayType;

@interface ABPrimitiveArray : NSObject

//CGRect
/**
 * NOTE:
 * Terminate CGRect list with CGRECT_TERM
 */
//Utility
+(id) arrayWithRects:(CGRect)firstRect, ...;
//Initializer
-(id) initWithRects:(CGRect)firstRect, ...;
//Add
-(void) addRect:(CGRect)rect;
-(void) addRects:(CGRect)firstRect, ...;
//Select
-(CGRect) rectAtIndex:(NSUInteger)index;
//Enumerate
-(void) enumerateRectsUsingBlock:(void (^) (CGRect rect, NSUInteger idx))block;


//CGFloat
/**
 * NOTE:
 * Terminate CGFloat list with CGFLOAT_TERM
 */
//Utility
+(id) arrayWithFloats:(CGFloat)firstFloat, ...;
//Initializer
-(id) initWithFloats:(CGFloat)firstFloat, ...;
//Add
-(void) addFloat:(CGFloat)aFloat;
-(void) addFloats:(CGFloat)firstFloat, ...;
//Select
-(CGFloat) floatAtIndex:(NSUInteger)index;
//Enumerate
-(void) enumerateFloatsUsingBlock:(void (^) (CGFloat aFloat, NSUInteger idx))block;


//Common
//Remove
-(void) removeAllPrimitives;
-(void) removePrimitiveAtIndex:(NSUInteger)index;



//Properties
/**
 * Array that hold all primitive wrapping objects
 */
@property (nonatomic, strong) NSMutableArray *objectArray;

/**
 * Type of array, one primitive array can only carry primitives of the same data type
 */


/**
 * Retunrs number of primitives in array
 */
@property (nonatomic, assign, readonly) NSUInteger count;

@end
