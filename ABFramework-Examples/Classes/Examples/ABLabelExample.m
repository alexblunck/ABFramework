//
//  ABLabelExample.m
//  ABFramework-Examples
//
//  Created by Alexander Blunck on 3/10/13.
//  Copyright (c) 2013 Ablfx. All rights reserved.
//

#import "ABLabelExample.h"

@interface ABLabelExample ()

@end

@implementation ABLabelExample

#pragma mark - LifeCycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    /*
     * Label with fixed frame
     */
    ABLabel *label1 = [[ABLabel alloc] initWithFrame:CGRectMake(20, 40, 120, 20)];
    label1.text = @"This is text in a fixed space";
    label1.backgroundColor = [UIColor grayColor];
    [self.view addSubview:label1];
    
    
    /*
     * Label with fixed frame but text size adjusts to a minimum font size to reveal all text
     * 
     * Note: for some reason this only works with UILabel ... so you need to force use of the 
     * underlying UILabel by seting the "forceUILabel" property
     */
    ABLabel *label2 = [[ABLabel alloc] initWithFrame:CGRectMake(20, label1.bottom+20, 120, 20)];
    label2.text = @"This is text in a fixed space";
    label2.backgroundColor = [UIColor grayColor];
    label2.forceUILabel = YES;
    label2.minimumFontSize = 9.0f;
    [self.view addSubview:label2];
    
    
    /*
     * Trim label automatically, or use [label trim] to do this manually
     */
    ABLabel *label3 = [ABLabel new];
    label3.frame = CGRectChangingOrigin(label3.frame, 20, label2.bottom+20);
    label3.trimAutomatically = YES;
    label3.text = @"This is a label trimmed automatically";
    label3.backgroundColor = [UIColor grayColor];
    [self.view addSubview:label3];
    
    
    /*
     * Multi line label
     */
    ABLabel *label4 = [ABLabel new];
    label4.frame = CGRectMake(20, label3.bottom+20, 100, 50);
    label4.lineBreakEnabled = YES;
    label4.text = @"This is a label with text on multiple lines";
    label4.backgroundColor = [UIColor grayColor];
    [self.view addSubview:label4];
    
    
    /*
     * Multi line label with minimum font size
     */
    ABLabel *label5 = [ABLabel new];
    label5.frame = CGRectMake(20, label4.bottom+20, 100, 50);
    label5.minimumFontSize = 10.0f;
    label5.lineBreakEnabled = YES;
    label5.text = @"This is a label with text on multiple lines";
    label5.backgroundColor = [UIColor grayColor];
    [self.view addSubview:label5];
    
    
    /*
     * Adjust a wide range of value
     */
    ABLabel *label6 = [ABLabel new];
    label6.frame = CGRectChangingOrigin(label6.frame, 20, label5.bottom+20);
    label6.trimAutomatically = YES;
    label6.text = @"This is a label";
    
    label6.fontName = @"AppleSDGothicNeo-Bold";
    label6.textSize = 20.0f;
    label6.textColor = [UIColor orangeColor];
    label6.shadow = ABShadowTypeSoft;
    label6.shadowColor = [UIColor purpleColor];
    
    [self.view addSubview:label6];
    
}

@end
