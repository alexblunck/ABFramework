//
//  ABSelectViewTheme.m
//  ABFramework
//
//  Created by Alexander Blunck on 10/17/12.
//  Copyright (c) 2012 Ablfx. All rights reserved.
//

#import "ABSelectViewTheme.h"

@implementation ABSelectViewTheme

-(id) initThemeTop:(NSString*)top middle:(NSString*)middle bottom:(NSString*)bottom {
    if (self = [super init]) {
        self.topRowImageName = top;
        self.middleRowImageName = middle;
        self.bottomRowImageName = bottom;
    }
    return self;
}

+(id) themeWithTop:(NSString*)top middle:(NSString*)middle bottom:(NSString*)bottom {
    return [[self alloc] initThemeTop:top middle:middle bottom:bottom];
}

-(id) initWithTag:(_ABSelectViewThemeTag)theme {
    if (self = [super init]) {
        switch (theme) {
            case ABSelectViewThemeDark:
                self.topRowImageName = @"abselecttheme-dark-top-cell.png";
                self.middleRowImageName = @"abselecttheme-dark-middle-cell.png";
                self.bottomRowImageName = @"abselecttheme-dark-bottom-cell.png";
                break;
            default:
                NSLog(@"ABSelectViewTheme: INVALID THEME");
                break;
        }
    } return self;
}

+(id) themeWithTag:(_ABSelectViewThemeTag)theme {
    return [[self alloc] initWithTag:theme];
}

@end
