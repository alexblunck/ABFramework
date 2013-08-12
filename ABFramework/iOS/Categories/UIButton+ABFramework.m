//
//  UIButton+ABFramework.m
//  ABFramework-Examples
//
//  Created by Alexander Blunck on 8/10/13.
//  Copyright (c) 2013 Ablfx. All rights reserved.
//

#import "UIButton+ABFramework.h"

@implementation UIButton (ABFramework)

#pragma mark - Conversion
-(UIBarButtonItem*) barButtonItem
{
    return [[UIBarButtonItem alloc] initWithCustomView:self];
}

@end
