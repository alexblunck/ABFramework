//
//  ABSeperator.h
//  Serrano iOS
//
//  Created by Alexander Blunck on 3/30/13.
//  Copyright (c) 2013 Serrano - Ablfx. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    ABSeperatorTypeNone,
    ABSeperatorTypeEtchedVertical,
    ABSeperatorTypeEtchedHorizontal
} ABSeperatorType;

@interface ABSeperator : UIView

//Utility
+(id) seperatorWithType:(ABSeperatorType)type length:(CGFloat)length top:(NSString*)topColorHex bottom:(NSString*)bottomColorHex;

@end
