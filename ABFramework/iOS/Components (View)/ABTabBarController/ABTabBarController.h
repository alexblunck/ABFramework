//
//  ABTabBarController.h
//  ABFramework
//
//  Created by Alexander Blunck on 9/7/12.
//  Copyright (c) 2012 Ablfx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ABTabBarController : UIViewController

//Initializer
-(id) initWithTabBarItems:(NSArray*)tabBarItems;

//Helper
-(void) forceSwitchToTabIndex:(NSInteger)tabIndex;

//Array that holds all ViewControllers available from the TabBar
@property (nonatomic, strong) NSArray *tabBarItems;

@property (nonatomic, strong) ABTabBarItem *activeTabBarItem;

//Height of the TabBar View
@property (nonatomic, assign) CGFloat tabBarHeight;

//Spacing between Tabs
@property (nonatomic, assign) CGFloat tabSpacing;

//TabBar Background Image
@property (nonatomic, copy) NSString *tabBarBackgroundImageName;

//TabBar View
@property (nonatomic, strong) ABTabBar *tabBar;

@property (nonatomic, strong) id activeViewController;

@end