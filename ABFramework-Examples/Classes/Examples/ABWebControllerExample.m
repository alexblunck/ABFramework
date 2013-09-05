//
//  ABWebControllerExample.m
//  ABFramework-Examples
//
//  Created by Alexander Blunck on 8/10/13.
//  Copyright (c) 2013 Ablfx. All rights reserved.
//

#import "ABWebControllerExample.h"

@interface ABWebControllerExample ()

@end

@implementation ABWebControllerExample

#pragma mark - LifeCycle
- (void)viewDidLoad
{
    [super viewDidLoad];
	
    ABButton *button = [ABButton buttonWithText:@"Push WebViewController" actionBlock:^{
        
        ABWebViewController *webViewController = [[ABWebViewController alloc] initWithUrlString:@"http://ablfx.com"];
        webViewController.navBarTitle = @"Ablfx";
        [self.navigationController pushViewController:webViewController animated:YES];
        
    }];
    button.frame = CGRectCenteredWithCGRect(button.frame, self.view.bounds);
    [self.view addSubview:button];
    
    ABButton *button2 = [ABButton buttonWithText:@"Present WebController" actionBlock:^{
        
        ABWebController *webController = [ABWebController controllerWithUrlString:@"http://ablfx.com"];
        webController.navBarTitle = @"Ablfx";
        [self presentViewController:webController animated:YES completion:nil];
        
    }];
    button2.frame = CGRectOutsideBottomCenter(button2.frame, button.frame, 20.0f);
    [self.view addSubview:button2];
}

@end
