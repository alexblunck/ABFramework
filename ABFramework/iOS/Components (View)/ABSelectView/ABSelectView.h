//
//  ABSelectView.h
//  ABFramework
//
//  Created by Alexander Blunck on 10/17/12.
//  Copyright (c) 2012 Ablfx. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    ABSelectViewThemeNone,
    ABSelectViewThemeDark,
    ABSelectViewThemeTranslucent
} ABSelectViewTheme;

@interface ABSelectView : UIView

//Utility
+(id) showWithStringArray:(NSArray*)stringArray completion:(ABBlockInteger)block;

+(id) showWithStringArray:(NSArray*)stringArray
            selectedIndex:(NSInteger)index
               completion:(ABBlockInteger)block;

+(id) showWithPresentingView:(UIView*)view
                 stringArray:(NSArray*)stringArray
               selectedIndex:(NSInteger)index
                       theme:(ABSelectViewTheme)theme
                  completion:(ABBlockInteger)block;

//Initializer
-(id) initWithPresentingView:(UIView*)view
                 stringArray:(NSArray*)stringArray
               selectedIndex:(NSInteger)index
                       theme:(ABSelectViewTheme)theme
                  completion:(ABBlockInteger)block;

//Show / Hide
-(void) show;


//Config
/**
 * tableWidth
 * Width of the select table, Default: 230.0f
 */
@property (nonatomic, assign) CGFloat tableWidth;

/**
 * callCompletionBlockAfterHideAnimation
 * Completion block can be called once the hide naimtion has finsihed, Default: NO
 */
@property (nonatomic, assign) BOOL callCompletionBlockAfterHideAnimation;

@end
