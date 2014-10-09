//
//  ABRevealControllerExample.m
//  ABFramework-Examples
//
//  Created by Alexander Blunck on 6/17/13.
//  Copyright (c) 2013 Ablfx. All rights reserved.
//

#import "ABRevealControllerExample.h"

@interface ABRevealControllerExample ()
{
    ABRevealController *_revealController;
}
@end

@implementation ABRevealControllerExample

#pragma mark - LifeCycle
- (void)viewDidLoad
{
    [super viewDidLoad];
	
    //Example Setup
    self.navigationController.navigationBarHidden = YES;
    
    
    
    /**
     * Front View
     */
    UIViewController *frontViewController = [UIViewController new];
    frontViewController.view.backgroundColor = [UIColor whiteColor];
    UINavigationController *frontNavController = [[UINavigationController alloc] initWithRootViewController:frontViewController];
    frontViewController.title = @"Front View";
    
    //Buttons
    frontViewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Menu" style:0 target:self action:@selector(menuButtonSelected)];
    frontViewController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Close" style:0 target:self action:@selector(popView)];

    
    
    /**
     * Background View
     */
    UIViewController *backgroundViewController = [UIViewController new];
    backgroundViewController.view.backgroundColor = [UIColor grayColor];
    
    ABLabel *label = [ABLabel new];
    label.trimAutomatically = YES;
    label.text = @"This is some text";
    label.frame = CGRectCenteredVertically(label.frame, backgroundViewController.view.bounds, 5.0f);
    [backgroundViewController.view addSubview:label];
    
    
    
    /**
     * Reveal Controller
     */
    _revealController = [[ABRevealController alloc] initWithFrontViewController:frontNavController
                                                       backgroundViewController:backgroundViewController];
    
    //Config
    _revealController.shadowEnabled = YES;
    //_revealController.revealWidth = 200.0f;
    //_revealController.allowOverSliding = NO;
    //_revealController.parallaxRevealEnabled = NO;
    //_revealController.allowOverParallax = YES;
    
    [self addChildViewController:_revealController];
    [self.view addSubview:_revealController.view];
}



#pragma mark - Buttons
-(void) menuButtonSelected
{
    [_revealController toggleReveal];
}

-(void) popView
{
    self.navigationController.navigationBarHidden = NO;
    [self.navigationController popViewControllerAnimated:YES];
}

@end
