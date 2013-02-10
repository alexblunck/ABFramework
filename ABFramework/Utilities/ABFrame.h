//
//  ABFrame.h
//  ABFramework
//
//  Created by Alexander Blunck on 1/12/13.
//  Copyright (c) 2013 Ablfx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ABFrame : NSObject

/*
 CGFLoat
 */
//Origin Y value of the bottom of a CGRect
CGFloat CGFloatBottomOriginY(CGRect rect);



/*
 CGSize
 */
//Offset values of a CGSize
CGSize CGSizeOffset(CGSize size, CGFloat sizeWidthBy, CGFloat sizeHeightBy);
//Offset only the Width Size value of a CGSize
CGSize CGSizeOffsetWidth(CGSize size, CGFloat sizeWidthBy);
//Offset only the Height Size value of a CGSize
CGSize CGSizeOffsetHeight(CGSize size, CGFloat sizeHeightBy);

//CGSize of a specific image
CGSize CGSizeFromUIImageName(NSString* imageName);
//Exact size of a string in a specific UILabel
CGSize CGSizeForTextInLabel(NSString *text, UILabel *label);

/*
 CGRect
 */
//CGRect for one CGRect centered in another
CGRect CGRectCenteredInCGRect (CGRect rect, CGRect rectToCenterIn);
//CGRect for one CGRect centered horizontally in another
CGRect CGRectCenteredHorizontally(CGRect rect, CGRect rectToCenterIn, CGFloat originY);
//CGRect for one CGRect centered vertically in another
CGRect CGRectCenteredVertically(CGRect rect, CGRect rectToCenterIn, CGFloat originX);
//CGRect for one CGRect centered horizontally in another (Keeping same Y Origin)
CGRect CGRectCenteredHorizontallyS(CGRect rect, CGRect rectToCenterIn);
//CGRect for one CGRect centered vertically in another (Keeping same X Origin)
CGRect CGRectCenteredVerticallyS(CGRect rect, CGRect rectToCenterIn);

//Adjust only Origin values of a CGRect
CGRect CGRectChangingOrigin (CGRect rect, CGFloat originX, CGFloat originY);
//Adjust only X Origin value of a CGRect
CGRect CGRectChangingOriginX (CGRect rect, CGFloat originX);
//Adjust only X Origin value of a CGRect
CGRect CGRectChangingOriginY (CGRect rect, CGFloat originY);

//Adjust only Size values of a CGRect
CGRect CGRectChangingSize (CGRect rect, CGFloat sizeWidth, CGFloat sizeHeight);
//Adjust only Size values of a CGRect with a CGSize
CGRect CGRectChangingCGSize(CGRect rect, CGSize size);
//Adjust only Width Size value of a CGRect
CGRect CGRectChangingSizeWidth (CGRect rect, CGFloat sizeWidth);
//Adjust only Height Size value of a CGRect
CGRect CGRectChangingSizeHeight (CGRect rect, CGFloat sizeHeight);

//Offset only Origin values of a CGRect
CGRect CGRectOffsetOrigin (CGRect rect, CGFloat originXBy, CGFloat originYBy);
//Offset only X Origin of a CGRect
CGRect CGRectOffsetOriginX (CGRect rect, CGFloat originXBy);
//Offset only Y Origin of a CGRect
CGRect CGRectOffsetOriginY (CGRect rect, CGFloat originYBy);

//Offset only Size values of a CGRect
CGRect CGRectOffsetSize (CGRect rect, CGFloat sizeWidthBy, CGFloat sizeHeightBy);
//Offset only Width Size of a CGRect
CGRect CGRectOffsetSizeWidth (CGRect rect, CGFloat sizeWidthBy);
//Offset only Height Size of a CGRect
CGRect CGRectOffsetSizeHeight (CGRect rect, CGFloat sizeHeightBy);

//CGRect for CGRect right inside of another CGRect
CGRect CGRectInsideRectRight (CGRect rect, CGRect rectToRightIn);
//CGRect for CGRect above a certain point
CGRect CGRectAbovePointY(CGRect rect, CGFloat pointY);

//Returns zeroed CGRect for an imageName (located in bundle)
+(CGRect) frameForImageName:(NSString*)imageName;

@end
