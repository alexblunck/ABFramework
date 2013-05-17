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
+(id) itemWithImageName:(NSString*)imageName viewController:(UIViewController*)viewController
{
    return [[self alloc] initWithImageName:imageName viewController:viewController];
}



#pragma mark - Intitializer
-(id) initWithImageName:(NSString*)imageName viewController:(UIViewController*)viewController
{
    self = [super init];
    if (self)
    {
        self.viewController = viewController;
        self.imageName = imageName;
    }
    return self;
}

@end
