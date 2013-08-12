//
//  UIBarButtonItem+ABFramework.h
//  ABFramework
//
//  Created by Alexander Blunck on 6/28/13.
//  Copyright (c) 2013 Ablfx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (ABFramework)

//Convienience
+(UIBarButtonItem*) flexibleSpace;
+(UIBarButtonItem*) fixedSpace:(CGFloat)width;

//Utility
//Title
+(UIBarButtonItem*) itemWithTitle:(NSString*)title target:(id)target action:(SEL)selector;
+(UIBarButtonItem*) itemWithTitle:(NSString*)title color:(UIColor*)color target:(id)target action:(SEL)selector;
+(UIBarButtonItem*) itemWithTitle:(NSString*)title actionBlock:(ABBlockVoid)block;
+(UIBarButtonItem*) itemWithTitle:(NSString*)title color:(UIColor*)color actionBlock:(ABBlockVoid)block;
//Icon
+(UIBarButtonItem*) itemWithIconName:(NSString*)iconName color:(UIColor*)color target:(id)target action:(SEL)selector;
//Image
+(UIBarButtonItem*) itemWithImageName:(NSString*)imageName target:(id)target action:(SEL)selector;
+(UIBarButtonItem*) itemWithImageName:(NSString*)imageName actionBlock:(ABBlockVoid)block;
+(UIBarButtonItem*) itemWithImageName:(NSString*)imageName color:(UIColor*)color target:(id)target action:(SEL)selector;
+(UIBarButtonItem*) itemWithImageName:(NSString*)imageName color:(UIColor*)color actionBlock:(ABBlockVoid)block;

@property (nonatomic, copy, readonly) ABBlockVoid actionBlock;

@property (nonatomic, copy) UIColor *titleColor;
@property (nonatomic, copy) UIColor *titleDisabledColor;

@end
