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
-(void) tabBarItemSelected:(ABTabBarItem*)item;
@end

@interface ABTabBar : UIView

//Helper
-(void) forceSwitchToTabIndex:(NSInteger)tabIndex;

//Array that holds all ViewControllers available from the TabBar
@property (nonatomic, strong) NSArray *tabBarItems;

//Height of the TabBar View
@property (nonatomic, assign) CGFloat height;

//Spacing between Tabs
@property (nonatomic, assign) CGFloat tabSpacing;

//TabBar Background Image
@property (nonatomic, copy) NSString *backgroundImageName;

//Current Selected ViewController
@property (nonatomic, assign) NSInteger selectedIndex;

//Delegate Property
@property (nonatomic, weak) id <ABTabBarDelegate> delegate;

@end
