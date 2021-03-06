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
        //Config
        self.tabBarHeight = 49.0f;
        self.tabSpacing = 0.0f;
        self.restrictFrame = YES;
        
        [self setTabBarItems:tabBarItems];
        
        //Create the actual tabbar
        _tabBar = [[ABTabBar alloc] initWithTabBarItems:self.tabBarItems
                                           tabBarHeight:self.tabBarHeight
                                    backgroundImageName:self.backgroundImageName
                                             tabSpacing:self.tabSpacing
                                               delegate:self];
    }
    return self;
}



#pragma mark - LifeCycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    
    _tabBar.frame = cgr(0, 0, screenWidth, self.tabBarHeight);
    _tabBar.frame = CGRectInsideBottomCenter(self.tabBar.frame, self.view.bounds, 0);
    [self.view addSubview:self.tabBar];
    
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
    if (self.restrictFrame) _activeView.frame = CGRectChangingSizeHeight(_activeView.frame, self.view.height - self.tabBarHeight);
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
    return [self.activeViewController shouldAutorotate];
}

- (NSUInteger)supportedInterfaceOrientations
{
    return [self.activeViewController supportedInterfaceOrientations];
}

-(void) willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [self.activeViewController willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
}


#pragma mark - iOS 5
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return [self.activeViewController shouldAutorotateToInterfaceOrientation:interfaceOrientation];
}

@end
