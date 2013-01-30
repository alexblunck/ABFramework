//
//  ABSwitch.m
//  ABFramework
//
//  Created by Alexander Blunck on 11/7/12.
//  Copyright (c) 2012 Ablfx. All rights reserved.
//

#import "ABSwitch.h"
#import <QuartzCore/QuartzCore.h>

@interface ABSwitch () {
    UIImageView *_backgroundView;
    UIImageView *_backgroundShadowView;
    UIImageView *_switchView;
    float _oldTouchPointX;
    
    UIView *_colorViewContainmentView;
    UIView *_leftColorView;
    UIView *_rightColorView;
    
    UITextField *_leftLabel;
    UITextField *_rightLabel;
}
@end

@implementation ABSwitch

#pragma mark - Initializer
-(id) initWithBackgroundImage:(UIImage*)bgImage switchImage:(UIImage*)switchImage shadowImage:(UIImage*)shadowImage
{
    self = [super init];
    if (self) {
        
        //Switch Background
        UIImage *backgroundViewImage = bgImage;
        _backgroundView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, backgroundViewImage.size.width, backgroundViewImage.size.height)];
        _backgroundView.image = backgroundViewImage;
        _backgroundView.layer.cornerRadius = self.cornerRadius;
        _backgroundView.clipsToBounds = YES;
        _backgroundView.userInteractionEnabled = YES;
        [self addSubview:_backgroundView];
        
        //The Switch itself
        UIImage *switchViewImage = switchImage;
        _switchView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, switchViewImage.size.width, switchViewImage.size.height)];
        _switchView.userInteractionEnabled = YES;
        _switchView.image = switchViewImage;
        [_backgroundView addSubview:_switchView];
        
        if (self.showShadow) {
            _switchView.layer.shadowColor = [[UIColor blackColor] CGColor];
            _switchView.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
            _switchView.layer.shadowOpacity = 0.5f;
            _switchView.layer.shadowRadius = 2.0f;
        }
        
        _colorViewContainmentView = [[UIView alloc] initWithFrame:_backgroundView.frame];
        _colorViewContainmentView.layer.cornerRadius = self.cornerRadius;
        _colorViewContainmentView.clipsToBounds = YES;
        [_backgroundView insertSubview:_colorViewContainmentView belowSubview:_switchView];
        
        //Left Color
        _leftColorView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _switchView.center.x, _backgroundView.frame.size.height)];
        _leftColorView.backgroundColor = self.leftColor;
        [_colorViewContainmentView insertSubview:_leftColorView belowSubview:_switchView];
         
        //Right Color
        _rightColorView = [[UIView alloc] initWithFrame:CGRectMake(_switchView.center.x, 0, _backgroundView.frame.size.width-_switchView.center.x, _backgroundView.frame.size.height)];
        _rightColorView.backgroundColor = self.rightColor;
        [_colorViewContainmentView insertSubview:_rightColorView belowSubview:_switchView];
        
        //Left Title Label
        _leftLabel = [UITextField new];
        _leftLabel.userInteractionEnabled = NO;
        _leftLabel.backgroundColor = [UIColor clearColor];
        _leftLabel.textAlignment = NSTextAlignmentCenter;
        _leftLabel.contentVerticalAlignment = NSTextAlignmentCenter;
        _leftLabel.textColor = [UIColor colorWithWhite:0.892 alpha:1.000];
        _leftLabel.layer.shadowColor = [[UIColor blackColor] CGColor];
        _leftLabel.layer.shadowOffset = CGSizeMake(0.0f, 1.0f);
        _leftLabel.layer.shadowOpacity = 1.0f;
        _leftLabel.layer.shadowRadius = 0.0f;
        [_switchView addSubview:_leftLabel];
        
        //Right Title Label
        _rightLabel = [UITextField new];
        _rightLabel.userInteractionEnabled = NO;
        _rightLabel.backgroundColor = [UIColor clearColor];
        _rightLabel.textAlignment = NSTextAlignmentCenter;
        _rightLabel.contentVerticalAlignment = NSTextAlignmentCenter;
        _rightLabel.enabled = NO;
        _rightLabel.textColor = [UIColor colorWithWhite:0.892 alpha:1.000];
        _rightLabel.layer.shadowColor = [[UIColor blackColor] CGColor];
        _rightLabel.layer.shadowOffset = CGSizeMake(0.0f, 1.0f);
        _rightLabel.layer.shadowOpacity = 1.0f;
        _rightLabel.layer.shadowRadius = 0.0f;
        [_switchView addSubview:_rightLabel];
        
        //Shadow View
        _backgroundShadowView = [[UIImageView alloc] initWithImage:shadowImage];
        _backgroundShadowView.frame = CGRectOffset(_backgroundShadowView.frame, self.backgroundShadowOffset.x, self.backgroundShadowOffset.y);
        [_backgroundView insertSubview:_backgroundShadowView belowSubview:_switchView];
        
        //Pan Gesture Recognizer
        UIPanGestureRecognizer* panGesture = [[UIPanGestureRecognizer alloc]
                                       initWithTarget:self
                                       action:@selector(handlePan:)];
        [_switchView addGestureRecognizer:panGesture];
        
        //Set own frame to background view frame
        self.frame = _backgroundView.frame;
        
        //Set Default Values
        self.currentIndex = 0;
        self.cornerRadius = 3.0f;
        self.switchOffsetY = 1.0f;
        self.switchOffsetXLeft = 2.0f;
        self.switchOffsetXRight = 2.0f;
        self.colorViewFrame = CGRectMake(2.5, 1, 69.5, 30);
        self.backgroundShadowOffset = CGPointMake(2.0f, 1.0f);
        self.showShadow = YES;
        self.rightColor = [UIColor colorWithWhite:0.217 alpha:1.000];
        self.leftColor = [UIColor colorWithRed:0.308 green:0.598 blue:0.570 alpha:1.000];
        self.font = [UIFont fontWithName:@"" size:14.0f];
        self.leftText = @"ON";
        self.rightText = @"OFF";
        
    }
    return self;
}

