//
//  ABSeperator.h
//  ABFramework
//
//  Created by Alexander Blunck on 3/30/13.
//  Copyright (c) 2013 Ablfx. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    ABSeperatorTypeNone,
    ABSeperatorTypeEtchedVertical,
    ABSeperatorTypeEtchedHorizontal
} ABSeperatorType;

@interface ABSeperator : UIView

//Utility
+(id) seperatorWithType:(ABSeperatorType)type length:(CGFloat)length topHex:(NSString*)topColorHex bottomHex:(NSString*)bottomColorHex;
+(id) seperatorWithType:(ABSeperatorType)type length:(CGFloat)length top:(UIColor*)topColor bottom:(UIColor*)bottomColor;

@end
