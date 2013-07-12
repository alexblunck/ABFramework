//
//  ABLabel.m
//  ABFramework
//
//  Created by Alexander Blunck on 2/6/13.
//  Copyright (c) 2013 Ablfx. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "ABLabel.h"

@interface ABLabel ()
{
    UITextField *_textField;
    UILabel *_label;
    
    UIColor *_originalTextColor;
    NSString *_originalFontName;
}
@end

@implementation ABLabel

#pragma mark - Initializer
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.userInteractionEnabled = NO;
        
        //TextField
        _textField = [[UITextField alloc] initWithFrame:self.bounds];
        _textField.backgroundColor = [UIColor clearColor];
        _textField.userInteractionEnabled = NO;
        _textField.clipsToBounds = NO;
        [self addSubview:_textField];
        
        //Label (not used by default)
        _label = [[UILabel alloc] initWithFrame:self.bounds];
        _label.backgroundColor = [UIColor clearColor];
        _label.numberOfLines = 0;
        _label.alpha = 0.0f;
        [self addSubview:_label];
        
        //Configuration
        self.trimAutomatically = NO;
        if (!IS_MIN_IOS7) self.fontName = @"HelveticaNeue";
        self.textSize = 15.0f;
        self.textColor = [UIColor blackColor];
        self.lineBreakEnabled = NO;
        self.shadow = ABShadowTypeNone;
        self.shadowColor = nil;
        self.centeredHorizontally = NO;
        self.centeredVertically = YES;
    }
    return self;
}

-(id) init
{
    return [self initWithFrame:CGRectZero];
}



#pragma mark - Info
-(CGFloat) heightToFitAllText
{
    UILabel *l = [_label abCopy];
    l.text = self.text;
    [l sizeToFit];
    
    CGFloat height = l.bounds.size.height;
    
    l = nil;
    
    return height;
}



#pragma mark - Change
-(void) trim
{
    //Label
    if (_lineBreakEnabled) {
        [_label sizeToFit];
        self.frame = CGRectChangingCGSize(self.frame, _label.bounds.size);
    }
    //TextField
    else
    {
        [_textField sizeToFit];
        self.frame = CGRectChangingCGSize(self.frame, _textField.bounds.size);
    }
}



#pragma mark - Direct Access
-(UITextField*) uiTextField
{
    return _textField;
}

-(UILabel*) uiLabel
{
    return _label;
}



#pragma mark - ABViewSelectionProtocol
-(void) defaultStyle
{
    _originalTextColor = self.textColor;
    _originalFontName = self.fontName;
}

-(void) setSelectedStyle:(BOOL)selected
{
    //Text color
    self.textColor = (selected && self.selectedTextColor) ? self.selectedTextColor : _originalTextColor;
    
    //Font
    self.fontName = (selected && self.selectedFontName) ? self.selectedFontName : _originalFontName;
}



#pragma mark - Accessors
//name
-(void) setText:(NSString *)text
{
    _text = text;
    
    _textField.text = _text;
    _label.text = _text;
    
    //If own frame size is not set automatically trim label (or always if trimAutomatically is enabled)
    if (self.trimAutomatically || self.bounds.size.width == 0.0f || self.bounds.size.height == 0.0f)
    {
        [self trim];
    }
}

//font
-(void) setFont:(UIFont *)font
{
    _font = font;
    _fontName = [font fontName];
    _textSize = [font pointSize];
    
    _textField.font = font;
    _label.font = font;
    
    if (self.trimAutomatically) [self trim];
}

//fontName
-(void) setFontName:(NSString *)fontName
{
    _fontName = fontName;
    
    self.font = [UIFont fontWithName:_fontName size:self.textSize];
}


//textSize
-(void) setTextSize:(CGFloat)textSize
{
    _textSize = textSize;
    
    self.font = [UIFont fontWithName:self.fontName size:_textSize];
}

//textColor
-(void) setTextColor:(UIColor *)textColor
{    
    _textColor = textColor;
    _textField.textColor = _textColor;
    _label.textColor = _textColor;
}

-(void) setLineBreakEnabled:(BOOL)lineBreakEnabled
{
    _lineBreakEnabled = lineBreakEnabled;
    
    //Turn of automatic trimming if enabled
    self.trimAutomatically = (_lineBreakEnabled) ? NO : self.trimAutomatically;
    
    //Assume left text alignment if enabled
    self.centeredHorizontally = (_lineBreakEnabled) ? NO : self.centeredHorizontally;
    
    //Hide TextField & Show Label if enabled
    _textField.alpha = (_lineBreakEnabled) ? 0.0f : 1.0f;
    _label.alpha = (_lineBreakEnabled) ? 1.0f :0.0f;
    
}