-(id) initWithDefaultStyle
{
    return [self initWithBackgroundImage:[UIImage imageNamed:@"ABSwitch-background.png"] switchImage:[UIImage imageNamed:@"ABSwitch-switch.png"] shadowImage:[UIImage imageNamed:@"ABSwitch-background-shadow.png"]];
}

-(id) init
{
    return [self initWithDefaultStyle];
}



#pragma mark - Helper
-(void)handlePan:(UIPanGestureRecognizer*)panGesture;
{
    //Handle Pan Gesture
    if (panGesture.state == UIGestureRecognizerStateChanged) {
        CGPoint center = _switchView.center;
        CGPoint translation = [panGesture translationInView:_switchView];
        center = CGPointMake(center.x + translation.x,
                             _switchView.center.y);
        
        //If switchView is within bounds allow movement
        if (_switchView.frame.origin.x >= 0 && _switchView.frame.origin.x <= self.frame.size.width-_switchView.frame.size.width) {
            _switchView.center = center;
            [panGesture setTranslation:CGPointZero inView:_switchView];
            
            //Update Left / Right Color
            _leftColorView.frame = CGRectMake(_leftColorView.frame.origin.x, _leftColorView.frame.origin.y, _switchView.center.x, _leftColorView.frame.size.height);
            _rightColorView.frame = CGRectMake(_switchView.center.x, _rightColorView.frame.origin.y, self.frame.size.width-_switchView.frame.origin.x, _rightColorView.frame.size.height);
            
        }
        
        //Keep switchView frame within bounds (panning it will cuase it to go 0.5 over/under bounds)
        if (_switchView.frame.origin.x < 0) {
            _switchView.frame = CGRectMake(0, _switchView.frame.origin.y, _switchView.frame.size.width, _switchView.frame.size.height);
        }
        if (_switchView.frame.origin.x > self.frame.size.width-_switchView.frame.size.width) {
            _switchView.frame = CGRectMake(self.frame.size.width-_switchView.frame.size.width, _switchView.frame.origin.y, _switchView.frame.size.width, _switchView.frame.size.height);
        }
        
    }
    
    //Catch Pan end
    else if (panGesture.state == UIGestureRecognizerStateEnded) {
        [self panEnd];
    }
}

