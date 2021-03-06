//
//  ABQuadMenu.h
//  ABFramework
//
//  Created by Alexander Blunck on 5/14/13.
//  Copyright (c) 2013 Ablfx. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    ABQuadMenuThemeLight,
    ABQuadMenuThemeLightTranslucent
} ABQuadMenuTheme;

//ABQuadMenuItem
@interface ABQuadMenuItem : NSObject

//Utility
+(id) itemWithIconName:(NSString*)iconName title:(NSString*)title action:(ABBlockVoid)actionBlock;

@end



//ABQuadMenu
@interface ABQuadMenu : UIView

//Utility
/**
 * Init menu with array of ABQuadMenuItem 's (exactly 3) and show
 */
+(id) showMenuWithItems:(NSArray*)items;
+(id) showMenuWithItems:(NSArray*)items completion:(ABBlockVoid)block;

//Initializer
/**
 * Init menu with array of ABQuadMenuItem 's (exactly 3)
 */
-(id) initWithItems:(NSArray*)items;


/**
 * Show menu
 */
-(void) show;


/**
 * Set menu theme, default is "ABQuadMenuThemeLight"
 */
@property (nonatomic, assign) ABQuadMenuTheme theme;

@property (nonatomic, copy) NSString *dismissTitle;
@property (nonatomic, copy) NSString *dismissIconName;
@property (nonatomic, copy) UIColor *dismissIconColor;

@end
