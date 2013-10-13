//
//  ABFullWidthTextField.m
//  ABFramework
//
//  Created by Alexander Blunck on 10/11/13.
//  Copyright (c) 2013 Ablfx. All rights reserved.
//

#import "ABFullWidthTextField.h"

@interface ABFullWidthTextField () <UITextFieldDelegate>
{
    BOOL _hasAlreadyReturned;
    ABLabel *_fieldNameLabel;
    UITextField *_textField;
}
@end

@implementation ABFullWidthTextField

@synthesize text = _text;

#pragma mark - Initializer
-(id) init
{
    self = [super initWithFrame:cgr(0, 0, [UIScreen screenWidth], 40.0f)];
    if (self)
    {
        
    }
    return self;
}



#pragma mark - LifeCycle
-(void) willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    
    //Field name
    if (self.fieldName)
    {
        _fieldNameLabel = [ABLabel new];
        _fieldNameLabel.frame = cgr(0, 0, 80.0f, self.height);
        _fieldNameLabel.uiTextField.textAlignment = NSTextAlignmentRight;
        _fieldNameLabel.text = self.fieldName;
        _fieldNameLabel.font = [UIFont HelveticaNeue:14.0f];
        _fieldNameLabel.textColor = [UIColor colorWithWhite:0.4f alpha:1.0f];
        [self addSubview:_fieldNameLabel];
    }
    
    //TextField
    _textField = [UITextField new];
    _textField.frame = cgr(0, 0, (_fieldNameLabel) ? self.width - _fieldNameLabel.width - 40.0f : self.width -40.0f, self.height);
    _textField.placeholder = self.placeholder;
    _textField.delegate = self;
    _textField.text = self.text;
    _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _textField.returnKeyType = UIReturnKeyDone;
    _textField.secureTextEntry = self.secureTextEntry;
    _textField.autocorrectionType = self.autocorrectionType;
    _textField.keyboardType = self.keyboardType;
    _textField.returnKeyType = self.returnKeyType;
    [self addSubview:_textField];
    
    if (_fieldNameLabel)
    {
        _textField.frame = CGRectOutsideRightCenter(_textField.frame, _fieldNameLabel.frame, 10.0f);
    }
    else
    {
        _textField.frame = CGRectCenteredWithCGRect(_textField.frame, self.bounds);
        _textField.textAlignment = NSTextAlignmentCenter;
    }
    
    //Right view
    if (self.rightView)
    {
        self.rightView.frame = CGRectInsideRightCenter(self.rightView.frame, self.bounds, 15.0f);
        [self addSubview:self.rightView];
        
        _textField.frame = CGRectOffsetSizeWidth(_textField.frame, -self.rightView.width);
    }
    
    //Seperators
    ABSeperator *topSep = [ABSeperator onePointSeperatorWithColor:[UIColor colorWithWhite:0.8f alpha:1.0f]];
    topSep.frame = CGRectInsideTopCenter(topSep.frame, self.bounds, 0);
    [self addSubview:topSep];
    
    ABSeperator *bottomSep = [ABSeperator onePointSeperatorWithColor:[UIColor colorWithWhite:0.8f alpha:1.0f]];
    bottomSep.frame = CGRectInsideBottomCenter(bottomSep.frame, self.bounds, 0);
    [self addSubview:bottomSep];
}



#pragma mark - UITextFieldDelegate
-(BOOL) textFieldShouldBeginEditing:(UITextField *)textField
{
    if (self.enableSelection && [self.delegate respondsToSelector:@selector(abTextFieldDidSelectField:)])
    {
        [self.delegate abTextFieldDidSelectField:self];
        return NO;
    }
    return YES;
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [_textField resignFirstResponder];
    
    if ([self.delegate respondsToSelector:@selector(abTextFieldDidReturn:)])
    {
        [self.delegate abTextFieldDidReturn:self];
    }
    
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

-(BOOL) textFieldShouldClear:(UITextField *)textField
{
    //Inform delegate
    if ([self.delegate respondsToSelector:@selector(abTextFieldDidChangeText:string:)])
    {
        [self.delegate abTextFieldDidChangeText:self string:@""];
    }
    
    return YES;
}



#pragma mark - TextField Interface
-(BOOL) resignFirstResponder
{
    return [_textField resignFirstResponder];
}

-(BOOL) becomeFirstResponder
{
    return [_textField becomeFirstResponder];
}



#pragma mark - Accessors
-(UITextField*) uiTextField
{
    return _textField;
}

-(void) setFieldName:(NSString *)fieldName
{
    _fieldName = fieldName;
    
    _fieldNameLabel.text = _fieldName;
}

#pragma mark - Accessors - UITextField Interface
-(NSString*) text
{
    return _textField.text;
}

-(void) setText:(NSString *)text
{
    _text = text;
    
    _textField.text = text;
}

-(void) setPlaceholder:(NSString *)placeholder
{
    _placeholder = placeholder;
    
    _textField.placeholder = _placeholder;
}

-(void) setSecureTextEntry:(BOOL)secureTextEntry
{
    _secureTextEntry = secureTextEntry;
    
    _textField.secureTextEntry = _secureTextEntry;
}

-(void) setAutocorrectionType:(UITextAutocorrectionType)autocorrectionType
{
    _autocorrectionType = autocorrectionType;
    
    _textField.autocorrectionType = _autocorrectionType;
}

-(void) setKeyboardType:(UIKeyboardType)keyboardType
{
    _keyboardType = keyboardType;
    
    _textField.keyboardType = _keyboardType;
}

-(void) setReturnKeyType:(UIReturnKeyType)returnKeyType
{
    _returnKeyType = returnKeyType;
    
    _textField.returnKeyType = _returnKeyType;
}

@end
