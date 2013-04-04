//
//  ABDatePickerView.m
//  ABFramework
//
//  Created by Alexander Blunck on 10/10/12.
//  Copyright (c) 2012 Ablfx. All rights reserved.
//

#import "ABDatePickerView.h"

@interface ABDatePickerView () {
    CGRect _applicationFrame;
    UIView *_contentView;
    UIDatePicker *_datePicker;
    void (^_completionBlock) (NSDate* selectedDate);
}
@end

@implementation ABDatePickerView

#pragma mark - Initializer
-(id) initWithDate:(NSDate*)date completionBlock:( void (^) (NSDate* selectedDate) )block
{
    self = [super init];
    if (self) {
        
        _completionBlock = block;
        
        _applicationFrame = [[UIView topView] bounds];
        self.frame = CGRectMake(0, 0, _applicationFrame.size.width, _applicationFrame.size.height);
        self.backgroundColor = [UIColor clearColor];
        self.opaque = NO;
        
        UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _applicationFrame.size.width, _applicationFrame.size.height-216-44)];
        [self addSubview:backgroundView];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doneButtonSelected)];
        [backgroundView addGestureRecognizer:tapGesture];
        
        _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, _applicationFrame.size.height+44+216, _applicationFrame.size.width, 44+216)];
        [self addSubview:_contentView];
        
        //DatePicker
        _datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 44, _applicationFrame.size.width, 216)];
        _datePicker.datePickerMode = UIDatePickerModeDate;
        _datePicker.minimumDate = [[NSDate date] dateDaysAfter:1];
        //_datePicker.maximumDate = [[NSDate date] dateDaysAfter:10000];
        _datePicker.date = date;
        [_contentView addSubview:_datePicker];
        
        UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, _applicationFrame.size.width, 44)];
        toolbar.barStyle = UIBarStyleBlack;
        toolbar.translucent = YES;
        [_contentView addSubview:toolbar];
         
        //Done Button
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonSelected)];
        
        //Flexible space
        UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        
        //Tomorrow Button
        UIBarButtonItem *tomorrowButton = [[UIBarButtonItem alloc] initWithTitle:@"Tomorrow" style:UIBarButtonItemStyleBordered target:self action:@selector(tomorrowButtonSelected)];
        
        toolbar.items = @[tomorrowButton, flexibleSpace, doneButton];
    }
    return self;
}



#pragma mark - Buttons
-(void) doneButtonSelected
{
    [self hide];
}

-(void) tomorrowButtonSelected
{
    NSDate *now = [NSDate date];
    _datePicker.date = [NSDate dateFromYear:now.year month:now.monthOfYear day:now.dayOfMonth hour:0 minute:0 second:0];
}



#pragma mark - Triggers
-(void) show
{
    [[UIView topView] addSubview:self];
    
    [UIView animateWithDuration:0.4f animations:^{
        self.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.400];
        _contentView.frame = CGRectMake(0, _applicationFrame.size.height-_contentView.frame.size.height, _contentView.frame.size.width, _contentView.frame.size.height);
    } completion:^(BOOL finished) {
        //
    }];
}



#pragma mark - Helper
-(void) hide
{
    _completionBlock(_datePicker.date);
    
    [UIView animateWithDuration:0.3f animations:^{
        self.backgroundColor = [UIColor clearColor];
        _contentView.frame = CGRectMake(0, _applicationFrame.size.height+_contentView.frame.size.height, _contentView.frame.size.width, _contentView.frame.size.height);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@end
