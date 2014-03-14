//
//  UIScreen+ABFramework.m
//  ABFramework
//
//  Created by Alexander Blunck on 7/23/13.
//  Copyright (c) 2013 Ablfx. All rights reserved.
//

#import "UIScreen+ABFramework.h"

@implementation UIScreen (ABFramework)

+(CGFloat) screenWidth
{
    return [[self mainScreen] bounds].size.width;
}

+(CGFloat) screenHeight
{
    return [[self mainScreen] bounds].size.height;
}

+(CGFloat) screenScale
{
    return [[self mainScreen] scale];
}

+(BOOL) retinaScreen
{
    return ([self screenScale] >= 2.0f);
}

+(CGFloat) keyboardHeight
{
    BOOL portrait = UIInterfaceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation]);
    
    //iPad
    if (IS_IPAD)
    {
        return (portrait) ? 264.0f : 352.0f;
    }
    //iPhone
    else
    {
        return (portrait) ? 216.0f : 162.0f;
    }
    
    return 0;
}

+(CGFloat) statusBarHeight
{
    return [[UIApplication sharedApplication] statusBarFrame].size.height;
}

@end
