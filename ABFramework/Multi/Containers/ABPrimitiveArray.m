//
//  ABPrimitiveArray.m
//  ABFramework
//
//  Created by Alexander Blunck on 3/30/13.
//  Copyright (c) 2013 Ablfx. All rights reserved.
//

#import "ABPrimitiveArray.h"



#pragma mark - ABPrimitiveArray
@interface ABPrimitiveArray ()
@property (nonatomic, assign) ABPrimitiveArrayType type;
@end



@implementation ABPrimitiveArray



#pragma mark - Common
#pragma mark - Initializer
-(id) init
{
    self = [super init];
    if (self)
    {
        //Allocation
        self.objectArray = [NSMutableArray new];
    }
    return self;
}

#pragma mark - Delete
-(void) removeAllPrimitives
{
    [self.objectArray removeAllObjects];
}

-(void) removePrimitiveAtIndex:(NSUInteger)index
{
    [self.objectArray removeObjectAtIndex:index];
}

#pragma mark - Description
-(NSString*) description
{
    NSMutableString *string = [[NSMutableString alloc] initWithString:@"{\n"];
    
    for (id object in self.objectArray)
    {
        [string appendString:@"\t"];
        [string appendString:[NSString stringWithFormat:@"%@", object]];
        [string appendString:@"\n"];
    }
    
    [string appendString:@"}\n"];
    
    return string;
}



#pragma mark - CGRect
#pragma mark - Utility
+(id) arrayWithRects:(CGRect)firstRect, ...
{
    ABPrimitiveArray *array = [ABPrimitiveArray new];
    array.type = ABPrimitiveArrayTypeCGRect;
    
    va_list args;
    va_start(args, firstRect);
    for (CGRect rect = firstRect; !CGRectIsNull(rect); rect = va_arg(args, CGRect))
    {
        [array addRect:rect];
    }
    va_end(args);
    
    return array;
}

#pragma mark - Initializer
-(id) initWithRects:(CGRect)firstRect, ...
{
    self = [super init];
    if (self)
    {
        _type = ABPrimitiveArrayTypeCGRect;
        
        va_list args;
        va_start(args, firstRect);
        for (CGRect rect = firstRect; !CGRectIsNull(rect); rect = va_arg(args, CGRect))
        {
            [self addRect:rect];
        }
        va_end(args);
    }
    return self;
}

#pragma mark - Add
-(void) addRect:(CGRect)rect
{
    _type = ABPrimitiveArrayTypeCGRect;
    
    [self.objectArray addObject:[self objectFromRect:rect]];
}

-(void) addRects:(CGRect)firstRect, ...
{
    _type = ABPrimitiveArrayTypeCGRect;
    
    va_list args;
    va_start(args, firstRect);
    for (CGRect rect = firstRect; !CGRectIsNull(rect); rect = va_arg(args, CGRect))
    {
        [self addRect:rect];
    }
    va_end(args);
}

#pragma mark - Select
-(CGRect) rectAtIndex:(NSUInteger)index
{
    return [self rectFromObject:[self.objectArray safeObjectAtIndex:index]];
}

#pragma mark - Enumerate
-(void) enumerateRectsUsingBlock:(void (^) (CGRect rect, NSUInteger idx))block
{
    for (id object in self.objectArray)
    {
        if (block)
        {
            block([self rectFromObject:object], [self.objectArray indexOfObject:object]);
        }
    }
}

#pragma mark - Helper
-(id) objectFromRect:(CGRect)rect
{
    return @{
             @"x": NSNumberFloat(rect.origin.x),
             @"y": NSNumberFloat(rect.origin.y),
             @"width": NSNumberFloat(rect.size.width),
             @"height": NSNumberFloat(rect.size.height),
             };
}

-(CGRect) rectFromObject:(id)object
{
    CGFloat x = [[object safeObjectForKey:@"x"] floatValue];
    CGFloat y = [[object safeObjectForKey:@"y"] floatValue];
    CGFloat width = [[object safeObjectForKey:@"width"] floatValue];
    CGFloat height = [[object safeObjectForKey:@"height"] floatValue];
    return cgr(x, y, width, height);
}



#pragma mark - CGFloat
#pragma mark - Utility
+(id) arrayWithFloats:(CGFloat)firstFloat, ...
{
    ABPrimitiveArray *array = [ABPrimitiveArray new];
    array.type = ABPrimitiveArrayTypeCGFloat;
    
    va_list args;
    va_start(args, firstFloat);
    for (double aFloat = firstFloat; aFloat != CGFLOAT_TERM; aFloat = va_arg(args, double))
    {
        [array addFloat:aFloat];
    }
    va_end(args);
    
    return array;
}

#pragma mark - Initializer
-(id) initWithFloats:(CGFloat)firstFloat, ...
{
    self = [super init];
    if (self)
    {
        _type = ABPrimitiveArrayTypeCGFloat;
        
        va_list args;
        va_start(args, firstFloat);
        for (double aFloat = firstFloat; aFloat != CGFLOAT_TERM; aFloat = va_arg(args, double))
        {
            [self addFloat:aFloat];
        }
        va_end(args);
    }
    return self;
}

#pragma mark - Add
-(void) addFloat:(CGFloat)aFloat
{
    _type = ABPrimitiveArrayTypeCGFloat;
    
    [self.objectArray addObject:[NSNumber numberWithFloat:aFloat]];
}

-(void) addFloats:(CGFloat)firstFloat, ...
{
    _type = ABPrimitiveArrayTypeCGFloat;
    
    va_list args;
    va_start(args, firstFloat);
    for (double aFloat = firstFloat; aFloat != CGFLOAT_TERM; aFloat = va_arg(args, double))
    {
        [self addFloat:aFloat];
    }
    va_end(args);
}

#pragma mark - Select
-(CGFloat) floatAtIndex:(NSUInteger)index
{
    return [[self.objectArray safeObjectAtIndex:index] floatValue];
}

#pragma mark - Enumerate
-(void) enumerateFloatsUsingBlock:(void (^) (CGFloat aFloat, NSUInteger idx))block
{
    for (NSNumber *object in self.objectArray)
    {
        if (block)
        {
            block([object floatValue], [self.objectArray indexOfObject:object]);
        }
    }
}



#pragma mark - Accessors
#pragma mark - count
-(NSUInteger) count
{
    return self.objectArray.count;
}
@end
