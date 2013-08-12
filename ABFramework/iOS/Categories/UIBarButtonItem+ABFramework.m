//
//  UIBarButtonItem+ABFramework.m
//  ABFramework
//
//  Created by Alexander Blunck on 6/28/13.
//  Copyright (c) 2013 Ablfx. All rights reserved.
//

#import <objc/runtime.h>
#import "UIBarButtonItem+ABFramework.h"

@implementation UIBarButtonItem (ABFramework)

@dynamic actionBlock, titleColor, titleDisabledColor;

#pragma mark - Convienience
+(UIBarButtonItem*) flexibleSpace
{
    return [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
}

+(UIBarButtonItem*) fixedSpace:(CGFloat)width
{
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    item.width = width;
    return item;
}



#pragma mark - Utility
#pragma mark - Utility - Title
+(UIBarButtonItem*) itemWithTitle:(NSString*)title target:(id)target action:(SEL)selector
{
    return [self itemWithTitle:title color:nil target:target action:selector];
}

+(UIBarButtonItem*) itemWithTitle:(NSString*)title color:(UIColor*)color target:(id)target action:(SEL)selector
{
    UIBarButtonItem *barButtonItem = [self barButtonItemWithTitle:title color:color];
    
    [barButtonItem setTarget:target];
    [barButtonItem setAction:selector];
    
    return barButtonItem;
}

+(UIBarButtonItem*) itemWithTitle:(NSString*)title actionBlock:(ABBlockVoid)block
{
    return [self itemWithTitle:title color:nil actionBlock:block];
}

+(UIBarButtonItem*) itemWithTitle:(NSString*)title color:(UIColor*)color actionBlock:(ABBlockVoid)block
{
    UIBarButtonItem *barButtonItem = [self barButtonItemWithTitle:title color:color];
    
    [barButtonItem setTarget:barButtonItem];
    [barButtonItem setAction:@selector(executeActionBlock)];
    [barButtonItem setActionBlock:block];
    
    return barButtonItem;
}

#pragma mark - Utility - Icon
+(UIBarButtonItem*) itemWithIconName:(NSString*)iconName color:(UIColor*)color target:(id)target action:(SEL)selector
{
    ABEntypoButton *button = [ABEntypoButton buttonWithIconName:iconName size:32.0f];
    button.iconColor = color;
    UIBarButtonItem *item = [button barButtonItem];
    
    [item setTarget:target];
    [item setAction:selector];
    
    return item;
}

#pragma mark - Utility - Image
+(UIBarButtonItem*) itemWithImageName:(NSString*)imageName target:(id)target action:(SEL)selector
{
    return [self itemWithImageName:imageName color:nil target:target action:selector block:nil];
}

+(UIBarButtonItem*) itemWithImageName:(NSString*)imageName actionBlock:(ABBlockVoid)block
{
    return [self itemWithImageName:imageName color:nil target:nil action:nil block:block];
}

+(UIBarButtonItem*) itemWithImageName:(NSString*)imageName color:(UIColor*)color target:(id)target action:(SEL)selector
{
    return [self itemWithImageName:imageName color:color target:target action:selector block:nil];
}

+(UIBarButtonItem*) itemWithImageName:(NSString*)imageName color:(UIColor*)color actionBlock:(ABBlockVoid)block
{
    return [self itemWithImageName:imageName color:color target:nil action:nil block:block];
}

+(UIBarButtonItem*) itemWithImageName:(NSString*)imageName color:(UIColor*)color target:(id)target action:(SEL)selector block:(ABBlockVoid)block
{
    UIImage *image = nil;
    
    if (color)
    {
        image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAutomatic];
    }
    else
    {
        image = [UIImage imageNamed:imageName];
    }
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:image style:0 target:nil action:nil];
    
    if (color)
    {
        [item setTintColor:color];
    }
    
    if (target && selector)
    {
        [item setTarget:target];
        [item setAction:selector];
    }
    
    if (block)
    {
        [item setTarget:item];
        [item setAction:@selector(executeActionBlock)];
        [item setActionBlock:block];
    }
    
    return item;
}



#pragma mark - Factory
+(UIBarButtonItem*) barButtonItemWithTitle:(NSString*)title color:(UIColor*)color
{
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] init];
    
    [barButtonItem setTitle:title];
    
#ifdef DEF_IS_MAX_IOS6
    NSString *attributeTextColorKey = UITextAttributeTextColor;
#else
    NSString *attributeTextColorKey = NSForegroundColorAttributeName;
#endif
    
    if (color) [barButtonItem setTitleTextAttributes:@{attributeTextColorKey: color} forState:UIControlStateNormal];
    
    [barButtonItem setStyle:0];
    
    return barButtonItem;
}



#pragma mark - Action
-(void) executeActionBlock
{
    if ([self actionBlock])
    {
        ABBlockVoid actionBlock = [self actionBlock];
        actionBlock();
    }
}



#pragma mark - Accessors
-(void) setActionBlock:(ABBlockVoid)actionBlock
{
    objc_setAssociatedObject(self, @"actionBlock", actionBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(ABBlockVoid) actionBlock
{
    return objc_getAssociatedObject(self, @"actionBlock");
}

-(void) setTitleColor:(UIColor *)titleColor
{
    [self setTitleTextAttributes:@{NSForegroundColorAttributeName: titleColor} forState:UIControlStateNormal];
}

-(void) setTitleDisabledColor:(UIColor *)titleDisabledColor
{
    [self setTitleTextAttributes:@{NSForegroundColorAttributeName: titleDisabledColor} forState:UIControlStateDisabled];
}

@end
