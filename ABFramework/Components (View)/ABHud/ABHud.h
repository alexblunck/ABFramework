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
+(void) showActivity;
+(void) showActivityAndHide;
+(void) showActivityAndHide:(NSString*)text;

//Accessors
+(void) setAnimationType:(ABHudAnimationType)type;
+(void) setCornerRadius:(CGFloat)cornerRadius;

@end
