//
//  UINavigationController+ABFramework.m
//  ABFramework
//
//  Created by Alexander Blunck on 6/26/13.
//  Copyright (c) 2013 Ablfx. All rights reserved.
//

#import "UINavigationController+ABFramework.h"

@implementation UINavigationController (ABFramework)

//
//Delegate orientation to top view controller (visible view controller)
//
#pragma mark - Orientation
//iOS 6+
-(BOOL) shouldAutorotate
{
    return [[self topViewController] shouldAutorotate];
}

- (NSUInteger)supportedInterfaceOrientations
{
    return [[self topViewController] supportedInterfaceOrientations];
}

//iOS 5
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return [[self topViewController] shouldAutorotateToInterfaceOrientation:interfaceOrientation];
}

@end
