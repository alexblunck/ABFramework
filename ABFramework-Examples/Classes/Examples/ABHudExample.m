//
//  ABHudExample.m
//  ABFramework-Examples
//
//  Created by Alexander Blunck on 3/11/13.
//  Copyright (c) 2013 Ablfx. All rights reserved.
//

#import "ABHudExample.h"

@interface ABHudExample ()

@end

@implementation ABHudExample

#pragma mark - LifeCycle
- (void)viewDidLoad
{
    [super viewDidLoad];
	
    ABButton *button1 = [ABButton buttonBasicWithText:@"Simple" actionBlock:^{
        
        //Customize ABHud behaviour
        //[ABHud setAnimationType:ABHudAnimationTypeBounce];
        //[ABHud setCornerRadius:10.0f];
        
        [ABHud showActivityAndHide];
        
    }];
    button1.frame = CGRectCenteredHorizontally(button1.frame, self.view.bounds, 50);
    [self.view addSubview:button1];

}

@end
