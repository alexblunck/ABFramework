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

//Storyboard
+(id) instantiateWithStoryboardName:(NSString*)name;
+(id) instantiateWithStoryboardName:(NSString*)name identifier:(NSString*)identifier;

//Access
+(UIViewController*) topViewController;

//Helper
-(UINavigationController*) wrapInNavigationController;

//Type
-(BOOL) wasPresented;
-(BOOL) wasPushed;

@property (nonatomic, weak) ABTabBarController *abTabBarController;

@end
