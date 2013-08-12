//
//  ABView.m
//  ABFramework
//
//  Created by Alexander Blunck on 2/10/13.
//  Copyright (c) 2013 Ablfx. All rights reserved.
//

#import "ABView.h"

typedef enum {
    ABViewStateNone,
    ABViewStateInit,
    ABViewStateVisible
} ABViewState;

@interface ABView ()
{
    UIColor *_originalBackgroundColor;
    UIImage *_originalBackgroundImage;
    UIImage *_selectedBackgroundImage;
    
    ABViewState _state;
    ABTouchState _touchState;
    BOOL _waitingForDoubleTouchUp;
    CGPoint _firstTouchLocation;
    
    UIImageView *_backgroundImageView;
    
    __weak id _target;
    SEL _selector;
}
@end

@implementation ABView

#pragma mark - Initializer
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _state = ABViewStateInit;
        _touchState = ABTouchStateNone;
        
        //Config
        self.selectRecursively = NO;
        self.userInteractionEnabled = YES;
        self.permitTouchWhileSelected = YES;
        self.animateBackgroundColor = NO;
        self.animationDuration = 0.2f;
        self.dimBackgroundImageOnSelect = NO;
        self.touchMoveToleration = 30.0f;
    }
    return self;
}

-(id) initWithBackgroundImageName:(NSString *)backgroundImageName
{
    self = [self initWithFrame:CGRectZero];
    if (self)
    {
        self.backgroundImageName = backgroundImageName;
    }
    return self;
}

-(id) initWithBackgroundImage:(UIImage*)backgroundImage
{
    return [self initWithBackgroundImage:backgroundImage resize:YES];
}

-(id) initWithBackgroundImage:(UIImage*)backgroundImage resize:(BOOL)resize
{
    self = [self initWithFrame:CGRectZero];
    if (self)
    {
        [self setBackgroundImage:backgroundImage resize:resize];
    }
    return self;
}



#pragma mark - LifeCycle
-(void) willMoveToSuperview:(UIView *)newSuperview
{
    _state = ABViewStateVisible;
    
    //Setup default styles
    [self defaultStyle];
    
    self.selected = _selected;
    
    //Check if superview is an ABView to take over it's selected state, incase this view was added
    //after the superview set it's selected state
    if ([newSuperview isKindOfClass:[ABView class]])
    {
        self.selected = [(ABView*)newSuperview isSelected];
    }
}



#pragma mark - Target / Selector
-(void) setTarget:(id)target selector:(SEL)selector
{
    _target = target;
    _selector = selector;
}



#pragma mark - Touch
-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    _firstTouchLocation = [[touches anyObject] locationInView:self];
    
    //Only "allow" touch if "selected" property is NO
    if (!self.isSelected)
    {
        self.selected = YES;
        _touchState = ABTouchStateTouchesBegan;
    }
    else
    {
        _waitingForDoubleTouchUp = YES;
    }
}

-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    //Only visually end touch / inform delegate if valid touch began the selection
    if (_touchState == ABTouchStateTouchesBegan)
    {
        self.selected = NO;
        _touchState = ABTouchStateTouchesEnded;
        
        //Touch handler
        if (self.touchHandler)
        {
            self.touchHandler(self);
        }
        
        //Inform delegate
        if ([self.delegate respondsToSelector:@selector(abViewDidTouchUpInside:)])
        {
            [self.delegate abViewDidTouchUpInside:self];
        }
        
        //Target / selector
        if (_target && _selector)
        {
            [_target performSelector:_selector withObject:self afterDelay:0];
        }
    }
    
    //Touch up on a selected view
    if (_waitingForDoubleTouchUp)
    {
        _waitingForDoubleTouchUp = NO;
        
        //Touch handler
        if (self.doubleTouchHandler)
        {
            self.doubleTouchHandler(self);
        }
        
        //Inform delegate
        if ([self.delegate respondsToSelector:@selector(abViewDidDoubleTouchUpInside:)])
        {
            [self.delegate abViewDidDoubleTouchUpInside:self];
        }
    }
}

