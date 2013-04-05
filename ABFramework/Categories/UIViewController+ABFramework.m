//
//  UIViewController+ABFramework.m
//  ABFramework
//
//  Created by Alexander Blunck on 4/4/13.
//  Copyright (c) 2013 Ablfx. All rights reserved.
//

#import "UIViewController+ABFramework.h"

@implementation UIViewController (ABFramework)

+(UIViewController*) topViewController
{
    //return [[[[UIApplication sharedApplication] windows] lastObject] rootViewController];
    
    UIViewController *topController = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    while (topController.presentedViewController) {
        topController = topController.presentedViewController;
    }
    
    return topController;
}

@end
