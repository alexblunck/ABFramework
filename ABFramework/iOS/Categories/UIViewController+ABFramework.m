//
//  UIViewController+ABFramework.m
//  ABFramework
//
//  Created by Alexander Blunck on 4/4/13.
//  Copyright (c) 2013 Ablfx. All rights reserved.
//

#import <objc/runtime.h>
#import "UIViewController+ABFramework.h"

@implementation UIViewController (ABFramework)

@dynamic abTabBarController;

#pragma mark - Access
+(UIViewController*) topViewController
{
    UIViewController *topController = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    while (topController.presentedViewController)
    {
        topController = topController.presentedViewController;
    }
    
    return topController;
}



#pragma mark - Frame
-(void) subtractNavigationBarHeight
{
    //Note: No need to remove navigation bar height on iOS 7, it's done automatically
    if (IS_MAX_IOS6X && self.navigationController)
    {
        self.view.frame = CGRectOffsetSizeHeight(self.view.frame, -[self.navigationController navigationBar].height);
    }
}

-(void) subtractStatusBarHeight
{
    self.view.frame = CGRectOffsetSizeHeight(self.view.frame, -[[UIApplication sharedApplication] statusBarFrame].size.height);
}



#pragma mark - Accessors
-(ABTabBarController*) abTabBarController
{
    id a = objc_getAssociatedObject(self, @"ABTabBarController");
    if (!a && self.parentViewController)  a = objc_getAssociatedObject(self.parentViewController, @"ABTabBarController");
    return a;
}
-(void) setAbTabBarController:(ABTabBarController *)abTabBarController
{
    objc_setAssociatedObject(self, @"ABTabBarController", abTabBarController, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
