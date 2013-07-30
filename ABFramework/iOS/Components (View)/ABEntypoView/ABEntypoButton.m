//
//  ABEntypoButton.m
//  ABFramework
//
//  Created by Alexander Blunck on 7/17/13.
//  Copyright (c) 2013 Ablfx. All rights reserved.
//

#import "ABEntypoButton.h"

@interface ABEntypoButton ()
{
    ABEntypoView *_iconView;
}

@end

@implementation ABEntypoButton

#pragma mark - Initializer
-(id) initWithFrame:(CGRect)frame iconName:(NSString*)iconName iconSize:(CGFloat)iconSize
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _iconView = [ABEntypoView viewWithIconName:iconName size:iconSize];
    }
    return self;
}



#pragma mark - LifeCycle
-(void) willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    
    _iconView.color = self.iconColor;
    _iconView.frame = CGRectCenteredWithCGRect(_iconView.frame, self.bounds);
    [self addSubview:_iconView];
    
    [self addTarget:self action:@selector(highlight) forControlEvents:UIControlEventTouchDown];
    
    UIControlEvents flags = UIControlEventTouchUpInside | UIControlEventTouchUpOutside | UIControlEventTouchDragOutside | UIControlEventTouchCancel;
    [self addTarget:self action:@selector(unHightlight) forControlEvents:flags];
}



#pragma mark - UIBarButtonItem
-(UIBarButtonItem*) barButtonItem
{
    return [[UIBarButtonItem alloc] initWithCustomView:self];
}



#pragma mark - Action
-(void) addTouchUpInsideTarget:(id)target action:(SEL)selector
{
    [self addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
}


#pragma mark - Highlight
-(void) highlight
{
    if (self.iconColorSelected)
    {
        _iconView.color = self.iconColorSelected;
    }
    else
    {
        self.alpha = 0.6f;
    }
}

-(void) unHightlight
{
    if (self.iconColorSelected)
    {
        _iconView.color = self.iconColor;
    }
    else
    {
        self.alpha = 1.0f;
    }
}


//#pragma mark - Touch
//-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    [super touchesBegan:touches withEvent:event];
//    
//    if (self.iconColorSelected)
//    {
//        _iconView.color = self.iconColorSelected;
//    }
//    else
//    {
//        self.alpha = 0.6f;
//    }
//}
//
//-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    [super touchesEnded:touches withEvent:event];
//    
//    if (self.iconColorSelected)
//    {
//        _iconView.color = self.iconColor;
//    }
//    else
//    {
//        self.alpha = 1.0f;
//    }
//}
//
//-(void) touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    [super touchesCancelled:touches withEvent:event];
//    
//    if (self.iconColorSelected)
//    {
//        _iconView.color = self.iconColor;
//    }
//    else
//    {
//        self.alpha = 1.0f;
//    }
//}

@end
