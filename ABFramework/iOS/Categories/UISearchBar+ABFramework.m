//
//  UISearchBar+ABFramework.m
//  ABFramework
//
//  Created by Alexander Blunck on 6/27/13.
//  Copyright (c) 2013 Ablfx. All rights reserved.
//

#import "UISearchBar+ABFramework.h"

@implementation UISearchBar (ABFramework)

-(void) setKeyboardAppearance:(UIKeyboardAppearance)keyBoardApperance
{
    [self enumerateAllSubviews:^(UIView *subview) {
        
        if([subview isKindOfClass:[UITextField class]])
        {
            [(UITextField*)subview setKeyboardAppearance:keyBoardApperance];
        }
        
    }];
}

@end
