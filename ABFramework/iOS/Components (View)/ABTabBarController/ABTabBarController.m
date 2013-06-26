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
}
@end

@implementation ABTabBarController

#pragma mark - Initializer
-(id) initWithTabBarItems:(NSArray*)tabBarItems
{
    self = [super init];
    if (self)
    {
        [self setTabBarItems:tabBarItems];
    }
    return self;
}



#pragma mark - LifeCycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    
    //Config
    if (!self.tabBarHeight) self.tabBarHeight = 49.0f;
    if (!self.tabSpacing) self.tabSpacing = 0.0f;
    
    //Create the actual tabbar
    _tabBar = [[ABTabBar alloc] initWithTabBarItems:self.tabBarItems
                                       tabBarHeight:self.tabBarHeight
                                backgroundImageName:self.backgroundImageName
                                         tabSpacing:self.tabSpacing
                                           delegate:self];
    
    _tabBar.frame = cgr(0, 0, screenWidth, self.tabBarHeight);
    _tabBar.frame = CGRectInsideBottomCenter(self.tabBar.frame, self.view.bounds, 0);
    [self.view addSubview:_tabBar];
    
    //Use first tab as selected one
    self.selectedIndex = 0;
}



#pragma mark - Accessors
-(void) setSelectedIndex:(NSUInteger)selectedIndex
{
    //Make sure index exists
    ABTabBarItem *item = [_tabBarItems safeObjectAtIndex:selectedIndex];
    if (!item)
    {
        NSLog(@"ABTabBarController: WARNING -> Index does not exist!");
        return;
    }
    
    _selectedIndex = selectedIndex;
    
    //Inform application
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ABTabBarController.tabSwitched" object:@(selectedIndex)];
    
    //Inform tabbar
    _tabBar.selectedIndex = _selectedIndex;
    
    //Switch
    _activeTabBarItem = item;
    _activeViewController = item.viewController;
    [_activeView removeFromSuperview];
    _activeView = item.viewController.view;
    _activeView.frame = CGRectChangingSizeHeight(_activeView.frame, self.view.height - self.tabBarHeight);
    [self.view insertSubview:_activeView belowSubview:self.tabBar];
}



#pragma mark - ABTabBarDelegate
-(void) tabBarItemSelected:(ABTabBarItem*)item
{
    NSUInteger index = [_tabBarItems indexOfObject:item];
    self.selectedIndex = index;
}

-(void) tabBarItemSelectedDouble:(ABTabBarItem *)item
{
    if (self.doubleTouchHandler)
    {
        NSUInteger index = [_tabBarItems indexOfObject:item];
        self.doubleTouchHandler(index);
    }
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



#pragma mark - Orientation
#pragma mark - iOS 6 +
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


#pragma mark - iOS 5
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return [self.activeTabBarItem.viewController shouldAutorotateToInterfaceOrientation:interfaceOrientation];
}

@end
