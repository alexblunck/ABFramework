//
//  UIImageView+ABFramework.m
//  ComingUp iOS
//
//  Created by Alexander Blunck on 3/14/13.
//  Copyright (c) 2013 Ablfx. All rights reserved.
//

#import "UIImageView+ABFramework.h"

@implementation UIImageView (ABFramework)

+(id) imageViewWithImageName:(NSString*)imageName
{
    return [[self alloc] initWithImage:[UIImage imageNamed:imageName]];
}

@end
