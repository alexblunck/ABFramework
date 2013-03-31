//
//  ABEntypoView.h
//  Serrano iOS
//
//  Created by Alexander Blunck on 3/31/13.
//  Copyright (c) 2013 Serrano - Ablfx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ABEntypoView : UIView

//Utility
+(id) viewWithIconName:(NSString*)iconName size:(CGFloat)size;

//Initializer
-(id) initWithIconName:(NSString*)iconName size:(CGFloat)size;


//Config

/**
 * Color
 */
@property (nonatomic, strong) UIColor *color;

/**
 * Shadow
 */
@property (nonatomic, assign) ABShadowType shadow;

/**
 * Shadow Color
 */
@property (nonatomic, strong) UIColor *shadowColor;

@end
