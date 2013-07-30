//
//  UIColor+ABFramework.m
//  ABFramework
//
//  Created by Alexander Blunck on 3/4/13.
//  Copyright (c) 2013 Ablfx. All rights reserved.
//
//  Source: http://stackoverflow.com/questions/1560081/how-can-i-create-a-uicolor-from-a-hex-string
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

//Source: https://gist.github.com/iwill/957471
-(UIColor*) colorInverted
{
    CGColorRef oldCGColor = self.CGColor;
    int numberOfComponents = CGColorGetNumberOfComponents(oldCGColor);
    
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

@end