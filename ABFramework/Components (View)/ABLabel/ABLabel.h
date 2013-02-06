//
//  ABLabel.h
//  ABFramework
//
//  Created by Alexander Blunck on 2/6/13.
//  Copyright (c) 2013 Ablfx. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    ABLabelShadowNone,
    ABLabelShadowHard,
    ABLabelShadowSoft,
    ABLabelShadowLetterpress
} ABLabelShadow;

@interface ABLabel : UIView

//Tell the ABLabel view to adjust its frame to fit only its text value
-(void) trim;

//Label text value
@property (nonatomic, copy) NSString *text;

//Font name, default HelveticaNeue
@property (nonatomic, copy) NSString *fontName;

//Label text size, default 15.0f
@property (nonatomic, assign) CGFloat textSize;

//Label text color, default Black
@property (nonatomic, strong) UIColor *textColor;

//Adjust ABLabel view to perfectly fit its text view automatically if certain values are altered, default is YES
@property (nonatomic, assign) BOOL trimAutomatically;

//Enable line breaks, default is NO
@property (nonatomic, assign) BOOL lineBreakEnabled;

//Shadowtype, default ABLabelShadowNone
@property (nonatomic, assign) ABLabelShadow shadow;

//Shadow color, default are the selected ABLabelShadow values
@property (nonatomic, strong) UIColor *shadowColor;

//Label text centered horizontally in label frame, default YES
//If set to NO content will be  aligned to the left
@property (nonatomic, assign) BOOL centeredHorizontally;

//Label text centered vertically in label frame, default YES
//If set to NO content will be aligned to the top
@property (nonatomic, assign) BOOL centeredVertically;

@end
