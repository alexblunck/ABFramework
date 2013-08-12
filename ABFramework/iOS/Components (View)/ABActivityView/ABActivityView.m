//
//  ABActivityView.m
//  ABFramework
//
//  Created by Alexander Blunck on 2/12/13.
//  Copyright (c) 2013 Ablfx. All rights reserved.
//

#import <Twitter/Twitter.h>
#import <Social/Social.h>
#import "ABActivityView.h"

#define SLIDEVIEW_ANIMATION_DUR 0.3f
#define SOCIAL_BUTTON_PADDING 50.0f

@interface ABActivityView ()
{
    UIViewController *_presentingViewController;
    UIView *_backgroundView;
    UIImageView *_slideView;
}
@end

@implementation ABActivityView

#pragma mark - Initializer
- (id)initWithViewController:(UIViewController*)viewController
{
    self = [super init];
    if (self)
    {
        _presentingViewController = viewController;
        
        //Set frame to parent viewController frame
        self.frame = viewController.view.bounds;
        
        //Background View
        _backgroundView = [[UIView alloc] initWithFrame:self.bounds];
        _backgroundView.backgroundColor = [UIColor blackColor];
        _backgroundView.alpha = 0.0f;
        [self addSubview:_backgroundView];
        
        //Tap Gesture Recognizer on background view
        [_backgroundView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissView)]];
        
        //Slide View
        _slideView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ABFramework.bundle/ABActivityView/ABActivityView-bg"]];
        _slideView.frame = CGRectChangingOriginY(_slideView.frame, self.bounds.size.height);
        _slideView.userInteractionEnabled = YES;
        [self addSubview:_slideView];
        
        //Cancel Button
        ABButton *cancelButton = [ABButton buttonWithImageName:@"ABFramework.bundle/ABActivityView/ABActivityView-button-cancel"
                                                        target:self
                                                      action:@selector(dismissView)];
        cancelButton.frame = CGRectCenteredHorizontally(cancelButton.frame, self.bounds, 145);
        [_slideView addSubview:cancelButton];
        
        //Twitter Button
        ABButton *twitterButton = [ABButton buttonWithImageName:@"ABFramework.bundle/ABActivityView/ABActivityView-button-twitter"
                                                        target:self
                                                      action:@selector(twitterButtonSelected)];
        
        //Facebook Button
        ABButton *facebookButton = [ABButton buttonWithImageName:@"ABFramework.bundle/ABActivityView/ABActivityView-button-facebook"
                                                         target:self
                                                       action:@selector(facebookButtonSelected)];
        
        //Button Containment View
        UIView *buttonContaimentView = [UIView new];
        buttonContaimentView.frame = CGRectChangingSize(CGRectZero, (twitterButton.bounds.size.width*2)+SOCIAL_BUTTON_PADDING, twitterButton.bounds.size.height);
        buttonContaimentView.frame = CGRectCenteredHorizontally(buttonContaimentView.frame, _slideView.frame, 40);
        [_slideView addSubview:buttonContaimentView];
        
        //Add buttons (Facebook only on iOS 6 +)
        if (IS_MIN_IOS6)
        {
            twitterButton.frame = CGRectChangingOrigin(twitterButton.frame, 0, 0);
            facebookButton.frame = CGRectInsideRightCenter(facebookButton.frame, buttonContaimentView.bounds, 0);
        }
        else
        {
            twitterButton.frame = CGRectCenteredWithCGRect(twitterButton.frame, buttonContaimentView.bounds);
        }
        
        [buttonContaimentView addSubview:twitterButton];
        if (IS_MIN_IOS6) [buttonContaimentView addSubview:facebookButton];
    }
    return self;
}



#pragma mark - LifeCycle
-(void) willMoveToSuperview:(UIView *)newSuperview
{
    [UIView animateWithDuration:SLIDEVIEW_ANIMATION_DUR delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _backgroundView.alpha = 0.4f;
        _slideView.frame = CGRectInsideBottomCenter(_slideView.frame, self.bounds, 0);
    } completion:^(BOOL finished) {
        //
    }];
}



#pragma mark - Display
-(void) show
{
    //Add to parent viewController
    [[(UIViewController*)_presentingViewController view] addSubview:self];
}



#pragma mark - Buttons
-(void) dismissView
{
    [UIView animateWithDuration:SLIDEVIEW_ANIMATION_DUR delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _backgroundView.alpha = 0.0f;
        _slideView.frame = CGRectChangingOriginY(_slideView.frame, self.bounds.size.height);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

-(void) twitterButtonSelected
{
    NSString *text = [self.twitterDef safeObjectForKey:@"text"];
    UIImage *image = [self.twitterDef safeObjectForKey:@"image"];
    NSURL *url = [self.twitterDef safeObjectForKey:@"url"];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 60000
    SLComposeViewController *viewController = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
#else                               
    TWTweetComposeViewController *viewController = [[TWTweetComposeViewController alloc] init];
#endif    
    
    if (text) [viewController setInitialText:text];
    if (image) [viewController addImage:image];
    if (url) [viewController addURL:url];
        
    [_presentingViewController presentViewController:viewController animated:YES completion:nil];
    
    [self dismissView];
}

-(void) facebookButtonSelected
{
    SLComposeViewController *viewController = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
    
    NSString *text = [self.facebookDef safeObjectForKey:@"text"];
    UIImage *image = [self.facebookDef safeObjectForKey:@"image"];
    NSURL *url = [self.facebookDef safeObjectForKey:@"url"];
    
    if (text)
    {
        [viewController setInitialText:text];
    }
    if (image)
    {
        [viewController addImage:image];
    }
    if (url)
    {
        [viewController addURL:url];
    }
    
    [_presentingViewController presentViewController:viewController animated:YES completion:nil];
    
    [self dismissView];
}

@end
