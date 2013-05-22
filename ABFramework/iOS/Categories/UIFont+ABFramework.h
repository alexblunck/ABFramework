//
//  UIFont+ABFramework.h
//  ABFramework
//
//  Created by Alexander Blunck on 5/22/13.
//  Copyright (c) 2013 Ablfx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIFont (ABFramework)

+(BOOL) fontWithNameExists:(NSString*)fontName;

+(UIFont*) customFontWithName:(NSString*)fontName fontPath:(NSString*)fontPath extension:(NSString*)extension size:(CGFloat)size;

@end
