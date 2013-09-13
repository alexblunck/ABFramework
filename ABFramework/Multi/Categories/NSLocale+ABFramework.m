//
//  NSLocale+ABFramework.m
//  ABFramework
//
//  Created by Alexander Blunck on 9/11/13.
//  Copyright (c) 2013 Ablfx. All rights reserved.
//

#import "NSLocale+ABFramework.h"

@implementation NSLocale (ABFramework)

+(BOOL) preferredLanguageIsEnglish
{
    return [[[NSLocale preferredLanguages] firstObject] isEqualToStringU:@"en"];
}

+(BOOL) preferredLanguageIsGerman
{
    return [[[NSLocale preferredLanguages] firstObject] isEqualToStringU:@"de"];
}
    
@end
