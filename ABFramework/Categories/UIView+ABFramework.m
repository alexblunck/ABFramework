//
//  UIView+ABFramework.m
//  ABFramework
//
//  Created by Alexander Blunck on 2/13/13.
//  Copyright (c) 2013 Ablfx. All rights reserved.
//

#import "UIView+ABFramework.h"

@implementation UIView (ABFramework)

#pragma mark - Frame
- (CGFloat) right
{
    return self.frame.origin.x + self.frame.size.width;
}

- (CGFloat) left
{
    return self.frame.origin.x;
}

- (CGFloat) top
{
    return self.frame.origin.y;
}

- (CGFloat) bottom
{
    return self.frame.origin.y + self.frame.size.height;
}

@end
