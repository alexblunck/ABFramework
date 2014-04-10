//
//  UIView+ABFramework.h
//  ABFramework
//
//  Created by Alexander Blunck on 2/13/13.
//  Copyright (c) 2013 Ablfx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ABFramework)

// Visibility
-(void) toggleVisibility;
-(void) setVisible;
-(void) setInvisible;
-(void) setVisible:(BOOL)visible;
-(void) setInvisible:(BOOL)invisible;


// Recursion
-(void) enumerateAllSubviews:(void(^)(UIView *subview))block;


// Universal Access
+(UIView*) topWindowView;
+(UIView*) topView;


// Capture
-(UIImage*) renderCGRect:(CGRect)frame;

@end
