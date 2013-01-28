//
//  ABTabBarController.h
//  ABFramework
//
//  Created by Alexander Blunck on 9/7/12.
//  Copyright (c) 2012 Ablfx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ABTabBarController : UIViewController

-(id) initWithViewControllers:(NSArray*)viewControllers;

//Array that holds all ViewControllers available from the TabBar
@property (nonatomic, strong) NSArray *viewControllers;

//The ViewController that is shown initially by the Tab Controller
@property (nonatomic, strong) id defaultViewController;

//Height of the TabBar View
@property (nonatomic, assign) int tabBarHeight;

//Spacing between Tabs
@property (nonatomic, assign) int tabSpacing;

//TabBar Background Image
@property (nonatomic, strong) UIImage *tabBarBackgroundImage;

//TabBar View
@property (nonatomic, strong) ABTabBar *tabBar;

//Force a view switch to a specific tab index (0 based)
-(void) forceSwitchToTabIndex:(int)tabIndex;

-(id) activeViewController;

@end