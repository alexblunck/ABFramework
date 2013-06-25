//
//  ABTabBarController.m
//  ABFramework
//
//  Created by Alexander Blunck on 9/7/12.
//  Copyright (c) 2012 Ablfx. All rights reserved.
//

#import "ABTabBarController.h"

@interface ABTabBarController () <ABTabBarDelegate>
{
    UIView *_activeView;
    UIView *_newView;
}

@end

@implementation ABTabBarController

#pragma mark - Initializer
-(id) initWithTabBarItems:(NSArray*)tabBarItems
{
    self = [super init];
    if (self) {
        
        //Set viewControllers property
        self.tabBarItems = [NSArray arrayWithArray:tabBarItems];
        
    } return self;
}



#pragma mark - LifeCycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.frame = CGRectChangingOriginY(self.view.frame, 0);
    
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    CGFloat screenWidth = screenSize.width;
    
    //Config
    if (!self.tabBarHeight) self.tabBarHeight = 49;
    if (!self.tabSpacing) self.tabSpacing = 0;
    
    //Create the actual tabbar
    self.tabBar = [[ABTabBar alloc] initWithFrame:cgr(0, 0, screenWidth, self.tabBarHeight)];
    self.tabBar.frame = CGRectInsideBottomCenter(self.tabBar.frame, self.view.bounds, 0);
    self.tabBar.delegate = self;
    self.tabBar.backgroundImageName = self.tabBarBackgroundImageName;
    self.tabBar.height = self.tabBarHeight;
    self.tabBar.tabSpacing = self.tabSpacing;
    self.tabBar.tabBarItems = self.tabBarItems;
    [self.view addSubview:self.tabBar];
    
    //Show default ViewController - Highlight correct Tab
    //else use first in Array
    BOOL defaultSet = NO;
    for (ABTabBarItem *item in self.tabBarItems)
    {
        if (item.isDefaultTab)
        {
            defaultSet = YES;
            self.tabBar.selectedIndex = [self.tabBarItems indexOfObject:item];
        }
    }
    
    if (!defaultSet)
    {
        self.tabBar.selectedIndex = 0;
    }
    
    //Do the actual View switching
    [self switchToTabBarItem:[self.tabBarItems safeObjectAtIndex:self.tabBar.selectedIndex] forced:NO];
}



#pragma mark - Helper
-(void) forceSwitchToTabIndex:(NSInteger)tabIndex
{
    [self.tabBar forceSwitchToTabIndex:tabIndex];
}

-(void) switchToTabBarItem:(ABTabBarItem*)item forced:(BOOL)forced
{
    if (!forced && [item isEqual:self.activeTabBarItem])
    {
        if (self.doubleTouchHandler) self.doubleTouchHandler([_tabBarItems indexOfObject:item]);
        return;
    }
    
    //Inform Application of Tab switch
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ABTabBarController.TabSwitched" object:nil];
    
    //Switch activeViewController
    self.activeTabBarItem = item;
    
    //Switch out views
    [_activeView removeFromSuperview];
    _activeView = nil;
    _activeView = item.viewController.view;
    
    //Restrict frame of activeView to space above tabBar View
    _activeView.frame = CGRectChangingSizeHeight(_activeView.frame, self.view.height - self.tabBarHeight);
    
    [self.view insertSubview:_activeView belowSubview:self.tabBar];
}



#pragma mark - ABTabBarDelegate
-(void) tabBarItemSelected:(ABTabBarItem*)item forced:(BOOL)forced
{
    [self switchToTabBarItem:item forced:forced];
}



#pragma mark - Accessors
-(void) setTabBarItems:(NSArray *)tabBarItems
{
    _tabBarItems = tabBarItems;
    
    for (ABTabBarItem *item in _tabBarItems)
    {
        if ([item.viewController respondsToSelector:@selector(setAbTabBarController:)])
        {
            [item.viewController setAbTabBarController:self];
        }
    }
}



#pragma mark - Accessors
-(id) activeViewController
{
    return self.activeTabBarItem.viewController;
}



#pragma mark - Orientation
//iOS 6 (Ask the activeViewController)
-(BOOL) shouldAutorotate
{
    return [self.activeTabBarItem.viewController shouldAutorotate];
}

- (NSUInteger)supportedInterfaceOrientations
{
    return [self.activeTabBarItem.viewController supportedInterfaceOrientations];
}

-(void) willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [self.activeTabBarItem.viewController willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
}

//iOS 5
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return [self.activeTabBarItem.viewController shouldAutorotateToInterfaceOrientation:interfaceOrientation];
}

@end
