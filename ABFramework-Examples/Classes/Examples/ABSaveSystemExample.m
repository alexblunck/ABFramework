//
//  ABSaveSystemExample.m
//  ABFramework-Examples
//
//  Created by Alexander Blunck on 2/7/13.
//  Copyright (c) 2013 Ablfx. All rights reserved.
//

#import "ABSaveSystemExample.h"

@interface ABSaveSystemExample ()

@end

@implementation ABSaveSystemExample

#pragma mark - LifeCycle
- (void)viewDidLoad
{
    [super viewDidLoad];
	
    //Save
    [ABSaveSystem saveFloat:45.6f key:@"myKey"];
    
    //Load
    ABLogFloat([ABSaveSystem floatForKey:@"myKey"]);
    
    //Log all saved values to console
    //[ABSaveSystem logSavedValues];
}

@end
