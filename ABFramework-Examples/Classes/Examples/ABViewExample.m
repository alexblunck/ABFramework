//
//  ABViewExample.m
//  ABFramework-Examples
//
//  Created by Alexander Blunck on 4/21/13.
//  Copyright (c) 2013 Ablfx. All rights reserved.
//

#import "ABViewExample.h"

@interface ABViewExample ()

@end

@implementation ABViewExample

#pragma mark - LifeCycle
- (void)viewDidLoad
{
    [super viewDidLoad];
	
    //View selection with state propegated recursively to whole view hierarchy 
    ABView *topView = [ABView new];
    topView.selectRecursively = YES;
    topView.frame = cgr(0, 0, 100, 100);
    topView.frame = CGRectCenteredHorizontally(topView.frame, self.view.bounds, 20);
    topView.backgroundColor = [UIColor redColor];
    topView.selectedBackgroundColor = [UIColor blackColor];
    [self.view addSubview:topView];
    
    ABView *middleView = [ABView new];
    middleView.frame = cgr(0, 0, 50, 50);
    middleView.frame = CGRectCenteredWithCGRect(middleView.frame, topView.bounds);
    middleView.backgroundColor = [UIColor greenColor];
    middleView.selectedBackgroundColor = [UIColor grayColor];
    [topView addSubview:middleView];

    ABView *bottomView = [ABView new];
    bottomView.frame = cgr(0, 0, 25, 25);
    bottomView.frame = CGRectCenteredWithCGRect(bottomView.frame, middleView.bounds);
    bottomView.backgroundColor = [UIColor purpleColor];
    bottomView.selectedBackgroundColor = [UIColor yellowColor];
    [middleView addSubview:bottomView];
    
    
    
    //ABView with ABLabel as a subview (selection state recursively propegated)
    ABView *view = [ABView new];
    view.selectRecursively = YES;
    view.frame = cgr(0, 0, 200, 100);
    view.frame = CGRectCenteredWithCGRect(view.frame, self.view.bounds);
    view.backgroundColor = [UIColor blueColor];
    view.selectedBackgroundColor = [UIColor orangeColor];
    [self.view addSubview:view];
    
    ABLabel *label = [ABLabel new];
    label.trimAutomatically = YES;
    label.text = @"Hello";
    label.textColor = [UIColor orangeColor];
    label.selectedTextColor = [UIColor blueColor];
    label.frame = CGRectCenteredWithCGRect(label.frame, view.bounds);
    [view addSubview:label];
    
    //Set view selected by setting property
    //view.selected = YES;
    
}

@end
