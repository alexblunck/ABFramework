//
//  ABFrame.h
//  ABFramework
//
//  Created by Alexander Blunck on 1/12/13.
//  Copyright (c) 2013 Ablfx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ABFrame : NSObject

/**
 * CGFloat
 */
#pragma mark - CGFloat Relative
//Bottom Point Of CGRect
CGFloat CGFloatBottomPointY(CGRect rect);



/**
 * CGSize
 */
#pragma mark - CGSize Offset
//Size
CGSize CGSizeOffset(CGSize size, CGFloat sizeWidthBy, CGFloat sizeHeightBy);

//Size Width
CGSize CGSizeOffsetWidth(CGSize size, CGFloat sizeWidthBy);

//Size Height
CGSize CGSizeOffsetHeight(CGSize size, CGFloat sizeHeightBy);


#pragma mark - CGSize Misc
//CGSize For Image
CGSize CGSizeForImageName(NSString* imageName);

//CGSize For Text In UILabel
CGSize CGSizeForTextInLabel(NSString *text, UILabel *label);



/**
 * CGRect
 */
#pragma mark - CGRect Centered
//CGRect Centered in CGRect
CGRect CGRectCenteredWithCGRect (CGRect rect, CGRect rectToCenterWith);

//CGRect Centered Horizontally With CGRect
CGRect CGRectCenteredHorizontally(CGRect rect, CGRect rectToCenterWith, CGFloat originY);

//CGRect Centered Vertically With CGRect
CGRect CGRectCenteredVertically(CGRect rect, CGRect rectToCenterWith, CGFloat originX);

//CGRect Centered Horizontally With CGRect (Simple)
CGRect CGRectCenteredHorizontallyS(CGRect rect, CGRect rectToCenterWith);

//CGRect Centered Vertically With CGRect (Simple)
CGRect CGRectCenteredVerticallyS(CGRect rect, CGRect rectToCenterWith);


#pragma mark - CGRect Changing Origin
//Origin
CGRect CGRectChangingOrigin (CGRect rect, CGFloat originX, CGFloat originY);

//Origin X
CGRect CGRectChangingOriginX (CGRect rect, CGFloat originX);

//Origin Y
CGRect CGRectChangingOriginY (CGRect rect, CGFloat originY);


#pragma mark - CGRect Changing Size
//Size
CGRect CGRectChangingSize (CGRect rect, CGFloat sizeWidth, CGFloat sizeHeight);

//CGSize
CGRect CGRectChangingCGSize(CGRect rect, CGSize size);

//Size Width
CGRect CGRectChangingSizeWidth (CGRect rect, CGFloat sizeWidth);

//Size Height
CGRect CGRectChangingSizeHeight (CGRect rect, CGFloat sizeHeight);


#pragma mark - CGRect Offset Origin
//Origin
CGRect CGRectOffsetOrigin (CGRect rect, CGFloat originXBy, CGFloat originYBy);

//Origin X
CGRect CGRectOffsetOriginX (CGRect rect, CGFloat originXBy);

//Origin Y
CGRect CGRectOffsetOriginY (CGRect rect, CGFloat originYBy);


#pragma mark - CGRect Offset Size
//Size
CGRect CGRectOffsetSize (CGRect rect, CGFloat sizeWidthBy, CGFloat sizeHeightBy);

//Size Width
CGRect CGRectOffsetSizeWidth (CGRect rect, CGFloat sizeWidthBy);

//Size Height
CGRect CGRectOffsetSizeHeight (CGRect rect, CGFloat sizeHeightBy);


#pragma mark - CGRect Relative Inside
//TopCenter
CGRect CGRectInsideTopCenter(CGRect rect, CGRect rectToTopCenterWith, CGFloat padding);

//TopRight
CGRect CGRectInsideTopRight(CGRect rect, CGRect rectToTopRightWith, CGFloat padding);

//RightCenter
CGRect CGRectInsideRightCenter(CGRect rect, CGRect rectToRightCenterWith, CGFloat padding);

//RightBottom
CGRect CGRectInsideRightBottom(CGRect rect, CGRect rectToRightBottomWith, CGFloat padding);

//BottomCenter
CGRect CGRectInsideBottomCenter(CGRect rect, CGRect rectToBottomCenterWith, CGFloat padding);

//BottomLeft
CGRect CGRectInsideBottomLeft(CGRect rect, CGRect rectToBottomLeftWith, CGFloat padding);

//LeftCenter
CGRect CGRectInsideLeftCenter(CGRect rect, CGRect rectToLeftCenterWith, CGFloat padding);


#pragma mark - CGRect Relative Outside
//TopCenter
CGRect CGRectOutsideTopCenter(CGRect rect, CGRect rectToTopCenterWith, CGFloat padding);

//RightCenter
CGRect CGRectOutsideRightCenter(CGRect rect, CGRect rectToRightCenterWith, CGFloat padding);

//BottomCenter
CGRect CGRectOutsideBottomCenter(CGRect rect, CGRect rectToBottomCenterWith, CGFloat padding);

//LeftCenter
CGRect CGRectOutsideLeftCenter(CGRect rect, CGRect rectToLeftCenterWith, CGFloat padding);


#pragma mark - CGRect Relative With Points
//Above
CGRect CGRectAbovePointY(CGRect rect, CGFloat pointY);

@end
