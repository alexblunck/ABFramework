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
+(id) buttonWithImageName:(NSString*)imageName target:(id)target selected:(SEL)selector;
+(id) buttonWithtTarget:(id)target selected:(SEL)selector;
//Block
+(id) buttonWithImageName:(NSString*)imageName actionBlock:(ABBlockVoid)actionBlock;
+(id) buttonWithActionBlock:(ABBlockVoid)actionBlock;
+(id) buttonBasicWithText:(NSString*)text actionBlock:(ABBlockVoid)actionBlock; //ABButton with default UIButton styling

@property(nonatomic, strong) NSDictionary *userData;

//Use custom selected image
@property (nonatomic, copy) NSString *selectedImageName;

@end
