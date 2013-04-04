//
//  ABTableStackController.h
//  ABFramework
//
//  Created by Alexander Blunck on 3/8/13.
//  Copyright (c) 2013 Ablfx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ABTableStackController : UIView

//Initializer
-(id) initWithWidth:(CGFloat)width fixedHeight:(CGFloat)fixedHeight;

//Reset
-(void) resetStack;

//Add Views
-(void) addView:(UIView*)newView;
-(void) addView:(UIView*)newView centered:(BOOL)centered;
-(void) addViews:(NSArray*)newViews;
-(void) addViews:(NSArray*)newViews centered:(BOOL)centered;

//Add Padding
-(void) addPadding:(CGFloat)padding;

//Interaction
-(void) scrollToTop; //Only available when a fixed height is set

//Config
//Delay touches on scrollView (Only available when a fixed height is set), default is NO
@property (nonatomic, assign) BOOL delayTouch;

@end
