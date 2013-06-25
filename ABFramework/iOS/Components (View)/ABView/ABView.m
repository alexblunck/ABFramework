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

@interface ABView () <NSCoding>
{
    UIColor *_originalBackgroundColor;
    UIImage *_originalBackgroundImage;
    UIImage *_selectedBackgroundImage;
    
    ABViewState _state;
    ABTouchState _touchState;
    BOOL _waitingForDoubleTouchUp;
    
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
    }
    return self;
}

-(id) initWithBackgroundImageName:(NSString *)backgroundImageName
{
    self = [self initWithFrame:CGRectZero];
    if (self)
    {
        UIImage *image = [UIImage imageNamed:backgroundImageName];
        
        if (image)
        {
            _backgroundImageView = [[UIImageView alloc] initWithImage:image];
            [self addSubview:_backgroundImageView];
            self.frame = CGRectChangingCGSize(self.frame, image.size);
        } 
    }
    return self;
}



#pragma mark - LifeCycle
-(void) willMoveToSuperview:(UIView *)newSuperview
{
    _state = ABViewStateVisible;
    
    //Setup default styles
    [self defaultStyle];
    
    self.selected = self.selected;
    
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
        self.backgroundColor = self.selectedBackgroundColor;
    }
    else
    {
        self.backgroundColor = _originalBackgroundColor;
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
    else
    {
        _backgroundImageView.image = _originalBackgroundImage;
    }
}


-(void) encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.userData forKey:@"userData"];
}

-(id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        self.userData = [aDecoder decodeObjectForKey:@"userData"];
    }
    return self;
}


#pragma mark - Accessors
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

@end