-(void) animateSwitchRight
{
    [UIView animateWithDuration:0.2f animations:^{
        _switchView.frame = CGRectMake(self.frame.size.width-_switchView.frame.size.width-self.switchOffsetXRight, _switchView.frame.origin.y, _switchView.frame.size.width, _switchView.frame.size.height);
        //Update Left / Right Color
        _leftColorView.frame = CGRectMake(_leftColorView.frame.origin.x, _leftColorView.frame.origin.y, self.frame.size.width-(_switchView.frame.size.width/2), _leftColorView.frame.size.height);
        _rightColorView.frame = CGRectMake(self.frame.size.width-(_switchView.frame.size.width/2), _rightColorView.frame.origin.y, self.frame.size.width-(_switchView.frame.size.width/2), _rightColorView.frame.size.height);
    }];
    //Update index
    self.currentIndex = 1;
    
    //Execute block if set
    if (self.block) {
        self.block(self.currentIndex);
    }
    
    //If delegate is set inform delegate of index change
    if (self.delegate && [self.delegate respondsToSelector:@selector(abSwitch:DidChangeIndex:)]) {
        [self.delegate abSwitch:self DidChangeIndex:self.currentIndex];
    }
}
-(void) animateSwitchLeft
{
    [UIView animateWithDuration:0.2f animations:^{
        _switchView.frame = CGRectMake(0+self.switchOffsetXLeft, _switchView.frame.origin.y, _switchView.frame.size.width, _switchView.frame.size.height);
        //Update Left / Right Color
        _leftColorView.frame = CGRectMake(_leftColorView.frame.origin.x, _leftColorView.frame.origin.y, _switchView.frame.size.width/2, _leftColorView.frame.size.height);
        _rightColorView.frame = CGRectMake(_switchView.center.x, 0, self.frame.size.width-_switchView.center.x, _rightColorView.frame.size.height);
    }];
    //Update index
    self.currentIndex = 0;
    
    //Execute block if set
    if (self.block) {
        self.block(self.currentIndex);
    }
    
    //If delegate is set inform delegate of index change
    if (self.delegate && [self.delegate respondsToSelector:@selector(abSwitch:DidChangeIndex:)]) {
        [self.delegate abSwitch:self DidChangeIndex:self.currentIndex];
    }
}

//Called after pan ended
-(void) panEnd
{
    //If switchView is nearer to the left animate to the left
    if (_switchView.center.x < self.frame.size.width/2) {
        [self animateSwitchLeft];
    }
    //If switchView is nearer to the right animate to the right
    else {
        [self animateSwitchRight];
    }
}



#pragma mark - Touches
//Called on simple Tap
-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    //Toggle oposit Side / Index
    if (self.currentIndex == 0) {
        [self animateSwitchRight];
    } else if (self.currentIndex == 1) {
        [self animateSwitchLeft];
    }
    
}



#pragma mark - Accessors
-(void) setCurrentIndex:(NSInteger)currentIndex
{
    _currentIndex = currentIndex;
    if (_currentIndex == 0) {
        _switchView.frame = CGRectMake(0+self.switchOffsetXLeft, _switchView.frame.origin.y, _switchView.frame.size.width, _switchView.frame.size.height);
        //Update Left / Right Color
        _leftColorView.frame = CGRectMake(_leftColorView.frame.origin.x, _leftColorView.frame.origin.y, _switchView.frame.size.width/2, _leftColorView.frame.size.height);
        _rightColorView.frame = CGRectMake(_switchView.center.x, 0, self.frame.size.width-_switchView.center.x, _rightColorView.frame.size.height);
    } else if (_currentIndex == 1) {
        _switchView.frame = CGRectMake(self.frame.size.width-_switchView.frame.size.width-self.switchOffsetXRight, _switchView.frame.origin.y, _switchView.frame.size.width, _switchView.frame.size.height);
        //Update Left / Right Color
        _leftColorView.frame = CGRectMake(_leftColorView.frame.origin.x, _leftColorView.frame.origin.y, self.frame.size.width-(_switchView.frame.size.width/2), _leftColorView.frame.size.height);
        _rightColorView.frame = CGRectMake(self.frame.size.width-(_switchView.frame.size.width/2), _rightColorView.frame.origin.y, self.frame.size.width-(_switchView.frame.size.width/2), _rightColorView.frame.size.height);
    }
}

