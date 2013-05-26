//
//  ABViewController.m
//  ABFramework
//
//  Created by Alexander Blunck on 9/7/12.
//  Copyright (c) 2012 Ablfx. All rights reserved.
//

#import "ABViewController.h"

@interface ABViewController ()

@end

@implementation ABViewController

#pragma mark - LifeCycle
-(void) viewDidLoad
{    
    //Remove height of ABTabBar from own view if this viewController is a direct tab or it's
    //ABNavigationController is a tab of a ABTabBarController
    if (self.abTabBarController)
    {
        self.view.frame = CGRectOffsetSizeHeight(self.view.frame, -self.abTabBarController.tabBarHeight);
    }
    else if ([self.navigationController isKindOfClass:[ABNavigationController class]] && [(ABNavigationController*)self.navigationController abTabBarController])
    {
        self.view.frame = CGRectOffsetSizeHeight(self.view.frame, -[[(ABNavigationController*)self.navigationController abTabBarController] tabBarHeight]);
    }
    
    //Remove height of UINavigationBar from own view if this viewController has a UINavigationController
    if (self.navigationController && !self.navigationController.navigationBarHidden)
    {
        self.view.frame = CGRectOffsetSizeHeight(self.view.frame, -self.navigationController.navigationBar.height);
    }
    
    [super viewDidLoad];
}

-(void) dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion
{
    if (self.dismissBlock)
    {
        self.dismissBlock();
    }
    
    [super dismissViewControllerAnimated:flag completion:completion];
}

@end
