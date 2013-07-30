//
//  UIView+ABFramework.m
//  ABFramework
//
//  Created by Alexander Blunck on 2/13/13.
//  Copyright (c) 2013 Ablfx. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "UIView+ABFramework.h"

@implementation UIView (ABFramework)

#pragma mark - Frame
-(CGFloat) right
{
    return self.frame.origin.x + self.frame.size.width;
}

-(CGFloat) left
{
    return self.frame.origin.x;
}

-(CGFloat) top
{
    return self.frame.origin.y;
}

-(CGFloat) bottom
{
    return self.frame.origin.y + self.frame.size.height;
}

-(CGFloat) width
{
    return self.frame.size.width;
}

-(CGFloat) height
{
    return self.frame.size.height;
}



#pragma mark - Visibility
-(void) toggleVisible
{
    [self show:(self.alpha == 0.0f)];
}

-(void) hide
{
    [self hide:YES];
}

-(void) show
{
    [self show:YES];
}

-(void) hide:(BOOL)hide
{
    self.alpha = (hide) ? 0.0f : 1.0f;
}

-(void) show:(BOOL)show
{
    self.alpha = (show) ? 1.0f : 0.0f;
}



#pragma mark - Recursion
-(void) enumerateAllSubviews:(void(^)(UIView *subview))block
{
    for (UIView *subview in self.subviews)
    {
        block(subview);
        [subview enumerateAllSubviews:block];
    }
}



#pragma mark - Universal Access
+(UIView*) topWindowView
{
    return [[[UIApplication sharedApplication] windows] lastObject];
}

+(UIView*) topView
{
    return [[UIViewController topViewController] view];
    //return [[[UIApplication sharedApplication] windows] lastObject];
}

-(UIImage*) renderCGRect:(CGRect)frame
{
    UIGraphicsBeginImageContextWithOptions(frame.size, NO, 0.0);
    CGContextRef c = UIGraphicsGetCurrentContext();
    
    CGContextConcatCTM(c, CGAffineTransformMakeTranslation(-frame.origin.x, -frame.origin.y));
    [self.layer renderInContext:c];
    
    UIImage *screenshot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return screenshot;
}

@end