-(void) setCornerRadius:(CGFloat)cornerRadius
{
    _cornerRadius = cornerRadius;
    
    _backgroundView.layer.cornerRadius = _cornerRadius;
    _colorViewContainmentView.layer.cornerRadius = _cornerRadius;
}

-(void) setSwitchOffsetY:(CGFloat)switchOffsetY
{
    _switchOffsetY = switchOffsetY;
    _switchView.frame = CGRectOffset(_switchView.frame, 0, _switchOffsetY);
}

-(void) setSwitchOffsetXLeft:(CGFloat)switchOffsetXLeft
{
    _switchOffsetXLeft = switchOffsetXLeft;
    if (self.currentIndex == 0) {
        _switchView.frame = CGRectOffset(_switchView.frame, switchOffsetXLeft, 0);
    }
}

-(void) setSwitchOffsetXRight:(CGFloat)switchOffsetXRight
{
    _switchOffsetXRight = switchOffsetXRight;
    if (self.currentIndex == 1) {
        _switchView.frame = CGRectOffset(_switchView.frame, -switchOffsetXRight, 0);
    }
}

-(void) setColorViewFrame:(CGRect)colorViewFrame
{
    _colorViewFrame = colorViewFrame;
    
    _colorViewContainmentView.frame = _colorViewFrame;
}

-(void) setBackgroundShadowOffset:(CGPoint)backgroundShadowOffset
{
    _backgroundShadowOffset = backgroundShadowOffset;
    _backgroundShadowView.frame = CGRectOffset(_backgroundShadowView.frame, backgroundShadowOffset.x, backgroundShadowOffset.y);
}

-(void) setShowShadow:(BOOL)showShadow
{
    _showShadow = showShadow;
    if (self.showShadow) {
        _switchView.layer.shadowColor = [[UIColor blackColor] CGColor];
        _switchView.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
        _switchView.layer.shadowOpacity = 0.5f;
        _switchView.layer.shadowRadius = 2.0f;
    } else {
        _switchView.layer.shadowOpacity = 0.0f;
    }
}

-(void) setLeftColor:(UIColor *)leftColor
{
    _leftColor = leftColor;
    _leftColorView.backgroundColor = _leftColor;
}

-(void) setRightColor:(UIColor *)rightColor
{
    _rightColor = rightColor;
    _rightColorView.backgroundColor = _rightColor;
}

-(void) setFont:(UIFont *)font
{
    _font = font;
    _leftLabel.font = _font;
    _rightLabel.font = _font;
    [self setLeftText:self.leftText];
    [self setRightText:self.rightText];
}

-(void) setLeftText:(NSString *)leftText
{
    _leftText = leftText;
    _leftLabel.text = _leftText;
    [_leftLabel sizeToFit];
    _leftLabel.frame = CGRectMake(-_leftLabel.frame.size.width-((_switchView.frame.size.width-_leftLabel.frame.size.width)/2), (_switchView.frame.size.height-_leftLabel.frame.size.height)/2, _leftLabel.frame.size.width, _leftLabel.frame.size.height);
}

-(void) setRightText:(NSString *)rightText {
    _rightText = rightText;
    _rightLabel.text = _rightText;
    [_rightLabel sizeToFit];
    _rightLabel.frame = CGRectMake(_switchView.frame.size.width+((_switchView.frame.size.width-_rightLabel.frame.size.width)/2), (_switchView.frame.size.height-_rightLabel.frame.size.height)/2, _rightLabel.frame.size.width, _rightLabel.frame.size.height);
}

@end