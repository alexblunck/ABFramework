//
//  ABSwitchExample.m
//  ABFramework-Examples
//
//  Created by Alexander Blunck on 1/31/13.
//  Copyright (c) 2013 Ablfx. All rights reserved.
//

#import "ABSwitchExample.h"

@interface ABSwitchExample () <ABSwitchDelegate>

@end

@implementation ABSwitchExample

#pragma mark - LifeCycle
- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.view.backgroundColor = [UIColor colorWithRed:0.151 green:0.150 blue:0.154 alpha:1.000];
    
    //Initialize ABSwitch
    ABSwitch *customSwitch = [[ABSwitch alloc] initWithBackgroundImage:[UIImage imageNamed:@"switch2_background.png"]
                                                           switchImage:[UIImage imageNamed:@"switch2_switch.png"]
                                                           shadowImage:[UIImage imageNamed:@"switch2_shadow.png"]];
    
    //Position in current view
    customSwitch.frame = CGRectCenteredInCGRect(customSwitch.frame, CGRectOffsetSizeHeight(self.view.bounds, -44));
    
    //Use delegate pattern
    customSwitch.delegate = self;
    
    //Override custom configuration
    customSwitch.cornerRadius = 3.0f;
    customSwitch.backgroundColor = [UIColor colorWithWhite:0.840 alpha:1.000];
    
    [self.view addSubview:customSwitch];
    
}



#pragma mark - ABSwitchDelegate
-(void) abSwitchDidChangeIndex:(ABSwitch *)sender
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    if (sender.currentIndex == 0)
    {
        sender.backgroundColor = [UIColor colorWithWhite:0.840 alpha:1.000];
    }
    else
    {
        sender.backgroundColor = [UIColor colorWithRed:0.659 green:0.908 blue:0.174 alpha:1.000];
    }
}

@end
