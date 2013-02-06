//
//  UILabel+ABFramework.m
//  ABFramework
//
//  Created by Alexander Blunck on 2/4/13.
//  Copyright (c) 2013 Ablfx. All rights reserved.
//

#import "UILabel+ABFramework.h"

@implementation UILabel (ABFramework)

//Returns exact copy of UILabel
-(UILabel*) abCopy
{
    UILabel *label = [UILabel new];
    label.frame = self.frame;
    label.text = self.text;
    label.attributedText = self.attributedText;
    label.font = self.font;
    label.textColor = self.textColor;
    label.textAlignment = self.textAlignment;
    label.lineBreakMode = self.lineBreakMode;
    label.enabled = self.enabled;
    label.adjustsFontSizeToFitWidth = self.adjustsFontSizeToFitWidth;
    label.adjustsLetterSpacingToFitWidth = self.adjustsLetterSpacingToFitWidth;
    label.baselineAdjustment = self.baselineAdjustment;
    label.minimumScaleFactor = self.minimumScaleFactor;
    label.numberOfLines = self.numberOfLines;
    label.highlightedTextColor = self.highlightedTextColor;
    label.highlighted = self.highlighted;
    label.shadowColor = self.shadowColor;
    label.shadowOffset = self.shadowOffset;
    label.userInteractionEnabled = self.userInteractionEnabled;
    
    return label;
}

@end
