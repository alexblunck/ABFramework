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

#pragma mark - Target / Selector
+(UIBarButtonItem*) itemWithTitle:(NSString*)title target:(id)target action:(SEL)selector
{
    return [self itemWithTitle:title color:nil target:target action:selector];
}

+(UIBarButtonItem*) itemWithTitle:(NSString*)title color:(UIColor*)color target:(id)target action:(SEL)selector
{
    return [self itemWithTitle:title color:color fallbackImage:nil target:target action:selector];
}

+(UIBarButtonItem*) itemWithTitle:(NSString*)title fallbackImage:(NSString*)imageName target:(id)target action:(SEL)selector
{
    return [self itemWithTitle:title color:nil fallbackImage:imageName target:target action:selector];
}

+(UIBarButtonItem*) itemWithTitle:(NSString*)title color:(UIColor*)color fallbackImage:(NSString*)imageName target:(id)target action:(SEL)selector
{
    if (IS_MAX_IOS6X && imageName)
    {
        return [[ABButton buttonWithImageName:imageName target:target selector:selector] barButtonItem];
    }
    else
    {
        UIBarButtonItem *barButtonItem = [self barButtonItemWithTitle:title color:color];
        
        [barButtonItem setTarget:target];
        [barButtonItem setAction:selector];
        
        return barButtonItem;
    }
    return nil;
}



#pragma mark - Blocks
+(UIBarButtonItem*) itemWithTitle:(NSString*)title actionBlock:(ABBlockVoid)actionBlock
{
    return [self itemWithTitle:title color:nil actionBlock:actionBlock];
}

+(UIBarButtonItem*) itemWithTitle:(NSString*)title color:(UIColor*)color actionBlock:(ABBlockVoid)actionBlock
{
    return [self itemWithTitle:title color:color fallbackImage:nil actionBlock:actionBlock];
}

+(UIBarButtonItem*) itemWithTitle:(NSString*)title fallbackImage:(NSString*)imageName actionBlock:(ABBlockVoid)actionBlock
{
    return [self itemWithTitle:title color:nil fallbackImage:imageName actionBlock:actionBlock];
}

+(UIBarButtonItem*) itemWithTitle:(NSString*)title color:(UIColor*)color fallbackImage:(NSString*)imageName actionBlock:(ABBlockVoid)actionBlock
{
    if (IS_MAX_IOS6X && imageName)
    {
        return [[ABButton buttonWithImageName:imageName actionBlock:actionBlock] barButtonItem];
    }
    else
    {
        UIBarButtonItem *barButtonItem = [self barButtonItemWithTitle:title color:color];
        
        [barButtonItem setTarget:barButtonItem];
        [barButtonItem setAction:@selector(executeActionBlock)];
        [barButtonItem setActionBlock:actionBlock];
        
        return barButtonItem;
    }
    return nil;
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



#pragma mark - iOS 6 Fallbacks
-(void) setiOS6FallbackImageName:(NSString*)imageName
{
    if (!IS_MAX_IOS6X) return;
    
    ABBlockVoid actionBlock = [self actionBlock];
    ABButton *button = nil;
    
    if (self.target && self.action)
    {
        button = [ABButton buttonWithImageName:imageName target:self.target selector:self.action];
    }
    else if (actionBlock)
    {
        button = [ABButton buttonWithImageName:imageName actionBlock:actionBlock];
    }
}


#pragma mark - Action
-(void) executeActionBlock
{
    if ([self action])
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