-(void) touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (_touchState == ABTouchStateTouchesBegan)
    {
        self.selected = NO;
        _touchState = ABTouchStateTouchesCancelled;
    }
}

-(void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint touchLocation = [[touches anyObject] locationInView:self];
    CGFloat distance = ABMathDistance(_firstTouchLocation, touchLocation);
    
    if (_touchState == ABTouchStateTouchesBegan && distance > self.touchMoveToleration)
    {
        self.selected = NO;
        _touchState = ABTouchStateTouchesCancelled;
    }
}



#pragma mark - ABViewSelectionProtocol
-(void) defaultStyle
{
    _originalBackgroundColor = self.backgroundColor;
    _originalBackgroundImage = _backgroundImageView.image;
    
}

-(void) setSelectedStyle:(BOOL)selected
{
    //Background color
    if (_selected && self.selectedBackgroundColor)
    {
        if (self.animateBackgroundColor)
        {
            [UIView animateWithDuration:self.animationDuration animations:^{
                self.backgroundColor = self.selectedBackgroundColor;
            }];
        }
        else
        {
            self.backgroundColor = self.selectedBackgroundColor;
        }
    }
    else
    {
        if (self.animateBackgroundColor)
        {
            [UIView animateWithDuration:self.animationDuration animations:^{
                self.backgroundColor = _originalBackgroundColor;
            }];
        }
        else
        {
            self.backgroundColor = _originalBackgroundColor;
        }

    }
    
    //Background image
    if (_selected && self.selectedBackgroundImageName)
    {
        if (_selectedBackgroundImage == nil)
        {
            _selectedBackgroundImage = [UIImage imageNamed:self.selectedBackgroundImageName];
        }
        _backgroundImageView.image = _selectedBackgroundImage;
    }
    else if (_selected && !self.selectedBackgroundImageName)
    {
        if (self.dimBackgroundImageOnSelect) self.alpha = 0.6f;
    }
    else if (!_selected)
    {
        self.alpha = 1.0f;
        _backgroundImageView.image = _originalBackgroundImage;
    }
}



#pragma mark - Accessors
-(void) setBackgroundImageName:(NSString *)backgroundImageName
{
    _backgroundImageName = backgroundImageName;
    
    UIImage *image = [UIImage imageNamed:_backgroundImageName];
    
    self.backgroundImage = image;
}

-(void) setBackgroundImage:(UIImage*)backgroundImage
{
    [self setBackgroundImage:backgroundImage resize:YES];
}

-(void) setBackgroundImage:(UIImage *)backgroundImage resize:(BOOL)resize
{
    _backgroundImage = backgroundImage;
    
    if (_backgroundImage)
    {
        _backgroundImageView = [[UIImageView alloc] initWithImage:_backgroundImage];
        _backgroundImageView.contentMode = self.contentMode;
        [self addSubview:_backgroundImageView];
        if (resize) self.frame = CGRectChangingCGSize(self.frame, _backgroundImage.size);
    }
}

-(void) setSelected:(BOOL)selected
{
    _selected = selected;
    
    if (_state != ABViewStateVisible) {
        return;
    }

    [self setSelectedStyle:_selected];
    
    //Propegate selected state to all subviews
    if (self.selectRecursively)
    {
        [self enumerateAllSubviews:^(UIView *subview) {
            //
            if ([subview conformsToProtocol:@protocol(ABViewSelectionProtocol)])
            {
                [(ABView*)subview setSelected:_selected];
            }
        }];
    }
}

-(void) setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    _backgroundImageView.frame = self.bounds;
}

-(void) setContentMode:(UIViewContentMode)contentMode
{
    [super setContentMode:contentMode];
    
    _backgroundImageView.contentMode = contentMode;
}

@end
