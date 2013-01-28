//
//  ABDatePickerView.m
//  ABFramework
//
//  Created by Alexander Blunck on 10/10/12.
//  Copyright (c) 2012 Ablfx. All rights reserved.
//

#import "ABDatePickerView.h"

@interface ABDatePickerView () {
    CGRect applicationFrame;
    UIView *contentView;
    UIDatePicker *datePicker;
    void (^completionBlock) (NSDate* selectedDate);
}
@end

@implementation ABDatePickerView

-(void) doneButtonSelected {
    [self hide];
}

-(void) tomorrowButtonSelected {
    datePicker.date = [[NSDate dateFromYear:[[NSDate date] year] month:[[NSDate date] monthOfYear] day:[[NSDate date] dayOfMonth] hour:0 minute:0] dateDaysAfter:1];
}

-(id) initWithDate:(NSDate*)date completionBlock:( void (^) (NSDate* selectedDate) )block
{
    self = [super init];
    if (self) {
        
        completionBlock = block;
        
        applicationFrame = [[UIScreen mainScreen] applicationFrame];
        self.frame = CGRectMake(0, 0, applicationFrame.size.width, applicationFrame.size.height);
        self.backgroundColor = [UIColor clearColor];
        self.opaque = NO;
        
        UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, applicationFrame.size.width, applicationFrame.size.height-216-44)];
        [self addSubview:backgroundView];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doneButtonSelected)];
        [backgroundView addGestureRecognizer:tapGesture];
        
        contentView = [[UIView alloc] initWithFrame:CGRectMake(0, applicationFrame.size.height+44+216, applicationFrame.size.width, 44+216)];
        [self addSubview:contentView];
        
        //DatePicker
        datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 44, applicationFrame.size.width, 216)];
        datePicker.datePickerMode = UIDatePickerModeDate;
        datePicker.minimumDate = [[NSDate date] dateDaysAfter:1];
        //datePicker.maximumDate = [[NSDate date] dateDaysAfter:10000];
        datePicker.date = date;
        [contentView addSubview:datePicker];
        
        UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, applicationFrame.size.width, 44)];
        toolbar.barStyle = UIBarStyleBlack;
        toolbar.translucent = YES;
        [contentView addSubview:toolbar];
         
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

-(void) show {
    
    [[[[[UIApplication sharedApplication] keyWindow] rootViewController] view] addSubview:self];
    
    [UIView animateWithDuration:0.4f animations:^{
        self.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.400];
        contentView.frame = CGRectMake(0, applicationFrame.size.height-contentView.frame.size.height, contentView.frame.size.width, contentView.frame.size.height);
    } completion:^(BOOL finished) {
        //
    }];
}

-(void) hide {
    completionBlock(datePicker.date);
    
    [UIView animateWithDuration:0.3f animations:^{
        self.backgroundColor = [UIColor clearColor];
        contentView.frame = CGRectMake(0, applicationFrame.size.height+contentView.frame.size.height, contentView.frame.size.width, contentView.frame.size.height);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@end
