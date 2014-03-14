//
//  UIScreen+ABFramework.h
//  ABFramework
//
//  Created by Alexander Blunck on 7/23/13.
//  Copyright (c) 2013 Ablfx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScreen (ABFramework)

+(CGFloat) screenWidth;
+(CGFloat) screenHeight;
+(CGFloat) screenScale;
+(BOOL) retinaScreen;

+(CGFloat) keyboardHeight;

+(CGFloat) statusBarHeight;

@end
