//
//  ABTabBarController.h
//  ABFramework
//
//  Created by Alexander Blunck on 9/7/12.
//  Copyright (c) 2012 Ablfx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ABTabBarController : UIViewController

/**
 * Initializer
 *
 * tabBarItems: Array of ABTabBarItems
 */
-(id) initWithTabBarItems:(NSArray*)tabBarItems;



/**
 * tabBar
 * Underlying ABTabBar view
 */
@property (nonatomic, strong, readonly) ABTabBar *tabBar;

/**
 * tabBarItems
 * ABTabBarItem 's
 */
@property (nonatomic, strong, readonly) NSArray *tabBarItems;

/**
 * selectedIndex
 * Current selected tab index, change to switch tabs / views
 */
@property (nonatomic, assign) NSUInteger selectedIndex;

/**
 * activeTabBarItem
 * Currently active ABTabBarItem
 */
@property (nonatomic, weak, readonly) ABTabBarItem *activeTabBarItem;

/**
 * activeViewController
 * Currently active view controller
 */
@property (nonatomic, weak, readonly) id activeViewController;



//Config
/**
 * tabBarHeight
 * Height of the tabbar, Default: 49.0f
 */
@property (nonatomic, assign) CGFloat tabBarHeight;

/**
 * tabSpacing
 * Spacing between tab view, Default: 0.0f
 */
@property (nonatomic, assign) CGFloat tabSpacing;

/**
 * backgroundImageName
 * Image name of tabbar background, otherwise it will use default UIToolbar appearance
 */
@property (nonatomic, copy) NSString *backgroundImageName;

/**
 * doubleTouchHandler
 * Block is executed when a tab selected while already selected
 */
@property (nonatomic, copy) ABBlockInteger doubleTouchHandler;

@end