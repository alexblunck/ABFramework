//
//  ABLabel.h
//  ABFramework
//
//  Created by Alexander Blunck on 2/6/13.
//  Copyright (c) 2013 Ablfx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ABLabel : ABView <ABViewSelectionProtocol>

//Tell the ABLabel view to adjust its frame to fit only its text value
-(void) trim;

//Info
-(CGFloat) heightToFitAllText;

//Label text value
@property (nonatomic, copy) NSString *text;

//Font name, default HelveticaNeue
@property (nonatomic, copy) UIFont *font;
@property (nonatomic, copy) NSString *fontName;
@property (nonatomic, copy) NSString *selectedFontName;

//Label text size, default 15.0f
@property (nonatomic, assign) CGFloat textSize;

//Label text color, default Black
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UIColor *selectedTextColor;

//Adjust ABLabel view to perfectly fit its text view automatically if certain values are altered, default is YES
@property (nonatomic, assign) BOOL trimAutomatically;

//Enable line breaks, default is NO
@property (nonatomic, assign) BOOL lineBreakEnabled;

//Shadowtype, default ABLabelShadowNone
@property (nonatomic, assign) ABShadowType shadow;

//Shadow color, default are the selected ABLabelShadow values
@property (nonatomic, strong) UIColor *shadowColor;

//Label text centered horizontally in label frame, default YES
//If set to NO content will be  aligned to the left
@property (nonatomic, assign) BOOL centeredHorizontally;

//Label text centered vertically in label frame, default YES
//If set to NO content will be aligned to the top
@property (nonatomic, assign) BOOL centeredVertically;

//Adjust minimum scale factor thats allowed (works only on UILabel)
@property (nonatomic, assign) CGFloat minimumFontSize;

//Force UILabel or UITextField, no matter if lineBreak is enabled or not
@property (nonatomic, assign) BOOL forceUILabel;
@property (nonatomic, assign) BOOL forceUITextField;

//DIRECT ACCESS to underlying UITextField and UILabel
//UITextField: when lineBreakEnabled is NO
//UILabel: when lineBreakEnabled is YES
-(UITextField*) uiTextField;
-(UILabel*) uiLabel;

@end
