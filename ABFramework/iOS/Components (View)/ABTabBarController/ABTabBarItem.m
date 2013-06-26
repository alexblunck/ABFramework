//
//  ABTabBarItem.m
//  ABFramework
//
//  Created by Alexander Blunck on 9/7/12.
//  Copyright (c) 2012 Ablfx. All rights reserved.
//

#import "ABTabBarItem.h"

@implementation ABTabBarItem

#pragma mark - Utility
+(id) itemWithViewController:(UIViewController *)viewController tabImageName:(NSString *)tabImageName
{
    return [[self alloc] initWithViewController:viewController tabImageName:tabImageName];
}



#pragma mark - Intitializer
-(id) initWithViewController:(UIViewController *)viewController tabImageName:(NSString *)tabImageName
{
    self = [super init];
    if (self)
    {
        self.viewController = viewController;
        self.tabImageName = tabImageName;
    }
    return self;
}

@end
