//
//  UIViewController+ABFramework.h
//  ABFramework
//
//  Created by Alexander Blunck on 4/4/13.
//  Copyright (c) 2013 Ablfx. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ABTabBarController;

@interface UIViewController (ABFramework)

//Access
+(UIViewController*) topViewController;

//Frame
-(void) subtractNavigationBarHeight;
-(void) subtractStatusBarHeight;

@property (nonatomic, weak) ABTabBarController *abTabBarController;

@end
