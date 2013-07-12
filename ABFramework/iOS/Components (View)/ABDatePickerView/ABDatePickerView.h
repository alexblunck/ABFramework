//
//  ABDatePickerView.h
//  ABFramework
//
//  Created by Alexander Blunck on 10/10/12.
//  Copyright (c) 2012 Ablfx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ABDatePickerView : ABView

//Initializer
-(id) initWithDate:(NSDate*)date completion:(ABBlockObject)block;

//Show / Hide
-(void) show;

@property (nonatomic, strong) UIDatePicker *datePicker;


//Config
@property (nonatomic, assign) BOOL translucent;

@end
