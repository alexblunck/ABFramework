//
//  ABEntypoExample.m
//  ABFramework-Examples
//
//  Created by Alexander Blunck on 8/10/13.
//  Copyright (c) 2013 Ablfx. All rights reserved.
//

#import "ABEntypoExample.h"

@interface ABEntypoExample ()

@end

@implementation ABEntypoExample

#pragma mark - LifeCycle
- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.view.backgroundColor = [UIColor whiteColor];
    
    //[self renderAllIcons];
    
    //Button
    ABEntypoButton *button = [ABEntypoButton buttonWithIconName:@"rocket" size:30.0f];
    //ABEntypoButton *button = [ABEntypoButton buttonWithIconName:@"rocket" size:20.0f frame:cgr(0, 0, 50.0f, 50.0f)];
    button.frame = CGRectCenteredWithCGRect(button.frame, self.view.bounds);
    //button.backgroundColor = [UIColor grayColor];
    button.iconColorSelected = [UIColor redColor];
    [button addTouchUpInsideTarget:self action:@selector(buttonSelected)];
    [self.view addSubview:button];
    
    //UIBarButtonItem
    ABEntypoButton *navButton = [ABEntypoButton buttonWithIconName:@"bookmark" size:30.0f];
    navButton.frame = CGRectCenteredWithCGRect(button.frame, self.view.bounds);
    navButton.iconColorSelected = [UIColor redColor];
    [navButton addTouchUpInsideTarget:self action:@selector(buttonSelected)];
    self.navigationItem.rightBarButtonItem = [navButton barButtonItem];
}

-(void) renderAllIcons
{
    ABStackController *stack = [[ABStackController alloc] initWithWidth:self.view.width fixedHeight:self.view.height];
    [self.view addSubview:stack];
    
    [stack addPadding:10.0f];
    
    [[ABEntypoView unicodeDictionary] enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        
        ABEntypoView *view = [ABEntypoView viewWithIconName:key size:70.0f];
        view.color = [UIColor orangeColor];
        view.backgroundColor = [UIColor grayColor];
        [stack addView:view appendPadding:10.0f];
        
    }];
}

-(void) buttonSelected
{
    NSLog(@"Selected");
}

@end
