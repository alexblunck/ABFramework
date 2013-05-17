//
//  ABTabBarItem.h
//  ABFramework
//
//  Created by Alexander Blunck on 9/7/12.
//  Copyright (c) 2012 Ablfx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ABTabBarItem : NSObject

//Utility
+(id) itemWithImageName:(NSString*)imageName viewController:(UIViewController*)viewController;

@property (nonatomic, strong) UIViewController *viewController;
@property (nonatomic, copy) NSString *imageName;
@property (nonatomic, assign) BOOL isDefaultTab;

@end
