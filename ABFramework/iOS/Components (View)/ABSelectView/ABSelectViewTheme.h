//
//  ABSelectViewTheme.h
//  ABFramework
//
//  Created by Alexander Blunck on 10/17/12.
//  Copyright (c) 2012 Ablfx. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    ABSelectViewThemeTagNone,
    ABSelectViewThemeTagDark
} ABSelectViewThemeTag;

@interface ABSelectViewTheme : NSObject

//Utility
+(id) themeWithTop:(NSString*)top middle:(NSString*)middle bottom:(NSString*)bottom;
+(id) themeWithTag:(ABSelectViewThemeTag)theme;

@property (nonatomic, weak) NSString *topRowImageName;
@property (nonatomic, weak) NSString *middleRowImageName;
@property (nonatomic, weak) NSString *bottomRowImageName;

@end