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
+(id) itemWithViewController:(UIViewController*)viewController tabImageName:(NSString*)tabImageName;

@property (nonatomic, strong) UIViewController *viewController;
@property (nonatomic, copy) NSString *tabImageName;

@end
