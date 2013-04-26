//
//  ABTextField.m
//  ABFramework
//
//  Created by Alexander Blunck on 1/30/13.
//  Copyright (c) 2013 Ablfx. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "ABTextField.h"

@interface ABTextField () <UITextFieldDelegate> {
    UITextField *_textField;
    BOOL _hasAlreadyReturned;
}
@end

@implementation ABTextField

@synthesize text = _text;

#pragma mark - Initializer
-(id) initWithImage:(NSString*)imageName
{
    self = [super init];
    if (self)
    {
        //Default Config
        self.hideKeyboardOnReturn = YES;
        
        //Background Image
        UIImage *backgroundImage = [UIImage imageNamed:imageName];
        UIImageView *backgroundImageView = [UIImageView new];
        backgroundImageView.frame = CGRectMake(0, 0, backgroundImage.size.width, backgroundImage.size.height);
        backgroundImageView.image = backgroundImage;
        [self addSubview:backgroundImageView];
        
        //Assume frame of image
        self.frame = CGRectChangingCGSize(CGRectZero, backgroundImage.size);
        
        //Text Field
        _textField = [UITextField new];
        _textField.frame = CGRectOffsetSizeWidth(backgroundImageView.frame, -20);
        _textField.center = backgroundImageView.center;
        _textField.delegate = self;
        _textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _textField.textAlignment = NSTextAlignmentCenter;
        _textField.returnKeyType = UIReturnKeyDone;
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _textField.font = [UIFont fontWithName:ABFRAMEWORK_FONT_DEFAULT_REGULAR size:16.0f];
        _textField.textColor = [UIColor colorWithWhite:0.283 alpha:1.000];
        _textField.layer.shadowColor = [[UIColor whiteColor] CGColor];
        _textField.layer.shadowOffset = CGSizeMake(0.8f, 0.8f);
        _textField.layer.shadowRadius = 0.0f;
        _textField.layer.shadowOpacity = 0.6f;
        _textField.layer.shouldRasterize = YES;
        _textField.layer.rasterizationScale = [[UIScreen mainScreen] scale];
        [self addSubview:_textField];
    }
    return self;
}


#pragma mark - Helper
-(void) hideKeyboard
{
    //Update state
    _hasAlreadyReturned = YES;
    
    //Inform Delegate
    if ([self.delegate respondsToSelector:@selector(abTextFieldDidReturn:)]) {
        [self.delegate abTextFieldDidReturn:self];
    }
    
    //Hide Keyboard
    if (self.hideKeyboardOnReturn)
    {
        [_textField resignFirstResponder];
    }
}



#pragma mark - UITextFieldDelegate
-(BOOL) textFieldShouldReturn:(UITextField *)textField
{    
    [self hideKeyboard];
    
    return YES;
}

-(void) textFieldDidBeginEditing:(UITextField *)textField
{
    //Update state
    _hasAlreadyReturned = NO;
    
    //Inform Delegate
    if ([self.delegate respondsToSelector:@selector(abTextFieldDidBeginEditing:)])
    {
        [self.delegate abTextFieldDidBeginEditing:self];
    }
}

-(void) textFieldDidEndEditing:(UITextField *)textField
{
    //Inform Delegate, that value of textField did change
    if ([self.delegate respondsToSelector:@selector(abTextFieldDidChangeText:string:)])
    {
        [self.delegate abTextFieldDidChangeText:self string:self.text];
    }
    
    //Inform Delegate, that textField did end editing (!!ONLY if return button hasn't already been selected)
    if ([self.delegate respondsToSelector:@selector(abTextFieldDidEndEditing:)] && !_hasAlreadyReturned)
    {
        [self.delegate abTextFieldDidEndEditing:self];
    }
}

-(BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    //Compute current visibile text field string
    NSMutableString *completeString = [[NSMutableString alloc] initWithString:textField.text];
    [completeString replaceCharactersInRange:range withString:string];
    
    //Inform delegate
    if ([self.delegate respondsToSelector:@selector(abTextFieldDidChangeText:string:)])
    {
        [self.delegate abTextFieldDidChangeText:self string:completeString];
    }
    
    return YES;
}

#pragma mark - Superclass
-(BOOL) becomeFirstResponder
{
    return [_textField becomeFirstResponder];
}



#pragma mark - Accessors
-(void) setPlaceholder:(NSString *)placeholder
{
    _placeholder = placeholder;
    _textField.placeholder = _placeholder;
}

-(void) setText:(NSString *)text
{
    _text = text;
    _textField.text = _text;
}
-(NSString*) text
{
    return _textField.text;
}

-(BOOL) editing
{
    return _textField.editing;
}

-(UITextField*) textField
{
    return _textField;
}

@end
