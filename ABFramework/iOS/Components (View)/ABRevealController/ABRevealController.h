//
//  ABRevealController.h
//  ABFramework
//
//  Created by Alexander Blunck on 6/12/13.
//  Copyright (c) 2013 Alexander Blunck. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ABRevealController;

@protocol ABRevealControllerDelegate <NSObject>
@optional
-(void) abRevealController:(ABRevealController*)controller didMoveToPercent:(NSInteger)percent jumpDistance:(CGFloat)distance;
@end



@interface ABRevealController : UIViewController

//Initializer
-(id) initWithFrontViewController:(UIViewController*)frontVc backgroundViewController:(UIViewController*)backgroundVc;


//Actions
-(void) toggleReveal;
-(void) toggleRevealAnimated:(BOOL)animated;

//Access
-(UITapGestureRecognizer*) tapGestureRecognizer;

@property (nonatomic, strong) UIViewController *frontViewController;
@property (nonatomic, strong) UIViewController *backgroundViewController;

//Config
/**
 * revealWidth
 *
 * Width of area of the background view to be revealed
 * Default: Half of screen width
 */
@property (nonatomic, assign) CGFloat revealWidth;

/**
 * animationSpeed
 *
 * Base animation length to reveal the full revealWidth, automatially adjusts for
 * shorter distances
 * Default: 0.4s
 */
@property (nonatomic, assign) NSTimeInterval animationSpeed;

/**
 * allowOverSliding
 * 
 * Allow the front view to be slided past the set revealWidth.
 * Will animate to revealWidth when released
 * Default: YES
 */
@property (nonatomic, assign) BOOL allowOverSliding;

/**
 * parallaxRevealEnabled
 *
 * If enabled the background view will slide in with the front view in a parallax fashion
 * Default: YES
 */
@property (nonatomic, assign) BOOL parallaxRevealEnabled;

/**
 * allowOverParallax
 *
 * If enabled the background view itself will slide past the set revealWidth when dragged.
 * Will animate to revealWidth when released
 * Only has an effect when "allowOverSliding" & "parallaxRevealEnabled" is enabled
 * Default: NO
 */
@property (nonatomic, assign) BOOL allowOverParallax;

/**
 * parallaxRevealDampening
 *
 * Dampening factor that is applied to the parralax effect if "parallaxRevealEnabled" is enabled
 * Default: 3.0f
 */
@property (nonatomic, assign) CGFloat parallaxRevealDampening;

/**
 * Shadow
 *
 * Drop shadow for the front view, disabled by default
 */
@property (nonatomic, assign) BOOL shadowEnabled;       //Default: NO
@property (nonatomic, assign) CGFloat shadowOpactiy;    //Default: 0.8f
@property (nonatomic, assign) CGFloat shadowRadius;     //Default: 5.0f
@property (nonatomic, copy) UIColor *shadowColor;       //Default: blackColor

/**
 * disablePanGesture
 * 
 * Disable slide gesture recognizer on front view
 * Default: NO
 */
@property (nonatomic, assign) BOOL disablePanGesture;


//State
@property (nonatomic, assign, readonly, getter = isRevealed) BOOL revealed;


//Delegates
@property (nonatomic, weak) id <ABRevealControllerDelegate> delegate;
@property (nonatomic, weak) id <ABOrientationProtocol> orientationDelegate;

@end



#pragma mark - UIViewController+ABRevealController
@interface UIViewController (ABRevealController)
@property (nonatomic, weak) ABRevealController *revealController;
@end
