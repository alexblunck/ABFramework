//
//  ABDatePickerView.h
//  ABFramework
//
//  Created by Alexander Blunck on 10/10/12.
//  Copyright (c) 2012 Ablfx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ABDatePickerView : UIView

-(id) initWithDate:(NSDate*)date completionBlock:( void (^) (NSDate* selectedDate) )block;
-(void) show;

@end
