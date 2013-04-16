//
//  ABTapGestureRecognizer.h
//  ABFramework
//
//  Created by Alexander Blunck on 4/16/13.
//  Copyright (c) 2013 Ablfx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ABTapGestureRecognizer : UITapGestureRecognizer

+(id) singleTapGestureOnView:(UIView*)view block:(ABBlockVoid)block;

@end
