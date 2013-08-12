//
//  UILabel+ABFramework.h
//  ABFramework
//
//  Created by Alexander Blunck on 2/4/13.
//  Copyright (c) 2013 Ablfx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (ABFramework)

//Returns exact copy of UILabel
-(UILabel*) abCopy;

//Info
-(CGSize) sizeForText:(NSString*)text;

//Size
-(void) adjustHeightToFitAttributedText;
-(void) adjustHeightToFitAttributedTextWithMaxHeight:(CGFloat)maxHeight;

@end
