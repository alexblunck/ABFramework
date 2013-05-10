//
//  ABStackController.h
//  ABFramework
//
//  Created by Alexander Blunck on 2/6/13.
//  Copyright (c) 2013 Ablfx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ABStackController : ABView

//Initializer
-(id) initWithWidth:(CGFloat)width fixedHeight:(CGFloat)fixedHeight;

//Reset
-(void) resetStack;

//Add Views
-(void) addView:(UIView*)newView;
-(void) addView:(UIView*)newView centered:(BOOL)centered;
-(void) addViews:(NSArray*)newViews;

//Add Padding
-(void) addPadding:(CGFloat)padding;

//Interaction
-(void) scrollToTop; //Only available when a fixed height is set
-(void) scrollToBottom;

//Access
-(UIScrollView*) uiScrollView;

//Config
//Delay touches on scrollView (Only available when a fixed height is set), default is NO
@property (nonatomic, assign) BOOL delayTouch;

//Access
@property (nonatomic, strong) NSArray *stackViews;

@end
