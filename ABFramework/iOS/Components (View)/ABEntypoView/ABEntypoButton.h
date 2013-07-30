//
//  ABEntypoButton.h
//  ABFramework
//
//  Created by Alexander Blunck on 7/17/13.
//  Copyright (c) 2013 Ablfx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ABEntypoButton : UIButton

//Initializer
-(id) initWithFrame:(CGRect)frame iconName:(NSString*)iconName iconSize:(CGFloat)iconSize;

//UIBarButtonItem
-(UIBarButtonItem*) barButtonItem;

//Action
-(void) addTouchUpInsideTarget:(id)target action:(SEL)selector;

@property (nonatomic, copy) UIColor *iconColor;
@property (nonatomic, copy) UIColor *iconColorSelected;

@end
