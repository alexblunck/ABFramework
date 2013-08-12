//
//  ABHud.h
//  ABFramework
//
//  Created by Alexander Blunck on 3/11/13.
//  Copyright (c) 2013 Ablfx. All rights reserved.
//

#import <UIKit/UIKit.h>

//Config
#define ABHUD_OPACITY 0.8f
#define ABHUD_CORNER_RADIUS -1 //"-1" for circle
#define ABHUD_ANIMATION_TYPE 2

typedef enum {
    ABHudAnimationTypeNone,
    ABHudAnimationTypeBounce,
    ABHudAnimationTypePop,
    ABHudAnimationTypeFade
} ABHudAnimationType;

@interface ABHud : UIView

//Utility
//Show
+(void) showActivity;
+(void) showActivityWithTouchHandler:(ABBlockVoid)touchHandler;
+(void) showActivity:(NSString*)message;
+(void) showActivity:(NSString*)message touchHandler:(ABBlockVoid)touchHandler;
+(void) showActivityAndHide;
//Dismiss
+(void) dismiss;
+(void) dismissWithSuccess:(NSString*)message;
+(void) dismissWithError:(NSString*)message;
+(void) dismissWithIconName:(NSString*)iconName message:(NSString*)message;

//Config
+(void) setAnimationType:(ABHudAnimationType)animationType;
+(void) setCornerRadius:(CGFloat)cornerRadius;

@end
