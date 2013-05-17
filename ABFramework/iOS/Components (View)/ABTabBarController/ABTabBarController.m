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
    
    //Retrieve Screen Dimensions
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    CGFloat screenWidth = screenSize.width;
    CGFloat screenHeight = screenSize.height;
    
    CGFloat statusBarHeight = 20;
    
    //If no tabBarHeight is set, use default height of 49
    if (!self.tabBarHeight)
    {
        self.tabBarHeight = 49;
    }
    //If no tabSpacing is set, use default of 0
    if (!self.tabSpacing)
    {
        self.tabSpacing = 0;
    }
    
    //Create the actual TabBar View
    //Position it at the bottom of the screen with the set Height
    CGRect tabBarRect = CGRectMake(0, screenHeight-statusBarHeight-self.tabBarHeight, screenWidth, self.tabBarHeight);
    self.tabBar = [[ABTabBar alloc] initWithFrame:tabBarRect];
    self.tabBar.delegate = self;
    self.tabBar.backgroundImageName = self.tabBarBackgroundImageName;
    self.tabBar.height = self.tabBarHeight;
    self.tabBar.tabSpacing = self.tabSpacing;
    self.tabBar.tabBarItems = self.tabBarItems;
    
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
    [self switchToTabBarItem:[self.tabBarItems safeObjectAtIndex:self.tabBar.selectedIndex]];
    
    //Add tabBar as SubView
    [self.view addSubview:self.tabBar];
}



#pragma mark - Helper
-(void) forceSwitchToTabIndex:(NSInteger)tabIndex
{
    [self.tabBar forceSwitchToTabIndex:tabIndex];
}

-(void) switchToTabBarItem:(ABTabBarItem*)item
{
    if ([item isEqual:self.activeTabBarItem])
    {
        return;
    }
    
    //Inform Application of Tab switch
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ABTabBarController.TabSwitched" object:nil];
    
    //Switch activeViewController
    self.activeTabBarItem = nil;
    self.activeTabBarItem = item;
    
    //Remove current active view
    [_activeView removeFromSuperview];
    _activeView = nil;
    
    //Show new view
    _activeView = item.viewController.view;
    
    //Restrict frame of activeView to space above tabBar View
    _activeView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-self.tabBarHeight);
    
    [self.view addSubview:_activeView];
}



#pragma mark - ABTabBarDelegate
-(void) tabBarItemSelected:(ABTabBarItem*)item
{
    [self switchToTabBarItem:item];
}



#pragma mark - Accessors
-(void) setTabBarItems:(NSArray *)tabBarItems
{
    _tabBarItems = tabBarItems;
    
    //Loop through added ViewController
    for (ABTabBarItem *item in _tabBarItems)
    {
        //If ViewController is ABViewController set it's abTabBarController property
        if ([item.viewController respondsToSelector:@selector(setAbTabBarController:)])
        {
            [(ABViewController*)item.viewController setAbTabBarController:self];
            
            if ([item.viewController respondsToSelector:@selector(viewControllers)])
            {
                for (id subViewController in [(ABNavigationController*)item.viewController viewControllers])
                {
                    if ([subViewController respondsToSelector:@selector(setAbTabBarController:)])
                    {
                        [(ABViewController*)subViewController setAbTabBarController:self];
                    }
                }
            }
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

//iOS 5 (Ask the activeViewController)
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return [self.activeTabBarItem.viewController shouldAutorotateToInterfaceOrientation:interfaceOrientation];
}

@end
