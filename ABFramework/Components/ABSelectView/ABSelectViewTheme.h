//
//  ABSelectViewTheme.h
//  ABFramework
//
//  Created by Alexander Blunck on 10/17/12.
//  Copyright (c) 2012 Ablfx. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {ABSelectViewThemeDark} _ABSelectViewThemeTag;

@interface ABSelectViewTheme : NSObject

@property (nonatomic, strong) NSString *topRowImageName;
@property (nonatomic, strong) NSString *middleRowImageName;
@property (nonatomic, strong) NSString *bottomRowImageName;

+(id) themeWithTop:(NSString*)top middle:(NSString*)middle bottom:(NSString*)bottom;
+(id) themeWithTag:(_ABSelectViewThemeTag)theme;

@end
