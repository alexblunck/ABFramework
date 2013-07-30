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

#pragma mark - Storyboard
+(id) instantiateWithStoryboardName:(NSString*)name
{
    return [self instantiateWithStoryboardName:name identifier:nil];
}

+(id) instantiateWithStoryboardName:(NSString*)name identifier:(NSString*)identifier
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:name bundle:nil];
    if (identifier)
    {
        return [storyboard instantiateViewControllerWithIdentifier:identifier];
    }
    else
    {
        return [storyboard instantiateInitialViewController];
    }
    return nil;
}



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



#pragma mark - Helper
-(UINavigationController*) wrapInNavigationController
{
    return [[UINavigationController alloc] initWithRootViewController:self];
}



#pragma mark - Type
-(BOOL) wasPresented
{
    return ([self.navigationController.viewControllers safeObjectAtIndex:0] == self);
}

-(BOOL) wasPushed
{
    return (![self wasPresented]);
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
