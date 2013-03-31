//
//  ABCGRectArray.m
//  ABFramework
//
//  Created by Alexander Blunck on 3/30/13.
//  Copyright (c) 2013 Ablfx. All rights reserved.
//

#import "ABCGRectArray.h"

#pragma marlk- ABCGRect
@interface ABCGRect : NSObject
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@end

@implementation ABCGRect
@end



#pragma mark - ABCGRectArray
@implementation ABCGRectArray

#pragma mark - Utility
+(id) arrayWithRects:(CGRect)firstRect, ...
{
    ABCGRectArray *array = [ABCGRectArray new];
    
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
    [self.objectArray addObject:[self objectFromRect:rect]];
}

-(void) addRects:(CGRect)firstRect, ...
{
    va_list args;
    va_start(args, firstRect);
    for (CGRect rect = firstRect; !CGRectIsNull(rect); rect = va_arg(args, CGRect))
    {
        [self addRect:rect];
    }
    va_end(args);
}



#pragma mark - Remove
-(void) removeAllRects
{
    [self.objectArray removeAllObjects];
}

-(void) removeRectAtIndex:(NSUInteger)index
{
    [self.objectArray removeObjectAtIndex:index];
}



#pragma mark - Query
-(CGRect) rectAtIndex:(NSUInteger)index
{
    return [self rectFromObject:[self.objectArray objectAtIndex:index]];
}



#pragma mark - Enumeration
-(void) enumerateRectsUsingBlock:(void (^) (CGRect rect, NSUInteger idx))block
{
    for (ABCGRect *object in self.objectArray)
    {
        if (block)
        {
            block([self rectFromObject:object], [self.objectArray indexOfObject:object]);
        }
    }
}



#pragma mark - Conversion
-(ABCGRect*) objectFromRect:(CGRect)rect
{
    ABCGRect *object = [ABCGRect new];
    object.x = rect.origin.x;
    object.y = rect.origin.y;
    object.width = rect.size.width;
    object.height = rect.size.height;
    return object;
}

-(CGRect) rectFromObject:(ABCGRect*)object
{
    return cgr(object.x, object.y, object.width, object.height);
}



#pragma mark - Overrides
-(NSString*) description
{
    NSMutableString *string = [[NSMutableString alloc] initWithString:@"{\n"];
    
    [self enumerateRectsUsingBlock:^(CGRect rect, NSUInteger idx) {
        //
        [string appendString:@"\t"];
        [string appendString:NSStringFromCGRect(rect)];
        [string appendString:@"\n"];
    }];
    
    [string appendString:@"}\n"];
    
    return string;
}

@end
