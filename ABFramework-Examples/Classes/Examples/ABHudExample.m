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
	
    self.view.backgroundColor = [UIColor whiteColor];
    
    ABButton *button1 = [ABButton buttonBasicWithText:@"Simple" actionBlock:^{
        
        //Customize ABHud behaviour
        //[ABHud setAnimationType:ABHudAnimationTypeBounce]; //Default: ABHudAnimationTypePop
        //[ABHud setCornerRadius:20.0f]; //Default: Circle
        
        [ABHud showActivity];
        
        [self performSelector:@selector(hide) withObject:nil afterDelay:2.0f];
        
    }];
    button1.frame = CGRectCenteredHorizontally(button1.frame, self.view.bounds, 150.0f);
    [self.view addSubview:button1];

}

-(void) hide
{
    //[ABHud dismissWithIconName:@"airplane" message:@"Fly Awaaaaay"];
    //[ABHud dismissWithError:@"Failed"];
    [ABHud dismissWithSuccess:@"Weeee!"];
    //[ABHud dismiss];
}

@end
