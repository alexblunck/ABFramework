//
//  ABView.h
//  ABFramework
//
//  Created by Alexander Blunck on 2/10/13.
//  Copyright (c) 2013 Ablfx. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ABView;

typedef void (^ABViewTouchHandler) (ABView *);
typedef void (^ABViewDoubleTouchHandler) (ABView *);

//ABViewDelegate
@protocol ABViewDelegate <NSObject>
@optional
-(void) abViewDidTouchUpInside:(ABView*)view;
-(void) abViewDidDoubleTouchUpInside:(ABView*)view;
-(void) abViewDidStartTouch:(ABView*)view;
-(void) abViewDidEndTouch:(ABView*)view;
@end

//ABView
@interface ABView : UIView <ABViewSelectionProtocol>

//Initializer
/**
 * Init view with background image, view will be resized to fit image
 */
-(id) initWithBackgroundImageName:(NSString*)backgroundImageName;
-(id) initWithBackgroundImage:(UIImage*)backgroundImage;
-(id) initWithBackgroundImage:(UIImage*)backgroundImage resize:(BOOL)resize;

//Target / Selector
-(void) setTarget:(id)target selector:(SEL)selector;

/**
 * Delegate
 */
@property (nonatomic, weak) id <ABViewDelegate> delegate;

/**
 * Background color when view is selected (Either by touch or "selected" property)
 */
@property (nonatomic, strong) UIColor *selectedBackgroundColor;

/**
 * Animate background color selection, default YES 
 */
@property (nonatomic, assign) BOOL animateBackgroundColor;

/**
 * Background color animation duration, default 0.2f
 */
@property (nonatomic, assign) CGFloat animationDuration;

/**
 * Background image name, view is resized to fit image
 */
@property (nonatomic, copy) NSString *backgroundImageName;
@property (nonatomic, copy) UIImage *backgroundImage;

/**
 * Background image name when view is selected (Either by touch or "selected" property)
 */
@property (nonatomic, copy) NSString *selectedBackgroundImageName;

/**
 * Set alpha of image to 0.6 on touch down, default is NO
 */
@property (nonatomic, assign) BOOL dimBackgroundImageOnSelect;

/**
 * Set selected state, if "selectedBackgroundColor" is set it will be used
 */
@property (nonatomic, assign, getter=isSelected) BOOL selected;

/**
 * Respond to touches when selected property is set to YES
 */
@property (nonatomic, assign) BOOL permitTouchWhileSelected;

/**
 * Amount of points a touch can be moved before it's considered cancelled, default is 30.0f
 */
@property (nonatomic, assign) CGFloat touchMoveToleration;

/**
 * Recursively propegate selected state to all subviews and their subviews and so on, default is NO
 */
@property (nonatomic, assign) BOOL selectRecursively;

/**
 * Block based touch handler when a touch on view has ended aka "TouchUpInside" (Alternative to delegate pattern)
 */
@property (nonatomic, copy) ABViewTouchHandler touchHandler;
@property (nonatomic, copy) ABViewDoubleTouchHandler doubleTouchHandler;

@end
