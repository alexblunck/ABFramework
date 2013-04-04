//
//  ABTextField.h
//  ABFramework
//
//  Created by Alexander Blunck on 1/30/13.
//  Copyright (c) 2013 Ablfx. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ABTextField;

@protocol ABTextFieldDelegate <NSObject>
@optional
-(void) abTextFieldDidBeginEditing:(ABTextField*)textField;
-(void) abTextFieldDidEndEditing:(ABTextField*)textField;
-(void) abTextFieldDidReturn:(ABTextField*)textField;
-(void) abTextFieldDidChangeText:(ABTextField*)textField string:(NSString*)string;
@end

@interface ABTextField : UIView

//Initializer
-(id) initWithImage:(NSString*)imageName;

//Helper
-(void) hideKeyboard;

@property (nonatomic, strong) id <ABTextFieldDelegate> delegate;

//Underlying UITextField for specific configuration
@property (nonatomic, strong) UITextField *textField;

@property (nonatomic, strong) NSString *placeholder;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, assign) BOOL editing;

//Keep keyboard from beeing hidden on return
@property (nonatomic, assign) BOOL hideKeyboardOnReturn;

@end
