//
//  UIColor+ABFramework.h
//  ABFramework
//
//  Created by Alexander Blunck on 3/4/13.
//  Copyright (c) 2013 Ablfx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (ABFramework)

//Creation
/**
 * Expects a hex string: #e2e2e2
 */
+(UIColor*) colorWithHexString:(NSString*)hexString;

//Manipulation
-(UIColor*) colorInverted;
-(UIColor*) darkenColor:(CGFloat)value;
-(UIColor*) lightenColor:(CGFloat)value;

@end
