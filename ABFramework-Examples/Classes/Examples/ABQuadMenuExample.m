//
//  ABQuadMenuExample.m
//  ABFramework-Examples
//
//  Created by Alexander Blunck on 5/14/13.
//  Copyright (c) 2013 Ablfx. All rights reserved.
//

#import "ABQuadMenuExample.h"

@interface ABQuadMenuExample ()

@end

@implementation ABQuadMenuExample

#pragma mark - LifeCycle
- (void)viewDidLoad
{
    [super viewDidLoad];
	
    ABButton *button = [ABButton buttonBasicWithText:@"show" actionBlock:^{
        //
        [self showMenu];
    }];
    button.frame = CGRectCenteredWithCGRect(button.frame, self.view.bounds);
    [self.view addSubview:button];
    
    
}

-(void) showMenu
{
    //1. Create menu items
    ABQuadMenuItem *item1 = [ABQuadMenuItem itemWithIconName:@"open-book" title:@"Read" action:^{
        NSLog(@"Item 1 Selected");
    }];
    
    ABQuadMenuItem *item2 = [ABQuadMenuItem itemWithIconName:@"globe" title:@"Map" action:^{
        NSLog(@"Item 2 Selected");
    }];
    
    ABQuadMenuItem *item3 = [ABQuadMenuItem itemWithIconName:@"cog" title:@"Options" action:^{
        NSLog(@"Item 3 Selected");
    }];
    
    //2. Show menu
    [ABQuadMenu showMenuWithItems:@[item1, item2, item3]];
}

@end
