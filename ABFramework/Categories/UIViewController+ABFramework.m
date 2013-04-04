//
//  UIViewController+ABFramework.m
//  ComingUp iOS
//
//  Created by Alexander Blunck on 4/4/13.
//  Copyright (c) 2013 Ablfx. All rights reserved.
//

#import "UIViewController+ABFramework.h"

@implementation UIViewController (ABFramework)

+(UIViewController*) topViewController
{
    return [[[[UIApplication sharedApplication] windows] lastObject] rootViewController];
}

@end
