//
//  ABHud.m
//  ABFramework
//
//  Created by Alexander Blunck on 3/11/13.
//  Copyright (c) 2013 Ablfx. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "ABHud.h"

@interface ABHud ()

@property (nonatomic, strong) NSTimer *hideTimer;

@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) UIView *circleView;
@property (nonatomic, strong) UIActivityIndicatorView *activityView;
@property (nonatomic, strong) ABEntypoView *iconView;
@property (nonatomic, strong) ABLabel *label;

@property (nonatomic, copy) NSString *message;
@property (nonatomic, assign) BOOL hideScheduled;
@property (nonatomic, copy) ABBlockVoid touchHandler;

@property (nonatomic, assign) ABHudAnimationType animationType;
@property (nonatomic, assign) CGFloat cornerRadius;

@end

@implementation ABHud

#pragma mark - Singleton
+(instancetype) sharedClass
{
    static ABHud *sharedClass = nil;
    static dispatch_once_t once = 0;
    dispatch_once(&once, ^{sharedClass = [[self alloc] init];});
    return sharedClass;
}



#pragma mark - Initializer
- (id)init
{
    self = [super init];
    if (self)
    {
        self.frame = [[UIScreen mainScreen] bounds];
        
        self.backgroundColor = [UIColor clearColor];
        
        //Config
        CGFloat circleRadius = 100.0f;
        _cornerRadius = (ABHUD_CORNER_RADIUS == -1) ? circleRadius / 2 : ABHUD_CORNER_RADIUS;
        self.hideScheduled = NO;
        self.animationType = ABHUD_ANIMATION_TYPE;
        
        //Background view
        _backgroundView = [[UIView alloc] initWithFrame:self.bounds];
        _backgroundView.backgroundColor = [UIColor blackColor];
        _backgroundView.alpha = 0.0f;
        [self addSubview:_backgroundView];
        
        //Circle view
        _circleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        _circleView.frame = CGRectCenteredWithCGRect(_circleView.frame, self.bounds);
        _circleView.userInteractionEnabled = NO;
        _circleView.backgroundColor = [UIColor blackColor];
        _circleView.alpha = ABHUD_OPACITY;
        [self addSubview:_circleView];

        //Activity View
        _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        _activityView.frame = CGRectCenteredWithCGRect(_activityView.frame, _circleView.bounds);
        [_activityView startAnimating];
        [_circleView addSubview:_activityView];
        
        //Label
        _label = [ABLabel new];
        _label.frame = CGRectMake(0, 0, 200, 50);
        _label.frame = CGRectOutsideBottomCenter(_label.frame, _circleView.frame, 2.0f);
        _label.centeredHorizontally = YES;
        _label.font = [UIFont systemFontOfSize:20.0f];
        _label.textColor = [UIColor colorWithWhite:1.0f alpha:0.7f];
        _label.alpha = 0.0f;
        [self addSubview:_label];
        
        //Icon View
        _iconView = [[ABEntypoView alloc] initWithIconName:nil size:40.0f];
        _iconView.frame = CGRectCenteredWithCGRect(_iconView.frame, _circleView.bounds);
        _iconView.color = [UIColor whiteColor];
        _iconView.alpha = 0.0f;
        [_circleView addSubview:_iconView];
        
        //Set circleView corner radius
        self.cornerRadius = self.cornerRadius;
        
        //Tap gesture
        [ABTapGestureRecognizer singleTapGestureOnView:_backgroundView target:self action:@selector(backgroundViewSelected)];
    }
    return self;
}



#pragma mark - Utility
#pragma mark - Show
+(void) showActivity
{
    [ABHud showActivity:nil];
}

+(void) showActivityWithTouchHandler:(ABBlockVoid)touchHandler
{
    [ABHud showActivity:nil touchHandler:touchHandler];
}

+(void) showActivity:(NSString*)message
{
    [ABHud showActivity:message touchHandler:nil];
}

+(void) showActivity:(NSString*)message touchHandler:(ABBlockVoid)touchHandler
{
    [ABHud sharedClass].message = message;
    [ABHud sharedClass].touchHandler = [touchHandler copy];
    [[ABHud sharedClass] show:YES];
}

+(void) showActivityAndHide
{
    [ABHud showActivity:nil];
    [[ABHud sharedClass] scheduleHide:2.0f];
}



#pragma mark - Dismiss
+(void) dismiss
{
    [ABHud dismissWithIconName:nil message:nil];
}

+(void) dismissWithSuccess:(NSString*)message
{
    [ABHud dismissWithIconName:@"check" message:message];
}

+(void) dismissWithError:(NSString*)message
{
    [ABHud dismissWithIconName:@"cross" message:message];
}

+(void) dismissWithIconName:(NSString*)iconName message:(NSString*)message
{
    [ABHud sharedClass].message = message;
    [[ABHud sharedClass] fadeLabelIn:YES];
    
    if (iconName) [[ABHud sharedClass] fadeActivityIn:NO animated:NO];
    
    [ABHud sharedClass].iconView.iconName = iconName;
    [[ABHud sharedClass] fadeIconIn:YES];
    
    if (message)
    {
        [[ABHud sharedClass] scheduleHide:1.0f];
    }
    else
    {
        [[ABHud sharedClass] hide];
    }
}



#pragma mark - Logic
-(void) show
{
    [self show:YES];
}

-(void) show:(BOOL)show
{
    if (show)
    {
        [self addToView];
    }
    
    //Choose correct animation
    if (self.animationType == ABHudAnimationTypeBounce)
    {
        [self bounceCircleViewIn:show];
    }
    else if (self.animationType == ABHudAnimationTypePop)
    {
        [self popCircleViewIn:show];
    }
    else if (self.animationType == ABHudAnimationTypeFade)
    {
        [self fadeCircleViewIn:show];
    }
    
    [self fadeLabelIn:NO];
}

