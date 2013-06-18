//
//  ABRevealController.m
//  ABFramework
//
//  Created by Alexander Blunck on 6/12/13.
//  Copyright (c) 2013 Alexander Blunck. All rights reserved.
//

#import <objc/runtime.h>
#import "ABRevealController.h"
#import <QuartzCore/QuartzCore.h>

typedef enum {
    ABSwipeDirectionNone,
    ABSwipeDirectionLeft,
    ABSwipeDirectionRight
} ABSwipeDirection;

@interface ABRevealController ()
{
    UIView *_frontView;
    UIView *_backgroundView;
    
    UIPanGestureRecognizer *_panGesture;
    UITapGestureRecognizer *_tapGesture;
    
    //State
    CGFloat _swipeXStart;
    CGFloat _swipeXLast;
    CGFloat _swipeXCurrent;
    ABSwipeDirection _swipeDirection;
}

@end

@implementation ABRevealController

#pragma mark - Initializer
-(id) initWithFrontViewController:(UIViewController*)frontVc backgroundViewController:(UIViewController*)backgroundVc
{
    self = [super init];
    if (self)
    {
        //Config
        _revealed = NO;
        self.allowOverSliding = YES;
        self.animationSpeed = 0.4f;
        self.parallaxRevealEnabled = YES;
        self.allowOverParallax = NO;
        self.revealWidth = [[UIScreen mainScreen] bounds].size.width / 2;
        self.parallaxRevealDampening = 3.0f;
        self.shadowEnabled = NO;
        self.shadowOpactiy = 0.8f;
        self.shadowRadius = 5.0f;
        self.shadowColor = [UIColor blackColor];
        self.disablePanGesture = YES;
        
        //View controllers
        _frontViewController = frontVc;
        _backgroundViewController = backgroundVc;
        
        [_frontViewController setRevealController:self];
        [_backgroundViewController setRevealController:self];
        
    }
    return self;
}



#pragma mark - LifeCycle
-(void) viewDidLoad
{
    [super viewDidLoad];
    
    self.view.frame = CGRectChangingOriginY(self.view.frame, 0);
    
    //Add views
    [self addChildViewController:_frontViewController];
    [self addChildViewController:_backgroundViewController];
    _frontView = _frontViewController.view;
    _backgroundView = _backgroundViewController.view;
    [self.view addSubview:_backgroundView];
    [self.view addSubview:_frontView];
    
    self.view.backgroundColor = _backgroundView.backgroundColor;
    
    _frontView.frame = CGRectChangingOriginY(_frontView.frame, 0);
    _backgroundView.frame = CGRectChangingOriginY(_backgroundView.frame, 0);
    
    //Tap gesture recognizer for front view
    _tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture)];
    _tapGesture.enabled = NO;
    [_frontView addGestureRecognizer:_tapGesture];
    
    //Shadow
    if (self.shadowEnabled)
    {
        _frontView.layer.shadowColor = self.shadowColor.CGColor;
        _frontView.layer.shadowOpacity = self.shadowOpactiy;
        _frontView.layer.shadowRadius = self.shadowRadius;
        _frontView.layer.shadowPath = [[UIBezierPath bezierPathWithRect:_frontView.bounds] CGPath];
    }
    
    //Perform an initial alignment of the background view for parallax effect
    if (self.parallaxRevealEnabled) _backgroundView.frame = [self backgroundViewFrameAligned];
    
    //Pan gesture
    _panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
    _panGesture.enabled = !self.disablePanGesture;
    [_frontView addGestureRecognizer:_panGesture];
}



#pragma mark - Gesture
-(void) handlePanGesture:(UIPanGestureRecognizer*)gesture
{
    CGPoint touchPoint = [gesture locationInView:self.view];
    
    switch (gesture.state)
    {
        case UIGestureRecognizerStateBegan:
        {
            //Update state
            _swipeXStart = touchPoint.x;
            _swipeXLast = touchPoint.x;
            
            break;
        }
        case UIGestureRecognizerStateChanged:
        {
            //Update state
            _swipeXCurrent = touchPoint.x;
            
            //Set swipe direction
            if (_swipeXCurrent < _swipeXLast)
            {
                _swipeDirection = ABSwipeDirectionLeft;
            }
            else if (_swipeXCurrent > _swipeXLast)
            {
                _swipeDirection = ABSwipeDirectionRight;
            }
            
            //New rect for front view
            CGRect frontViewRect = CGRectOffset(_frontView.frame, _swipeXCurrent - _swipeXLast, 0);
            
            //Clamp movement
            //Left
            if (frontViewRect.origin.x < self.view.bounds.origin.x)
            {
                frontViewRect.origin.x = self.view.bounds.origin.x;
            }
            //Right
            if (frontViewRect.origin.x > self.view.bounds.size.width)
            {
                frontViewRect.origin.x = self.view.bounds.size.width;
            }
            
            //Right (Over sliding turned off)
            if (!self.allowOverSliding && frontViewRect.origin.x > self.revealWidth)
            {
                frontViewRect.origin.x = _frontView.frame.origin.x;
            }
            
            //Set actual front view frame
            _frontView.frame = frontViewRect;
            
            //Align background view with a parallax effect
            if (self.parallaxRevealEnabled) _backgroundView.frame = [self backgroundViewFrameAligned];
            
            //Update state
            _swipeXLast = _swipeXCurrent;
            
            break;
        }
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
        {
            //Complete reveal with animation
            [self completeReveal:(_swipeDirection == ABSwipeDirectionRight) animated:YES];
        }
        case UIGestureRecognizerStateFailed:
        {
            break;
        }
        default: break;
    }
}

