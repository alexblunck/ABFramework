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
    UIView *_backgroundColorView;
    UIImageView *_backgroundShadowView;
    UIImageView *_switchView;
    float _oldTouchPointX;
}
@end

@implementation ABSwitch

#pragma mark - Initializer
-(id) init
{
    NSLog(@"ABSwitch ERROR -> Please use custom initializer!");
    return nil;
}

-(id) initWithBackgroundImage:(UIImage*)bgImage switchImage:(UIImage*)switchImage shadowImage:(UIImage*)shadowImage
{
    self = [super init];
    if (self) {
        
        //Default Configuration
        self.currentIndex = 0;
        self.cornerRadius = 0.0f;
        self.switchOffsetY = 0.0f;
        self.switchOffsetXLeft = 0.0f;
        self.switchOffsetXRight = 0.0f;
        self.backgroundShadowOffset = CGPointMake(0.0f, 0.0f);
        self.showShadow = NO;
        
        //Switch Background
        _backgroundView = [[UIImageView alloc] initWithFrame:CGRectChangingCGSize(CGRectZero, bgImage.size)];
        _backgroundView.image = bgImage;
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
    }
    return self;
}



#pragma mark - Helper
-(void)handlePan:(UIPanGestureRecognizer*)panGesture;
{
    //Handle Pan Gesture
    if (panGesture.state == UIGestureRecognizerStateChanged)
    {
        /*
        //Inform Delegate
        if (self.delegate && [self.delegate respondsToSelector:@selector(abSwitchDidMove:)]) {
            [self.delegate abSwitchDidMove:self];
        }
        */
         
        CGPoint center = _switchView.center;
        CGPoint translation = [panGesture translationInView:_switchView];
        center = CGPointMake(center.x + translation.x, _switchView.center.y);
        
        //If switchView is within bounds allow movement
        if (_switchView.frame.origin.x >= 0 && _switchView.frame.origin.x <= self.frame.size.width-_switchView.frame.size.width)
        {
            _switchView.center = center;
            [panGesture setTranslation:CGPointZero inView:_switchView];
        }
        
        //Keep switchView frame within bounds (panning it will cause it to go 0.5 over/under bounds)
        if (_switchView.frame.origin.x < 0)
        {
            _switchView.frame = CGRectChangingOriginX(_switchView.frame, 0);
        }
        
        if (_switchView.frame.origin.x > self.frame.size.width-_switchView.frame.size.width)
        {
            _switchView.frame = CGRectChangingOriginX(_switchView.frame, self.frame.size.width-_switchView.frame.size.width);
        }
         
    }
    
    //Catch Pan end
    else if (panGesture.state == UIGestureRecognizerStateEnded) {
        [self panEnd];
    }
}

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

-(void) animateSwitchRight
{
    [UIView animateWithDuration:0.2f animations:^{
        _switchView.frame = CGRectMake(self.frame.size.width-_switchView.frame.size.width-self.switchOffsetXRight, _switchView.frame.origin.y, _switchView.frame.size.width, _switchView.frame.size.height);
    }];
    //Update index
    self.currentIndex = 1;
    
    //Execute block if set
    if (self.block) {
        self.block(self.currentIndex);
    }
    
    //If delegate is set inform delegate of index change
    if (self.delegate && [self.delegate respondsToSelector:@selector(abSwitchDidChangeIndex:)]) {
        [self.delegate abSwitchDidChangeIndex:self];
    }
}
-(void) animateSwitchLeft
{
    [UIView animateWithDuration:0.2f animations:^{
        _switchView.frame = CGRectMake(0+self.switchOffsetXLeft, _switchView.frame.origin.y, _switchView.frame.size.width, _switchView.frame.size.height);
    }];
    //Update index
    self.currentIndex = 0;
    
    //Execute block if set
    if (self.block) {
        self.block(self.currentIndex);
    }
    
    //If delegate is set inform delegate of index change
    if (self.delegate && [self.delegate respondsToSelector:@selector(abSwitchDidChangeIndex:)]) {
        [self.delegate abSwitchDidChangeIndex:self];
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
    } else if (_currentIndex == 1) {
        _switchView.frame = CGRectMake(self.frame.size.width-_switchView.frame.size.width-self.switchOffsetXRight, _switchView.frame.origin.y, _switchView.frame.size.width, _switchView.frame.size.height);
    }
}

-(void) setCornerRadius:(CGFloat)cornerRadius
{
    _cornerRadius = cornerRadius;
    
    _backgroundView.layer.cornerRadius = _cornerRadius;
    
    if (_backgroundColorView != nil) {
        _backgroundColorView.layer.cornerRadius = _cornerRadius;
    }
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

-(void) setBackgroundColor:(UIColor *)backgroundColor
{
    _backgroundColor = backgroundColor;
    if (_backgroundColorView == nil)
    {
        _backgroundColorView = [[UIView alloc] initWithFrame:_backgroundView.frame];
        _backgroundColorView.layer.cornerRadius = self.cornerRadius;
        [self insertSubview:_backgroundColorView belowSubview:_backgroundView];
    }
    _backgroundColorView.backgroundColor = _backgroundColor;
}

-(NSInteger) currentSwitchPercent
{
    CGFloat switchPosition = _switchView.frame.origin.x;
    CGFloat maxPos = self.bounds.size.width-_switchView.bounds.size.width;
    CGFloat onePercentPos = 100 / maxPos;
    NSInteger currentPercent = onePercentPos * switchPosition;
    
    return currentPercent;
}

@end