//
//  UIFont+ABFramework.m
//  ABFramework
//
//  Created by Alexander Blunck on 5/22/13.
//  Copyright (c) 2013 Ablfx. All rights reserved.
//

#import "UIFont+ABFramework.h"
#import <CoreText/CoreText.h>

@implementation UIFont (ABFramework)

+(BOOL) fontWithNameExists:(NSString*)name
{
    NSArray *familyNames = [UIFont familyNames];
    for (NSString *familyName in familyNames)
    {
        NSArray *fontNames = [UIFont fontNamesForFamilyName:familyName];
        for (NSString *fontName in fontNames)
        {
            if ([fontName isEqualToString:name])
            {
                return YES;
            }
        }
    }
    return NO;
}

+(UIFont*) customFontWithName:(NSString*)fontName fontPath:(NSString*)fontPath extension:(NSString*)extension size:(CGFloat)size
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        NSURL *url = [[NSBundle mainBundle] URLForResource:fontPath withExtension:extension];

        CTFontManagerRegisterFontsForURL((__bridge CFURLRef)url, kCTFontManagerScopeProcess, nil);
        
    });
    
    UIFont *font = [UIFont fontWithName:fontName size:size];
    
    return font;
}

@end
