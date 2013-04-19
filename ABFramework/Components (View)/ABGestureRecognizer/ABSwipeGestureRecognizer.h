//
//  ABSwipeGestureRecognizer.h
//  ABFramework
//
//  Created by Alexander Blunck on 4/19/13.
//  Copyright (c) 2013 Ablfx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ABSwipeGestureRecognizer : UISwipeGestureRecognizer

//Utility
+(id) rightSwipeGestureOnView:(UIView*)view block:(ABBlockVoid)block;
+(id) downSwipeGestureOnView:(UIView*)view block:(ABBlockVoid)block;

@end
