//
//  ABTabBar.h
//  ABFramework
//
//  Created by Alexander Blunck on 9/7/12.
//  Copyright (c) 2012 Ablfx. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ABTabBarItem;

@protocol ABTabBarDelegate <NSObject>
@optional
-(void) tabBarItemSelected:(ABTabBarItem*)item;
-(void) tabBarItemSelectedDouble:(ABTabBarItem*)item;
@end

@interface ABTabBar : UIView

//Initializer
- (id)initWithTabBarItems:(NSArray*)tabBarItems
             tabBarHeight:(CGFloat)tabBarHeight
      backgroundImageName:(NSString*)backgroundImageName
               tabSpacing:(CGFloat)tabSpacing
                 delegate:(id<ABTabBarDelegate>)delegate;

//Styling
@property (nonatomic, assign) UIBarStyle barStyle;
@property (nonatomic, assign) BOOL translucent;

@property (nonatomic, assign) NSUInteger selectedIndex;

@end
