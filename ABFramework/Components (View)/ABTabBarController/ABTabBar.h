//
//  ABTabBar.h
//  ABFramework
//
//  Created by Alexander Blunck on 9/7/12.
//  Copyright (c) 2012 Ablfx. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ABTabBarDelegate <NSObject>
@optional
-(void) tabBarTabSelected:(id)viewController;
@end

@interface ABTabBar : UIView

//Helper
-(void) forceSwitchToTabIndex:(int)tabIndex;

//Array that holds all ViewControllers available from the TabBar
@property (nonatomic, strong) NSArray *viewControllers;

//Height of the TabBar View
@property (nonatomic, assign) int height;

//Spacing between Tabs
@property (nonatomic, assign) int tabSpacing;

//TabBar Background Image
@property (nonatomic, strong) UIImage *backgroundImage;

//Current Selected ViewController
@property (nonatomic, assign) int selectedIndex;

//Delegate Property
@property (nonatomic, assign) id <ABTabBarDelegate> delegate;

@end
