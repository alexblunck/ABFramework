//
//  ABFlexibleView.h
//  ComingUp iOS
//
//  Created by Alexander Blunck on 3/14/13.
//  Copyright (c) 2013 Ablfx. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    ABFlexibleViewTypeNone,
    ABFlexibleViewTypeAll,          //Completely flexible, 8 images expected
    ABFlexibleViewTypeHorizontal    //Horizontall flexible, 3 images expected (left, middle, right)
} ABFlexibleViewType;

@interface ABFlexibleView : UIView

/**
 * Initializer
 *
 * baseName -> expects following images: 
 * {baseName}-top-left, -top, -top-right, -right, -bottom-right, -bottom, -bottom-left, -left
 *
 * corner images should be squares with same width & height
 * left & right should have the same width as the corner images
 * top & bottom should have the same height as the corner images
 *
 */
-(id) initWithBaseName:(NSString*)baseName type:(ABFlexibleViewType)type frame:(CGRect)frame;

//Change
-(void) changeHeight:(CGFloat)newHeight animated:(BOOL)animated;
-(void) changeWidth:(CGFloat)newWidth animated:(BOOL)animated;

@end
