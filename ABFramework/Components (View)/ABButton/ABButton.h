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
+(id) buttonWithActionBlock:(void(^)())block;

@property(nonatomic, strong) NSDictionary *userData;

@end
