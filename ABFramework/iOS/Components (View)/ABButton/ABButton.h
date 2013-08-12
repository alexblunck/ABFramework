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
//Simple
+(id) buttonWithTarget:(id)target action:(SEL)selector;
+(id) buttonWithActionBlock:(ABBlockVoid)block;
//Image
+(id) buttonWithImageName:(NSString*)imageName target:(id)target action:(SEL)selector;
+(id) buttonWithImageName:(NSString*)imageName actionBlock:(ABBlockVoid)block;
//Text
+(id) buttonWithText:(NSString*)text target:(id)target action:(SEL)selector;
+(id) buttonWithText:(NSString*)text actionBlock:(ABBlockVoid)block;

@property (nonatomic, copy) NSString *imageName;
@property (nonatomic, copy) NSString *selectedImageName;

//Config
@property (nonatomic, assign) BOOL dimSubViews;

@end
