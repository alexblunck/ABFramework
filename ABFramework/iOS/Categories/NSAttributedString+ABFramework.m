//
//  NSAttributedString+ABFramework.m
//  
//
//  Created by Alexander Blunck on 17/03/14.
//
//

#import "NSAttributedString+ABFramework.h"

@implementation NSAttributedString (ABFramework)



#pragma mark - Fast Creation
#pragma mark - Fast Creation - Multiple
+(instancetype) stringWithAttributedStrings:(NSArray*)strings
{
    return [self stringWithAttributedStrings:strings lineBreaks:NO];
}

+(instancetype) stringWithAttributedStrings:(NSArray*)strings lineBreaks:(BOOL)lineBreaks
{
    NSMutableAttributedString *mutableString = [NSMutableAttributedString new];
    
    [mutableString appendAttributedStrings:strings lineBreaks:lineBreaks];
    
    return [[self alloc] initWithAttributedString:mutableString];
}


#pragma mark - Fast Creation - Single
+(instancetype) stringWithString:(NSString*)string
{
    return [self stringWithString:string font:nil color:nil];
}

+(instancetype) stringWithString:(NSString*)string font:(UIFont*)font
{
    return [self stringWithString:string font:font color:nil];
}

+(instancetype) stringWithString:(NSString*)string color:(UIColor*)color
{
    return [self stringWithString:string font:nil color:color];
}

+(instancetype) stringWithString:(NSString*)string font:(UIFont*)font color:(UIColor*)color
{
    return [self stringWithString:string font:font color:color paragraph:nil];
}

+(instancetype) stringWithString:(NSString*)string font:(UIFont*)font lineSpacing:(CGFloat)lineSpacing
{
    return [self stringWithString:string font:font color:nil lineSpacing:lineSpacing];
}

+(instancetype) stringWithString:(NSString*)string font:(UIFont*)font color:(UIColor*)color lineSpacing:(CGFloat)lineSpacing
{
    NSMutableParagraphStyle *style = [NSMutableParagraphStyle new];
    style.lineSpacing = lineSpacing;
    
    return [self stringWithString:string font:font color:color paragraph:style];
}

+(instancetype) stringWithString:(NSString*)string font:(UIFont*)font color:(UIColor*)color paragraph:(NSParagraphStyle*)paragraph
{
    NSMutableDictionary *attributes = [NSMutableDictionary new];
    
    if (font)
    {
        [attributes setValue:font forKey:NSFontAttributeName];
    }
    
    if (color)
    {
        [attributes setValue:color forKey:NSForegroundColorAttributeName];
    }
    
    if (paragraph)
    {
        [attributes setValue:paragraph forKey:NSParagraphStyleAttributeName];
    }
    
    return [[NSAttributedString alloc] initWithString:string attributes:[NSDictionary dictionaryWithDictionary:attributes]];
}


#pragma mark - Fast Creation - Special
+(instancetype) emptyString
{
    return [self stringWithString:@""];
}

+(instancetype) newLineString
{
    return [self stringWithString:@"\n"];
}


@end
