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
    if (IS_MIN_IOS6)
    {
        if ([self.presentingViewController.modalViewController isEqual:self])
        {
            self.wasPresented = YES;
            self.wasPushed = NO;
        }
        else
        {
            self.wasPresented = NO;
            self.wasPushed = YES;
        }
    }
    
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
    if (self.navigationController)
    {
        self.view.frame = CGRectOffsetSizeHeight(self.view.frame, -self.navigationController.navigationBar.height);
    }
    
    [super viewDidLoad];
}

#pragma mark - Orientation
/*
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

@end
