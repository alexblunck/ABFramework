//
//  UIColor+ABFramework.m
//  ABFramework
//
//  Created by Alexander Blunck on 3/4/13.
//  Copyright (c) 2013 Ablfx. All rights reserved.
//
//  Sources:
//  http://stackoverflow.com/questions/1560081/how-can-i-create-a-uicolor-from-a-hex-string
//  https://gist.github.com/iwill/957471
//  http://stackoverflow.com/questions/11598043/get-slightly-lighter-and-darker-color-from-uicolor
//

#import "UIColor+ABFramework.h"

@implementation UIColor (ABFramework)

+(UIColor*) colorWithHexString:(NSString*)hexString
{
    NSString *colorString = [[hexString stringByReplacingOccurrencesOfString: @"#" withString: @""] uppercaseString];

    CGFloat alpha = 1.0f;
    CGFloat red   = [self colorComponentFrom: colorString start: 0 length: 2];
    CGFloat green = [self colorComponentFrom: colorString start: 2 length: 2];
    CGFloat blue  = [self colorComponentFrom: colorString start: 4 length: 2];
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

+(CGFloat) colorComponentFrom:(NSString*) string start:(NSUInteger) start length:(NSUInteger)length
{
    NSString *substring = [string substringWithRange:NSMakeRange(start, length)];
    NSString *fullHex = length == 2 ? substring : [NSString stringWithFormat:@"%@%@", substring, substring];
    unsigned hexComponent;
    [[NSScanner scannerWithString:fullHex] scanHexInt:&hexComponent];
    return hexComponent / 255.0;
}



#pragma mark - Manipulation
-(UIColor*) colorInverted
{
    CGColorRef oldCGColor = self.CGColor;
    NSInteger numberOfComponents = CGColorGetNumberOfComponents(oldCGColor);
    
    if (numberOfComponents <= 1) {
        return [UIColor colorWithCGColor:oldCGColor];
    }
    
    const CGFloat *oldComponentColors = CGColorGetComponents(oldCGColor);
    CGFloat newComponentColors[numberOfComponents];
    int i = - 1;
    while (++i < numberOfComponents - 1) {
        newComponentColors[i] = 1 - oldComponentColors[i];
    }
    newComponentColors[i] = oldComponentColors[i]; // alpha
    
    CGColorRef newCGColor = CGColorCreate(CGColorGetColorSpace(oldCGColor), newComponentColors);
    UIColor *newColor = [UIColor colorWithCGColor:newCGColor];
    CGColorRelease(newCGColor);
    
    return newColor;
}

-(UIColor*) darkenColor:(CGFloat)value
{
    CGFloat h, s, b, a;
    if ([self getHue:&h saturation:&s brightness:&b alpha:&a])
    {
        return [UIColor colorWithHue:h saturation:s brightness:b * value alpha:a];
    }
    return nil;
}

-(UIColor*) lightenColor:(CGFloat)value
{
    CGFloat h, s, b, a;
    if ([self getHue:&h saturation:&s brightness:&b alpha:&a])
    {
        return [UIColor colorWithHue:h saturation:s brightness:MIN(b * value, 1.0) alpha:a];
    }
    return nil;
}

@end