//shadow
-(void) setShadow:(ABShadowType)shadow
{
    _shadow = shadow;
    
    UIColor *shadowColor = nil;
    CGSize shadowOffset = {0.0f, 0.0f};
    CGFloat shadowRadius = 0.0f;
    CGFloat shadowOpactiy = 0.0f;
    
    if (_shadow == ABShadowTypeNone)
    {
        shadowOpactiy = 0.0f;
    }
    else if (shadow == ABShadowTypeHard)
    {
        shadowColor = [UIColor blackColor];
        shadowOffset = CGSizeMake(0.0f, 1.0f);
        shadowRadius = 0.0f;
        shadowOpactiy = 1.0f;
        
    }
    else if (_shadow == ABShadowTypeLetterpress)
    {
        shadowColor = [UIColor whiteColor];
        shadowOffset = CGSizeMake(1.0f, 1.0f);
        shadowRadius = 0.0f;
        shadowOpactiy = 1.0f;
    }
    else if (_shadow == ABShadowTypeSoft)
    {
        shadowColor = [UIColor blackColor];
        shadowOffset = CGSizeMake(0.0f, 0.0f);
        shadowRadius = 5.0f;
        shadowOpactiy = 1.0f;
    }
    
    _textField.layer.shadowColor = [shadowColor CGColor];
    _textField.layer.shadowOffset = shadowOffset;
    _textField.layer.shadowRadius = shadowRadius;
    _textField.layer.shadowOpacity = shadowOpactiy;
    _textField.layer.shouldRasterize = YES;
    _textField.layer.rasterizationScale = [[UIScreen mainScreen] scale];
    
    _label.shadowColor = shadowColor;
    _label.shadowOffset = shadowOffset;
    
    if (self.trimAutomatically) [self trim];
}

//shadowColor
-(void) setShadowColor:(UIColor *)shadowColor
{
    _shadowColor = shadowColor;
    _textField.layer.shadowColor = [_shadowColor CGColor];
    _label.shadowColor = _shadowColor;
}

//centeredHorizontally
-(void) setCenteredHorizontally:(BOOL)centeredHorizontally
{
    _centeredHorizontally = centeredHorizontally;
    
    NSTextAlignment alignment = (_centeredHorizontally) ? NSTextAlignmentCenter : NSTextAlignmentLeft;
    
    _textField.textAlignment = alignment;
    _label.textAlignment = alignment;
    
    if (self.trimAutomatically) [self trim];
}

//centeredVertically
-(void) setCenteredVertically:(BOOL)centeredVertically
{
    _centeredVertically = centeredVertically;
    _textField.contentVerticalAlignment = (_centeredVertically) ? UIControlContentVerticalAlignmentCenter : UIControlContentVerticalAlignmentTop;
    
    if (self.trimAutomatically) [self trim];
}

//minimumFontSize
-(void) setMinimumFontSize:(CGFloat)minimumFontSize
{
    _minimumFontSize = minimumFontSize;
    
    CGFloat minimumScaleFactor = (1.0f / self.textSize) * _minimumFontSize;
    
    _label.adjustsFontSizeToFitWidth = YES;
    if (IS_MIN_IOS6)
    {
#ifdef DEF_IS_MAX_IOS6
        _label.adjustsLetterSpacingToFitWidth = YES;
#endif
        _label.minimumScaleFactor = minimumScaleFactor;
    }
    else
    {
#ifdef DEF_IS_MAX_IOS5
        _label.minimumFontSize = minimumFontSize;
#endif
    }
    
    //Doesn't seem to work on UITextField
    _textField.adjustsFontSizeToFitWidth = YES;
    _textField.minimumFontSize = _minimumFontSize;
}

//forceUILabel
-(void) setForceUILabel:(BOOL)forceUILabel
{
    _forceUILabel = forceUILabel;
    
    _label.alpha = (_forceUILabel) ? 1.0f : 0.0f;
    _textField.alpha = (_forceUILabel) ? 0.0f : 1.0f;
}

//forceUITextField
-(void) setForceUITextField:(BOOL)forceUITextField
{
    _forceUITextField = forceUITextField;
    [self setForceUILabel:NO];
}

//frame
-(void) setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    _textField.frame = CGRectChangingCGSize(_textField.frame, frame.size);
    _label.frame = CGRectChangingCGSize(_label.frame, frame.size);
}

@end
