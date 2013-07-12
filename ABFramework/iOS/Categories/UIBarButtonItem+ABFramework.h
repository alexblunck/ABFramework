//
//  UIBarButtonItem+ABFramework.h
//  ABFramework
//
//  Created by Alexander Blunck on 6/28/13.
//  Copyright (c) 2013 Ablfx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (ABFramework)

//Target / Selector
+(UIBarButtonItem*) itemWithTitle:(NSString*)title target:(id)target action:(SEL)selector;
+(UIBarButtonItem*) itemWithTitle:(NSString*)title color:(UIColor*)color target:(id)target action:(SEL)selector;
+(UIBarButtonItem*) itemWithTitle:(NSString*)title fallbackImage:(NSString*)imageName target:(id)target action:(SEL)selector;
+(UIBarButtonItem*) itemWithTitle:(NSString*)title color:(UIColor*)color fallbackImage:(NSString*)imageName target:(id)target action:(SEL)selector;

//Blocks
+(UIBarButtonItem*) itemWithTitle:(NSString*)title actionBlock:(ABBlockVoid)actionBlock;
+(UIBarButtonItem*) itemWithTitle:(NSString*)title color:(UIColor*)color actionBlock:(ABBlockVoid)actionBlock;
+(UIBarButtonItem*) itemWithTitle:(NSString*)title fallbackImage:(NSString*)imageName actionBlock:(ABBlockVoid)actionBlock;
+(UIBarButtonItem*) itemWithTitle:(NSString*)title color:(UIColor*)color fallbackImage:(NSString*)imageName actionBlock:(ABBlockVoid)actionBlock;

//iOS 6 Fallbacks
-(void) setiOS6FallbackImageName:(NSString*)imageName;

@property (nonatomic, copy, readonly) ABBlockVoid actionBlock;

@property (nonatomic, copy) UIColor *titleColor;
@property (nonatomic, copy) UIColor *titleDisabledColor;

@end
