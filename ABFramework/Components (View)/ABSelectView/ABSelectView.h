//
//  ABSelectView.h
//  ABFramework
//
//  Created by Alexander Blunck on 10/17/12.
//  Copyright (c) 2012 Ablfx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ABSelectViewTheme.h"
#import "ABSelectViewItem.h"

#define ABSELECTVIEW_THEME_DEFAULT ABSelectViewThemeTagDark

@interface ABSelectView : ABView

//Utility
+(id) showWithStringArray:(NSArray*)stringArray
          completionBlock:(ABBlockInteger)block;

+(id) showWithStringArray:(NSArray*)stringArray
             defaultIndex:(int)defaultIndex
          completionBlock:(ABBlockInteger)block;

+(id) showWithStringArray:(NSArray*)stringArray
             defaultIndex:(int)defaultIndex
                    theme:(ABSelectViewTheme*)theme
          completionBlock:(ABBlockInteger)block;

+(id) showInView:(UIView*)view
 WithStringArray:(NSArray*)stringArray
    defaultIndex:(int)defaultIndex
           theme:(ABSelectViewTheme*)theme
 completionBlock:(ABBlockInteger)block;

@property (nonatomic, assign) BOOL landscape;

@end
