//
//  NSString+ABFrameworkIOS.h
//  ABFramework
//
//  Created by Alexander Blunck on 7/28/13.
//  Copyright (c) 2013 Ablfx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (ABFrameworkIOS)

//Calculate Height for text in UILabel
-(CGFloat) heightToFitTextInLabel:(UILabel*)label;
-(CGFloat) heightToFitTextInLabel:(UILabel*)label maxHeight:(CGFloat)maxHeight;
-(CGFloat) heightToFitTextInLabelWithFont:(UIFont*)font fixedWidth:(CGFloat)fixedWidth maxHeight:(CGFloat)maxHeight;

@end
