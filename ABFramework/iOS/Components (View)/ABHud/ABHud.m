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
{
    BOOL _hideScheduled;
    
    NSTimer *_hideTimer;
    UIView *_backgroundView;
    UIView *_circleView;
    ABLabel *_label;
    
    //Config
    ABHudAnimationType _configAnimationType;
}
@end

@implementation ABHud

#pragma mark - Singleton
+(id) sharedClass
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
        _hideScheduled = NO;
        
        //Background view
        _backgroundView = [[UIView alloc] initWithFrame:self.bounds];
        _backgroundView.backgroundColor = [UIColor blackColor];
        _backgroundView.alpha = 0.0f;
        [self addSubview:_backgroundView];
        
        //Circle view
        _circleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        _circleView.frame = CGRectCenteredWithCGRect(_circleView.frame, self.bounds);
        _circleView.backgroundColor = [UIColor blackColor];
        _circleView.alpha = ABHUD_OPACITY;
        [self addSubview:_circleView];
        
        //Activity View
        UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        activityView.frame = CGRectCenteredWithCGRect(activityView.frame, _circleView.bounds);
        [activityView startAnimating];
        [_circleView addSubview:activityView];
        
        //Label
        _label = [ABLabel new];
        _label.frame = CGRectMake(0, 0, 200, 50);
        _label.frame = CGRectCenteredWithCGRect(_label.frame, self.bounds);
        _label.backgroundColor = [UIColor greenColor];
        //[self addSubview:_label];
        
        //Config
        [self setSharedAnimationType:ABHUD_ANIMATION_TYPE];
        [self setSharedCornerRadius:(ABHUD_CORNER_RADIUS == -1) ? _circleView.bounds.size.width / 2 : ABHUD_CORNER_RADIUS];
    }
    return self;
}



#pragma mark - Utility
#pragma mark - Show
+(void) showActivity
{
    [[ABHud sharedClass] show:YES];
}

+(void) showActivityAndHide
{
    [ABHud showActivityAndHide:nil];
}

+(void) showActivityAndHide:(NSString*)text
{
    [[ABHud sharedClass] show:YES];
    [[ABHud sharedClass] scheduleHide:2];
}


#pragma mark - Dismiss
+(void) dismiss
{
    [[ABHud sharedClass] hide];
}



#pragma mark - Logic
-(void) show:(BOOL)show
{
    if (show)
    {
        [self addToView];
    }
    
    //Choose correct animation
    if (_configAnimationType == ABHudAnimationTypeBounce)
    {
        [self bounceCircleViewIn:show];
    }
    else if (_configAnimationType == ABHudAnimationTypePop)
    {
        [self popCircleViewIn:show];
    }
    else if (_configAnimationType == ABHudAnimationTypeFade)
    {
        [self fadeCircleViewIn:show];
    }
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



#pragma mark - Animation
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
        [self removeFromSuperview];
    }
}



#pragma mark - Accessors
#pragma mark - AnimationType
+(void) setAnimationType:(ABHudAnimationType)type
{
    [[ABHud sharedClass] setSharedAnimationType:type];
}
-(void) setSharedAnimationType:(ABHudAnimationType)type
{
    _configAnimationType = type;
    
    //Default values for circle view
    _circleView.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
    _circleView.frame = CGRectCenteredWithCGRect(_circleView.frame, self.bounds);
    _circleView.alpha = ABHUD_OPACITY;
    
    //Prepare circle view for animation type
    if (_configAnimationType == ABHudAnimationTypeBounce)
    {
        _circleView.frame = CGRectChangingOriginY(_circleView.frame, 0 - _circleView.frame.size.height);
    }
    else if (_configAnimationType == ABHudAnimationTypePop)
    {
        _circleView.transform = CGAffineTransformMakeScale(0.01f, 0.01f);
    }
    else if (_configAnimationType == ABHudAnimationTypeFade)
    {
        _circleView.alpha = 0.0f;
    }
}

#pragma mark - CornerRadius
+(void) setCornerRadius:(CGFloat)cornerRadius
{
    [[ABHud sharedClass] setSharedCornerRadius:cornerRadius];
}
-(void) setSharedCornerRadius:(CGFloat)cornerRadius
{
    _circleView.layer.cornerRadius = cornerRadius;
}

@end
