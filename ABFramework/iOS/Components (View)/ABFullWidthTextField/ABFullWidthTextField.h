//
//  ABFullWidthTextField.h
//  ABFramework
//
//  Created by Alexander Blunck on 10/11/13.
//  Copyright (c) 2013 Ablfx. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ABFullWidthTextField;

@protocol ABFullWidthTextFieldDelegate <NSObject>
@optional
-(void) abTextFieldDidBeginEditing:(ABFullWidthTextField*)textField;
-(void) abTextFieldDidEndEditing:(ABFullWidthTextField*)textField;
-(void) abTextFieldDidReturn:(ABFullWidthTextField*)textField;
-(void) abTextFieldDidChangeText:(ABFullWidthTextField*)textField string:(NSString *)string;
-(void) abTextFieldDidSelectField:(ABFullWidthTextField*)textField;
@end

@interface ABFullWidthTextField : UIView

@property (nonatomic, copy) NSString *fieldName;
@property (nonatomic, strong) UIView *rightView;
@property (nonatomic, assign) BOOL enableSelection;

//TextField Interface
@property (nonatomic, readonly) UITextField *uiTextField;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *placeholder;
@property (nonatomic, assign) BOOL secureTextEntry;
@property (nonatomic, assign) UITextAutocorrectionType autocorrectionType;
@property (nonatomic, assign) UIKeyboardType keyboardType;

@property (nonatomic, weak) id <ABFullWidthTextFieldDelegate> delegate;
@property (nonatomic, assign) UIReturnKeyType returnKeyType;

@end
