//
//  UIApplication+ABFramework.m
//  ABFramework
//
//  Created by Alexander Blunck on 9/8/13.
//  Copyright (c) 2013 Ablfx. All rights reserved.
//

#import "UIApplication+ABFramework.h"

@implementation UIApplication (ABFramework)

+(NSString*) applicationName
{
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"];
}

+(NSString*) applicationVersion
{
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
}

@end
