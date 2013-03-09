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
+(id) buttonWithImageName:(NSString*)imageName target:(id)target selected:(SEL)selector;
+(id) buttonWithtTarget:(id)target selected:(SEL)selector;
+(id) buttonWithImageName:(NSString*)imageName actionBlock:(ABBlockVoid)actionBlock;
+(id) buttonWithActionBlock:(ABBlockVoid)actionBlock;

@property(nonatomic, strong) NSDictionary *userData;

@end
