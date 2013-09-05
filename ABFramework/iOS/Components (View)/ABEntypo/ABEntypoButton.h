//
//  ABEntypoButton.h
//  ABFramework
//
//  Created by Alexander Blunck on 7/17/13.
//  Copyright (c) 2013 Ablfx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ABEntypoButton : UIButton

//Utility
+(id) buttonWithIconName:(NSString*)iconName size:(CGFloat)size;
+(id) buttonWithIconName:(NSString*)iconName size:(CGFloat)size frame:(CGRect)frame;

//Initializer
-(id) initWithIconName:(NSString*)iconName size:(CGFloat)size frame:(CGRect)frame;

//Action
-(void) addTouchUpInsideTarget:(id)target action:(SEL)selector;

@property (nonatomic, copy) NSString *iconName;
@property (nonatomic, copy) UIColor *iconColor;
@property (nonatomic, copy) UIColor *iconColorSelected;

@end
