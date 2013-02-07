//
//  AppDelegate.m
//  ABFramework-Examples-Mac
//
//  Created by Alexander Blunck on 2/7/13.
//  Copyright (c) 2013 Ablfx. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    
    [ABSaveSystem saveString:@"hello world" key:@"myKey"];
    
    ABLogNSString([ABSaveSystem stringForKey:@"myKey"]);
    
}

@end
