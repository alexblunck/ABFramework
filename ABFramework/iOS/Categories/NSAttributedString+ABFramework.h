//
//  NSAttributedString+ABFramework.h
//  
//
//  Created by Alexander Blunck on 17/03/14.
//
//

#import <Foundation/Foundation.h>

@interface NSAttributedString (ABFramework)

// Fast Creation - Multiple
+(instancetype) stringWithAttributedStrings:(NSArray*)strings;
+(instancetype) stringWithAttributedStrings:(NSArray*)strings lineBreaks:(BOOL)lineBreaks;

// Fast Creation - Single
+(instancetype) stringWithString:(NSString*)string;
+(instancetype) stringWithString:(NSString*)string font:(UIFont*)font;
+(instancetype) stringWithString:(NSString*)string color:(UIColor*)color;
+(instancetype) stringWithString:(NSString*)string font:(UIFont*)font color:(UIColor*)color;
+(instancetype) stringWithString:(NSString*)string font:(UIFont*)font lineSpacing:(CGFloat)lineSpacing;
+(instancetype) stringWithString:(NSString*)string font:(UIFont*)font color:(UIColor*)color lineSpacing:(CGFloat)lineSpacing;
+(instancetype) stringWithString:(NSString*)string font:(UIFont*)font color:(UIColor*)color paragraph:(NSParagraphStyle*)paragraph;

// Fast Creation - Special
+(instancetype) emptyString;
+(instancetype) newLineString;

@end
