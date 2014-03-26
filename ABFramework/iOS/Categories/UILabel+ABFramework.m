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
    label.font = self.font;
    label.textColor = self.textColor;
    label.textAlignment = self.textAlignment;
    label.lineBreakMode = self.lineBreakMode;
    label.enabled = self.enabled;
    label.adjustsFontSizeToFitWidth = self.adjustsFontSizeToFitWidth;
    label.baselineAdjustment = self.baselineAdjustment;
    label.numberOfLines = self.numberOfLines;
    label.highlightedTextColor = self.highlightedTextColor;
    label.highlighted = self.highlighted;
    label.shadowColor = self.shadowColor;
    label.shadowOffset = self.shadowOffset;
    label.userInteractionEnabled = self.userInteractionEnabled;
    
    if (IS_MIN_IOS6)
    {
        label.attributedText = self.attributedText;
#ifdef DEF_IS_MAX_IOS6
        label.adjustsLetterSpacingToFitWidth = self.adjustsLetterSpacingToFitWidth;
#endif
        label.minimumScaleFactor = self.minimumScaleFactor;
    }
    
    return label;
}



#pragma mark - Info
-(CGSize) sizeForText:(NSString*) text
{
    UILabel *l = [self abCopy];
    l.text = text;
    [l sizeToFit];
    
    return l.bounds.size;
}



#pragma mark - Size
-(void) adjustHeightToFitAttributedText
{
    [self adjustHeightToFitAttributedTextWithMaxHeight:FLT_MAX];
}

-(void) adjustHeightToFitAttributedTextWithMaxHeight:(CGFloat)maxHeight
{
    // All attributes need to define a NSFontAttributeName key, or else calculating bounds won't work
    NSMutableArray *array = [NSMutableArray new];
    
    // Find attributes that are missing the NSFontAttributeName key
    [self.attributedText enumerateAttributesInRange:NSMakeRange(0, self.attributedText.length) options:kNilOptions usingBlock:^(NSDictionary *attrs, NSRange range, BOOL *stop) {
        
        if ([attrs safeObjectForKey:NSFontAttributeName] == nil)
        {
            [array addObject:[NSValue valueWithRange:range]];
        }

    }];
    
    NSMutableAttributedString *mutableString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    
    // Append NSFontAttributeName to ranges missing it
    for (NSValue *value in array)
    {
        [mutableString addAttribute:NSFontAttributeName value:self.font range:[value rangeValue]];
    }
    
    self.attributedText = [[NSAttributedString alloc] initWithAttributedString:mutableString];
    
    // Calculate height
    CGSize maxSize = cgs(self.width, maxHeight);
    CGRect rect = [self.attributedText boundingRectWithSize:maxSize
                                                    options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                    context:nil];
    
    self.frame = CGRectChangingSizeHeight(self.frame, rect.size.height);
}

@end











