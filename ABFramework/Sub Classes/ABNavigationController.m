//
//  ABNavigationController.m
//  ABFramework
//
//  Created by Alexander Blunck on 9/7/12.
//  Copyright (c) 2012 Ablfx. All rights reserved.
//

#import "ABNavigationController.h"

@interface ABNavigationController ()

@end

@implementation ABNavigationController

#pragma mark - Orientation
//iOS 6 (Ask the visible viewController)
-(BOOL) shouldAutorotate
{
    return [[self topViewController] shouldAutorotate];
}

- (NSUInteger)supportedInterfaceOrientations
{
    return [[self topViewController] supportedInterfaceOrientations];
}

//iOS 5 (Ask the visible viewController)
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return [[self topViewController] shouldAutorotateToInterfaceOrientation:interfaceOrientation];
}

@end
