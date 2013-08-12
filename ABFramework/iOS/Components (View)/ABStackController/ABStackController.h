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
-(void) addView:(UIView *)newView appendPadding:(CGFloat)padding;
-(void) addView:(UIView *)newView prependPadding:(CGFloat)padding;
-(void) addViewIgnoringRowBackgroundColor:(UIView*)newView;
-(void) addView:(UIView*)newView centered:(BOOL)centered;
-(void) addView:(UIView*)newView centered:(BOOL)centered backgroundColor:(UIColor*)backgroundColor;
-(void) addViews:(NSArray*)newViews;

//Add Padding
-(void) addPadding:(CGFloat)padding;
-(void) addPaddingIgnoringRowBackgroundColor:(CGFloat)padding;
-(void) addPadding:(CGFloat)padding backgroundColor:(UIColor*)backgroundColor;

//Add Seperators
-(void) addOnePointSeperator:(UIColor*)color;
-(void) addOnePointSeperator:(UIColor*)color preAndAppendPadding:(CGFloat)padding;
-(void) addSeperator:(UIColor*)color height:(CGFloat)height;
-(void) addSeperator:(UIColor*)color height:(CGFloat)height preAndAppendPadding:(CGFloat)padding;

//Interaction
-(void) scrollToTop; //Only available when a fixed height is set
-(void) scrollToBottom;

//Access
-(UIScrollView*) uiScrollView;

//Config
/**
 * delayTouch
 * Delay touches on scrollView (Only available when a fixed height is set)
 * Default: NO
 */
@property (nonatomic, assign) BOOL delayTouch;

/**
 * rowBackgroundColor
 * Set this property to automatically add a background color behind each added view / padding
 * Default: nil
 */
@property (nonatomic, copy) UIColor *rowBackgroundColor;


//Access
@property (nonatomic, strong, readonly) NSArray *stackViews;

@end
