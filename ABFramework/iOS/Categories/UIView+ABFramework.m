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

#pragma mark - Visibility
-(void) toggleVisibility
{
    [self setVisible:(self.alpha == 0.0f)];
}

-(void) setVisible
{
    [self setVisible:YES];
}

-(void) setInvisible
{
    [self setVisible:NO];
}

-(void) setVisible:(BOOL)visible
{
    self.alpha = (visible) ? 1.0f : 0.0f;
}

-(void) setInvisible:(BOOL)invisible
{
    self.alpha = (invisible) ? 0.0f : 1.0f;
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