-(void) hide
{
    [self show:NO];
}

-(void) addToView
{
    [[UIView topWindowView] addSubview:self];
}

-(void) scheduleHide:(NSInteger)seconds
{
    [_hideTimer invalidate];
    _hideTimer = nil;
    _hideTimer = [NSTimer scheduledTimerWithTimeInterval:seconds target:self selector:@selector(hide) userInfo:nil repeats:NO];
}



#pragma mark - Selection
-(void) backgroundViewSelected
{
    if (self.touchHandler)
    {
        self.touchHandler();
        self.touchHandler = nil;
    }
}



#pragma mark - Animation
-(void) fadeLabelIn:(BOOL)fadeIn
{
    [UIView animateWithDuration:0.2f delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        self.label.alpha = (fadeIn) ? 1.0f : 0.0f;
        
    } completion:nil];
}

-(void) fadeIconIn:(BOOL)fadeIn
{
    [UIView animateWithDuration:0.2f delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        self.iconView.alpha = (fadeIn) ? 1.0f : 0.0f;
        
    } completion:nil];
}

-(void) fadeActivityIn:(BOOL)fadeIn animated:(BOOL)animated
{
    if (animated)
    {
        [UIView animateWithDuration:0.2f delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            
            self.activityView.alpha = (fadeIn) ? 1.0f : 0.0f;
            
        } completion:nil];
    }
    else
    {
        self.activityView.alpha = (fadeIn) ? 1.0f : 0.0f;
    }
}

-(void) bounceCircleViewIn:(BOOL)bounceIn
{
    CGRect centerRect = CGRectCenteredWithCGRect(_circleView.frame, self.bounds);
    CGRect centerRectOffset = CGRectOffsetOriginY(centerRect, 30);
    CGRect outsideTopRect = CGRectChangingOriginY(_circleView.frame, 0 - _circleView.frame.size.height);
    
    [UIView animateWithDuration:0.2f delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        //Fade background
        _backgroundView.alpha = (bounceIn) ? 0.5f : 0.0f;
        //Move circle
        _circleView.frame = (bounceIn) ? centerRectOffset : outsideTopRect;
        
    } completion:^(BOOL finished) {
        
        //In
        if (bounceIn)
        {
            [UIView animateWithDuration:0.1f delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
                
                _circleView.frame = centerRect;
                
            } completion:^(BOOL finished) {
                
                //Perform post animation logic
                [self animationDone:bounceIn];
                
            }];
        }
        
    }];
}

-(void) popCircleViewIn:(BOOL)popIn
{
    [UIView animateWithDuration:0.2f delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        //Fade background
        _backgroundView.alpha = (popIn) ? 0.5f : 0.0f;
        //Scale circle
        _circleView.transform = CGAffineTransformMakeScale(1.2f, 1.2f);
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.1f delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
            
            //Scale circle
            _circleView.transform = (popIn) ? CGAffineTransformMakeScale(1.0f, 1.0f) : CGAffineTransformMakeScale(0.01f, 0.01f);
            
        } completion:^(BOOL finished) {
            
            //Perform post animation logic
            [self animationDone:popIn];
            
        }];
        
    }];
}

-(void) fadeCircleViewIn:(BOOL)fadeIn
{
    [UIView animateWithDuration:0.3f delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        //Fade background
        _backgroundView.alpha = (fadeIn) ? 0.5f : 0.0f;
        //Fade circle
        _circleView.alpha = (fadeIn) ? ABHUD_OPACITY : 0.0f;
    } completion:^(BOOL finished) {
        //Perform post animation logic
        [self animationDone:fadeIn];
    }];
}

-(void) animationDone:(BOOL)isIn
{
    //If enter animation is done and hide is schedule perform hide
    if (isIn && _hideScheduled)
    {
        [self hide];
    }
    
    //If exit animation is done hide ABHud
    if (!isIn)
    {
        //Reset state
        self.iconView.iconName = nil;
        [self fadeActivityIn:YES animated:NO];
        
        [self removeFromSuperview];
    }
}



#pragma mark - Config
+(void) setAnimationType:(ABHudAnimationType)animationType
{
    [ABHud sharedClass].animationType = animationType;
}

+(void) setCornerRadius:(CGFloat)cornerRadius
{
    [ABHud sharedClass].cornerRadius = cornerRadius;
}



#pragma mark - Accessors
-(void) setMessage:(NSString *)message
{
    _message = message;
    
    self.label.text = _message;
}

-(void) setAnimationType:(ABHudAnimationType)animationType
{
    _animationType = animationType;
    
    //Default values for circle view
    _circleView.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
    _circleView.frame = CGRectCenteredWithCGRect(_circleView.frame, self.bounds);
    _circleView.alpha = ABHUD_OPACITY;
    
    //Prepare circle view for animation type
    if (_animationType == ABHudAnimationTypeBounce)
    {
        _circleView.frame = CGRectChangingOriginY(_circleView.frame, 0 - _circleView.frame.size.height);
    }
    else if (_animationType == ABHudAnimationTypePop)
    {
        _circleView.transform = CGAffineTransformMakeScale(0.01f, 0.01f);
    }
    else if (_animationType == ABHudAnimationTypeFade)
    {
        _circleView.alpha = 0.0f;
    }
}

-(void) setCornerRadius:(CGFloat)cornerRadius
{
    _circleView.layer.cornerRadius = cornerRadius;
}

@end