-(void) handleTapGesture
{
    _tapGesture.enabled = NO;
    [self completeReveal:NO animated:YES];
}



#pragma mark - Alignment
-(CGRect) backgroundViewFrameAligned
{
    CGRect backgroundViewFrame = _backgroundView.frame;
    CGRect frontViewFrame = _frontView.frame;
    
    backgroundViewFrame.origin.x = frontViewFrame.origin.x - backgroundViewFrame.size.width;
    CGFloat offset = frontViewFrame.origin.x;
    backgroundViewFrame.origin.x = offset / self.parallaxRevealDampening - self.revealWidth / self.parallaxRevealDampening;
    
    if (!self.allowOverParallax && backgroundViewFrame.origin.x > 0)
    {
        backgroundViewFrame.origin.x = 0;
    }
    
    return backgroundViewFrame;
}



#pragma mark - Complete
-(void) completeReveal:(BOOL)reveal animated:(BOOL)animated
{
    CGRect frontViewFrame = _frontView.frame;
    CGRect backgroundViewFrame = _backgroundView.frame;
    
    CGFloat animationLength;
    
    //Reveal background view
    if (reveal)
    {
        frontViewFrame.origin.x = self.revealWidth;
        backgroundViewFrame.origin.x = 0;
        animationLength = self.revealWidth - _frontView.frame.origin.x;
    }
    //Hide background view
    else
    {
        frontViewFrame.origin.x = 0;
        backgroundViewFrame.origin.x = -(backgroundViewFrame.size.width/2);
        animationLength = _frontView.frame.origin.x;
    }
    
    //Animated
    if (animated)
    {
        //Calculate animation length relative to the length the front view needs to be moved
        CGFloat timeForSingleUnit = self.animationSpeed / self.revealWidth;
        CGFloat time = timeForSingleUnit * animationLength;
        
        [UIView animateWithDuration:time delay:0 options:0 animations:^{
            
            //Frames
            _frontView.frame = frontViewFrame;
            if (self.parallaxRevealEnabled) _backgroundView.frame = [self backgroundViewFrameAligned];
            
        } completion:^(BOOL finished) {
            
            [self postComplete:reveal];
            
        }];
    }
    //Not animated
    else
    {
        //Frames
        _frontView.frame = frontViewFrame;
        _backgroundView.frame = [self backgroundViewFrameAligned];
        
        [self postComplete:reveal];
    }
}

-(void) postComplete:(BOOL)wasRevealed
{
    //Update state
    _revealed = (wasRevealed) ? YES : NO;
    
    //Enable tap gesture
     _tapGesture.enabled = (_revealed);
    
    //Inform application
    [self informApplication:(_revealed)];
}



#pragma mark - Interaction
#pragma mark - Default Reveal
-(void) toggleReveal
{
    [self completeReveal:!self.isRevealed animated:YES];
}



#pragma mark - Inform
-(void) informApplication:(BOOL)wasRevealed
{
    NSString *str = (wasRevealed) ? @"ABRevealController.didRevealBackground" : @"ABRevealController.didHideBackground";
    
    [[NSNotificationCenter defaultCenter] postNotificationName:str object:nil];
}



#pragma mark - Orientation
-(void) willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    if (self.orientationDelegate && [self.orientationDelegate respondsToSelector:@selector(abWillRotateToInterfaceOrientation:duration:)])
    {
        [self.orientationDelegate abWillRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
    }
}

#pragma mark - iOS 6 +
-(BOOL) shouldAutorotate
{
    if (self.orientationDelegate && [self.orientationDelegate respondsToSelector:@selector(abShouldAutorotate)])
    {
        return [self.orientationDelegate abShouldAutorotate];
    }
    return YES;
}

-(NSUInteger) supportedInterfaceOrientations
{
    if (self.orientationDelegate && [self.orientationDelegate respondsToSelector:@selector(abSupportedInterfaceOrientations)])
    {
        return [self.orientationDelegate abSupportedInterfaceOrientations];
    }
    return (UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskPortraitUpsideDown);
}

#pragma mark - iOS 5
-(BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    if (self.orientationDelegate && [self.orientationDelegate respondsToSelector:@selector(abShouldAutorotateToInterfaceOrientation:)])
    {
        return [self.orientationDelegate abShouldAutorotateToInterfaceOrientation:toInterfaceOrientation];
    }
    return UIInterfaceOrientationIsPortrait(toInterfaceOrientation);
}



#pragma mark - Accessors
-(void) setDisablePanGesture:(BOOL)disablePanGesture
{
    _disablePanGesture = disablePanGesture;
    
    _panGesture.enabled = (!disablePanGesture);
}

@end



#pragma mark - UIViewController+ABRevealController
@implementation UIViewController (ABRevealController)
@dynamic revealController;
-(ABRevealController*) revealController
{
    id a = objc_getAssociatedObject(self, @"ABRevealController");
    if (!a && self.parentViewController)  a = objc_getAssociatedObject(self.parentViewController, @"ABRevealController");
    return a;
}
-(void) setRevealController:(ABRevealController *)revealController
{
    objc_setAssociatedObject(self, @"ABRevealController", revealController, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end
