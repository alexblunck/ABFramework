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
-(id) initWithViewControllers:(NSArray*)viewControllers {
    self = [super init];
    if (self) {

        //Set viewControllers property
        self.viewControllers = [NSArray arrayWithArray:viewControllers];
        
    } return self;
}



#pragma mark - LifeCycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Retrieve Screen Dimensions
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    int screenWidth = screenSize.width;
    int screenHeight = screenSize.height;
    
    int statusBarHeight = 20;
    
    //If no tabBarHeight is set, use default height of 49
    if (!self.tabBarHeight) {
        self.tabBarHeight = 49;
    }
    //If no tabSpacing is set, use default of 0
    if (!self.tabSpacing) {
        self.tabSpacing = 0;
    }
    
    //Create the actual TabBar View
    //Position it at the bottom of the screen with the set Height
    CGRect tabBarRect = CGRectMake(0, screenHeight-statusBarHeight-self.tabBarHeight, screenWidth, self.tabBarHeight);
    self.tabBar = [[ABTabBar alloc] initWithFrame:tabBarRect];
    self.tabBar.delegate = self;
    self.tabBar.backgroundImage = self.tabBarBackgroundImage;
    self.tabBar.height = self.tabBarHeight;
    self.tabBar.tabSpacing = self.tabSpacing;
    self.tabBar.viewControllers = self.viewControllers;
    
    //Show default ViewController - Highlight correct Tab
    //Loop through viewControllers and check if one is marked as defaultViewController
    //else use first in Array
    BOOL defaultSet = NO;
    for (ABViewController *vc in self.viewControllers) {
        if (vc.abTabBarItem.isDefaultTab) {
            defaultSet = YES;
            self.tabBar.selectedIndex = [self.viewControllers indexOfObject:vc];
        }
    }
    if (!defaultSet) {
        self.tabBar.selectedIndex = 0;
    }
    
    //Do the actual View switching
    [self switchToViewController:[self.viewControllers objectAtIndex:self.tabBar.selectedIndex]];
    
    //Add tabBar as SubView
    [self.view addSubview:self.tabBar];
}



#pragma mark - Helper
-(void) forceSwitchToTabIndex:(int)tabIndex
{
    [self.tabBar forceSwitchToTabIndex:tabIndex];
}

-(void) switchToViewController:(id)viewController
{
    if ([viewController isEqual:self.activeViewController])
    {
        return;
    }
    
    //Inform Application of Tab switch
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ABTabBarController.TabSwitched" object:nil];
    
    //Switch activeViewController
    self.activeViewController = nil;
    self.activeViewController = viewController;
    
    //Remove current active view
    [_activeView removeFromSuperview];
    _activeView = nil;
    
    //Show new view
    _activeView = [(ABViewController*)viewController view];
    
    //Restrict frame of activeView to space above tabBar View
    _activeView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-self.tabBarHeight);
    
    [self.view addSubview:_activeView];
    
}



#pragma mark - ABTabBarDelegate
-(void) tabBarTabSelected:(id)viewController {
    ABViewController *vc = viewController;
    //ABTabBarItem *tabBarItem = vc.abTabBarItem;
    
    [self switchToViewController:vc];
}



#pragma mark - Accessors
-(void) setViewControllers:(NSArray *)viewControllers
{
    _viewControllers = viewControllers;
    
    //Loop through added ViewController
    for (id viewController in _viewControllers)
    {
        
        //If ViewController is ABViewController set it's abTabBarController property
        if ([viewController isMemberOfClass:[ABViewController class]] || [viewController isMemberOfClass:[ABNavigationController class]])
        {
            [(ABViewController*)viewController setAbTabBarController:self];
            
            if ([viewController isMemberOfClass:[ABNavigationController class]])
            {
                
                for (id subViewController in [(ABNavigationController*)viewController viewControllers]) {
                    
                    if ([subViewController isMemberOfClass:[ABViewController class]]) {
                        [(ABViewController*)subViewController setAbTabBarController:self];
                    }
                    
                }
            
            }
            
        }
        
    }
    
}



#pragma mark - Orientation
//iOS 6 (Ask the activeViewController)
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

//iOS 5 (Ask the activeViewController)
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return [self.activeViewController shouldAutorotateToInterfaceOrientation:interfaceOrientation];
}

@end
