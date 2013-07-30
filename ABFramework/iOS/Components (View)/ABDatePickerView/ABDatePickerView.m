//
//  ABDatePickerView.m
//  ABFramework
//
//  Created by Alexander Blunck on 10/10/12.
//  Copyright (c) 2012 Ablfx. All rights reserved.
//

#import "ABDatePickerView.h"

@interface ABDatePickerView ()
{
    UIView *_presentingView;
    
    UIImageView *_blurredView;
    UIView *_backgroundView;
    UIView *_dateView;
    ABBlockObject _completionBlock;
    
    NSDate *_date;
}
@end

@implementation ABDatePickerView

#pragma mark - Initializer
-(id) initWithDate:(NSDate*)date completion:(ABBlockObject)block
{
    self = [super init];
    if (self)
    {
        //Config
        self.translucent = NO;
        self.callCompletionBlockAfterHideAnimation = NO;
        
        _presentingView = [UIView topView];
        _completionBlock = [block copy];
        _date = date;
    }
    return self;
}



#pragma mark - LifeCycle
-(void) willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    
    self.frame = _presentingView.bounds;
    
    [self layout];
    
    [ABTapGestureRecognizer tapGestureWithTaps:1 onView:_backgroundView block:^{
        [self hide];
    }];
}



#pragma mark - Layout
-(void) layout
{
    if (self.translucent)
    {
        UIImage *screenImage = [_presentingView renderCGRect:_presentingView.bounds];
        screenImage = [screenImage applyBlurWithRadius:5.0f tintColor:nil saturationDeltaFactor:1.0f maskImage:nil];
        _blurredView = [[UIImageView alloc] initWithImage:screenImage];
        _blurredView.alpha = 0.0f;
        [self addSubview:_blurredView];
    }
    
    _backgroundView = [[UIView alloc] initWithFrame:self.bounds];
    _backgroundView.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.5f];
    _backgroundView.alpha = 0.0f;
    [self addSubview:_backgroundView];
    
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.width, 44)];
    toolbar.barStyle = UIBarStyleBlack;
    toolbar.translucent = YES;
    toolbar.tintColor = [UIColor colorWithRed:0.380 green:0.784 blue:0.973 alpha:1.000];
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonSelected)];
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelButtonSelected)];
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *tomorrowButton = [[UIBarButtonItem alloc] initWithTitle:@"Tomorrow" style:UIBarButtonItemStyleBordered target:self action:@selector(tomorrowButtonSelected)];
    toolbar.items = @[tomorrowButton, flexibleSpace, cancelButton, doneButton];
    
    self.datePicker = [UIDatePicker new];
    self.datePicker.datePickerMode = UIDatePickerModeDate;
    self.datePicker.minimumDate = [NSDate date];
    self.datePicker.date = _date;
    
    UIView *datePickerBackground = [[UIView alloc] initWithFrame:self.datePicker.bounds];
    datePickerBackground.frame = CGRectChangingOriginY(datePickerBackground.frame, toolbar.bottom);
    datePickerBackground.backgroundColor = [UIColor whiteColor];
    [datePickerBackground addSubview:self.datePicker];
    
    _dateView = [[UIView alloc] initWithFrame:cgr(0, 0, self.width, toolbar.height + self.datePicker.height)];
    _dateView.frame = CGRectChangingOriginY(_dateView.frame, self.height);
    [self addSubview:_dateView];
    
    [_dateView addSubview:toolbar];
    [_dateView addSubview:datePickerBackground];
}



#pragma mark - Show / Hide
-(void) show
{
    [_presentingView addSubview:self];
    
    [UIView animateWithDuration:0.2f delay:0 options:0 animations:^{
        
        _backgroundView.alpha = 1.0f;
        if (self.translucent) _blurredView.alpha = 1.0f;
        _dateView.frame = CGRectInsideBottomCenter(_dateView.frame, self.bounds, 0);
        
    } completion:nil];
}

-(void) hide
{
    [self hideWithSelectedDate:nil];
}

-(void) hideWithSelectedDate:(NSDate*)date
{
    if (!self.callCompletionBlockAfterHideAnimation && date && _completionBlock)
    {
        _completionBlock(date);
    }
    
    [UIView animateWithDuration:0.2f delay:0 options:0 animations:^{
        
        _backgroundView.alpha = 0.0f;
        if (self.translucent) _blurredView.alpha = 0.0f;
        _dateView.frame = CGRectChangingOriginY(_dateView.frame, self.height);
        
    } completion:^(BOOL finished) {
        
        if (self.callCompletionBlockAfterHideAnimation && date && _completionBlock)
        {
            _completionBlock(date);
        }
        
        [self removeFromSuperview];
        
    }];
}



#pragma mark - Buttons
-(void) doneButtonSelected
{
    _date = [self.datePicker.date midnight];
    [self hideWithSelectedDate:_date];
}

-(void) cancelButtonSelected
{
    [self hide];
}

-(void) tomorrowButtonSelected
{
    NSDate *now = [NSDate date];
    _date = [now dateDaysAfter:1];
    _datePicker.date = _date;
}

@end
