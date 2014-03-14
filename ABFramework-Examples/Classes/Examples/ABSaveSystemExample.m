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
	
    // Save
    [ABSaveSystem saveFloat:45.6f key:@"myKey"];
    
    // Load
    ABLogFloat([ABSaveSystem floatForKey:@"myKey"]);
    
    
    // Save encrypted data
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:@"Encrypted String"];
    [ABSaveSystem saveData:data key:@"myKeyEnc" encrypted:YES];
    
    // Load encrypted data
    NSString *encryptedString = [NSKeyedUnarchiver unarchiveObjectWithData:[ABSaveSystem dataForKey:@"myKeyEnc" encrypted:YES]];
    ABLogNSString(encryptedString);
    
    
    // Log all saved values to console
    //[ABSaveSystem logSavedValues:YES];
    
    
    // Truncate
    ABButton *truncate = [ABButton buttonWithText:@"truncate" actionBlock:^{

        [ABSaveSystem truncate];
        
    }];
    truncate.frame = CGRectCenteredWithCGRect(truncate.frame, self.view.bounds);
    [self.view addSubview:truncate];
}

@end




