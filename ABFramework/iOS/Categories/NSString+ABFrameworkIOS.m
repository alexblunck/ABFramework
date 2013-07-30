//
//  NSString+ABFrameworkIOS.m
//  ABFramework
//
//  Created by Alexander Blunck on 7/28/13.
//  Copyright (c) 2013 Ablfx. All rights reserved.
//

#import "NSString+ABFrameworkIOS.h"

@implementation NSString (ABFrameworkIOS)

-(CGFloat) heightToFitTextInLabel:(UILabel*)label
{
    return [self heightToFitTextInLabel:label maxHeight:FLT_MAX];
}

-(CGFloat) heightToFitTextInLabel:(UILabel*)label maxHeight:(CGFloat)maxHeight
{
    return [self heightToFitTextInLabelWithFont:label.font fixedWidth:label.bounds.size.width maxHeight:maxHeight];
}

-(CGFloat) heightToFitTextInLabelWithFont:(UIFont*)font fixedWidth:(CGFloat)fixedWidth maxHeight:(CGFloat)maxHeight
{
    CGSize maxSize = CGSizeMake(fixedWidth, maxHeight);
    
    NSAttributedString *string = [[NSAttributedString alloc] initWithString:self attributes:@{NSFontAttributeName: font}];
    
    CGRect rect = [string boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin context:nil];
    
    CGFloat calculatedHeight = rect.size.height;
    
    return calculatedHeight;
}

@end
