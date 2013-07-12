//
//  ABButton.h
//  ABFramework
//
//  Created by Alexander Blunck on 2/4/13.
//  Copyright (c) 2013 Ablfx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ABButton : UIButton

//Utility
//Selector
+(id) buttonWithImageName:(NSString*)imageName target:(id)target selector:(SEL)selector;
+(id) buttonWithTarget:(id)target selector:(SEL)selector;
+(id) buttonWithEntypoIconName:(NSString*)iconName size:(CGFloat)size target:(id)target action:(SEL)selector;
//Block
+(id) buttonWithImageName:(NSString*)imageName actionBlock:(ABBlockVoid)actionBlock;
+(id) buttonWithActionBlock:(ABBlockVoid)actionBlock;
+(id) buttonBasicWithText:(NSString*)text actionBlock:(ABBlockVoid)actionBlock; //ABButton with default UIButton styling
+(id) buttonWithEntypoIconName:(NSString*)iconName size:(CGFloat)size actionBlock:(ABBlockVoid)actionBlock;

//Conversion
-(UIBarButtonItem*) barButtonItem;

@property (nonatomic, copy) NSDictionary *userData;

//Button image
@property (nonatomic, copy) NSString *imageName;

//Use custom selected image
@property (nonatomic, copy) NSString *selectedImageName;

//Set if all button subvviews are dimmed with button
@property (nonatomic, assign) BOOL dimSubViews;

@end
