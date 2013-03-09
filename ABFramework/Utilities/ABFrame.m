//
//  ABFrame.m
//  ABFramework
//
//  Created by Alexander Blunck on 1/12/13.
//  Copyright (c) 2013 Ablfx. All rights reserved.
//

#import "ABFrame.h"

@implementation ABFrame

#pragma mark - CGFloat
//Origin Y value of the bottom of a CGRect
CGFloat CGFloatBottomOriginY(CGRect rect)
{
    return rect.origin.y + rect.size.height;
}





#pragma mark - CGSize
//Offset values of a CGSize
CGSize CGSizeOffset(CGSize size, CGFloat sizeWidthBy, CGFloat sizeHeightBy)
{
    return CGSizeMake(size.width + sizeWidthBy, size.height + sizeHeightBy);
}

//Offset only the Width Size value of a CGSize
CGSize CGSizeOffsetWidth(CGSize size, CGFloat sizeWidthBy)
{
    return CGSizeOffset(size, sizeWidthBy, 0);
}

//Offset only the Height Size value of a CGSize
CGSize CGSizeOffsetHeight(CGSize size, CGFloat sizeHeightBy)
{
    return CGSizeOffset(size, 0, sizeHeightBy);
}


//CGSize of a specific image
CGSize CGSizeFromUIImageName(NSString* imageName)
{
    UIImage *image = [UIImage imageNamed:imageName];
    return image.size;
}

//Exact size of a string in a specific UILabel
CGSize CGSizeForTextInLabel(NSString *text, UILabel *label)
{
    UILabel *l = [label abCopy];
    l.text = text;
    [l sizeToFit];
    
    return l.bounds.size;
}





#pragma mark - CGRect
//CGRect for one CGRect centered in another
CGRect CGRectCenteredInCGRect (CGRect rect, CGRect rectToCenterIn)
{
    return CGRectChangingOrigin(rect,
                                (rectToCenterIn.size.width-rect.size.width)/2,
                                (rectToCenterIn.size.height-rect.size.height)/2
                                );
}

//CGRect for one CGRect centered horizontally in another
CGRect CGRectCenteredHorizontally(CGRect rect, CGRect rectToCenterIn, CGFloat originY)
{
    return CGRectChangingOrigin(rect,
                                (rectToCenterIn.size.width-rect.size.width)/2,
                                originY
                                );
}

//CGRect for one CGRect centered vertically in another
CGRect CGRectCenteredVertically(CGRect rect, CGRect rectToCenterIn, CGFloat originX)
{
    return CGRectChangingOrigin(rect,
                                originX,
                                (rectToCenterIn.size.height-rect.size.height)/2
                                );
}

//CGRect for one CGRect centered horizontally in another (Keeping same Y Origin)
CGRect CGRectCenteredHorizontallyS(CGRect rect, CGRect rectToCenterIn)
{
    return CGRectChangingOriginX(rect, (rectToCenterIn.size.width-rect.size.width)/2);
}

//CGRect for one CGRect centered vertically in another (Keeping same X Origin)
CGRect CGRectCenteredVerticallyS(CGRect rect, CGRect rectToCenterIn)
{
    return  CGRectChangingOriginY(rect, (rectToCenterIn.size.height-rect.size.height)/2);
}



//Adjust only Origin values of a CGRect
CGRect CGRectChangingOrigin (CGRect rect, CGFloat originX, CGFloat originY)
{
    return CGRectMake(originX, originY, rect.size.width, rect.size.height);
}

//Adjust only X Origin value of a CGRect
CGRect CGRectChangingOriginX (CGRect rect, CGFloat originX)
{
    return CGRectChangingOrigin(rect, originX, rect.origin.y);
}

//Adjust only X Origin value of a CGRect
CGRect CGRectChangingOriginY (CGRect rect, CGFloat originY)
{
    return CGRectChangingOrigin(rect, rect.origin.x, originY);
}



//Adjust only Size values of a CGRect
CGRect CGRectChangingSize (CGRect rect, CGFloat sizeWidth, CGFloat sizeHeight)
{
    return CGRectMake(rect.origin.x, rect.origin.y, sizeWidth, sizeHeight);
}

//Adjust only Size values of a CGRect with a CGSize
CGRect CGRectChangingCGSize(CGRect rect, CGSize size)
{
    return CGRectChangingSize(rect, size.width, size.height);
}

//Adjust only Width Size value of a CGRect
CGRect CGRectChangingSizeWidth (CGRect rect, CGFloat sizeWidth)
{
    return CGRectChangingSize(rect, sizeWidth, rect.size.height);
}

//Adjust only Height Size value of a CGRect
CGRect CGRectChangingSizeHeight (CGRect rect, CGFloat sizeHeight)
{
    return CGRectChangingSize(rect, rect.size.width, sizeHeight);
}



//Offset only Origin values of a CGRect
CGRect CGRectOffsetOrigin (CGRect rect, CGFloat originXBy, CGFloat originYBy)
{
    return CGRectChangingOrigin(rect, rect.origin.x+originXBy, rect.origin.y+originYBy);
}

//Offset only X Origin of a CGRect
CGRect CGRectOffsetOriginX (CGRect rect, CGFloat originXBy)
{
    return CGRectOffsetOrigin(rect, originXBy, 0);
}

//Offset only Y Origin of a CGRect
CGRect CGRectOffsetOriginY (CGRect rect, CGFloat originYBy)
{
    return CGRectOffsetOrigin(rect, 0, originYBy);
}



//Offset only Size values of a CGRect
CGRect CGRectOffsetSize (CGRect rect, CGFloat sizeWidthBy, CGFloat sizeHeightBy)
{
    return CGRectChangingSize(rect, rect.size.width+sizeWidthBy, rect.size.height+sizeHeightBy);
}

//Offset only Width Size of a CGRect
CGRect CGRectOffsetSizeWidth (CGRect rect, CGFloat sizeWidthBy)
{
    return CGRectOffsetSize(rect, sizeWidthBy, 0);
}

//Offset only Height Size of a CGRect
CGRect CGRectOffsetSizeHeight (CGRect rect, CGFloat sizeHeightBy)
{
    return CGRectOffsetSize(rect, 0, sizeHeightBy);
}



//CGRect for CGRect right inside of another CGRect
CGRect CGRectInsideRectRightS (CGRect rect, CGRect rectToRightIn)
{
    return CGRectInsideRectRight(rect, rectToRightIn, 0.0f);
}
CGRect CGRectInsideRectRight (CGRect rect, CGRect rectToRightIn, CGFloat padding)
{
    return  CGRectChangingOriginX(rect, rectToRightIn.size.width-rect.size.width-padding);
}

//CGRect for CGRect on the bottom edge of another CGRect
CGRect CGRectInsideRectBottom (CGRect rect, CGRect rectToBottomIn)
{
    return CGRectChangingOriginY(rect, rectToBottomIn.size.height-rect.size.height);
}

//CGRect for CGRect in the top right corner of another CGRect
CGRect CGRectInsideRectTopRight (CGRect rect, CGRect rectToTopRightIn, CGFloat padding)
{
    CGRect newRect;
    //Top
    newRect = CGRectChangingOriginY(rect, 0);
    //Right
    newRect = CGRectInsideRectRightS(rect, rectToTopRightIn);
    //Padding
    newRect = CGRectOffsetOrigin(newRect, -padding, padding);
    
    return newRect;
}

//CGRect for CGRect in the top left corner of another CGRect
CGRect CGRectInsideRectTopLeft (CGRect rect, CGRect rectToTopLeftIn, CGFloat padding)
{
    CGRect newRect;
    //Top / Left
    newRect = CGRectChangingOrigin(rect, 0, 0);
    //Padding
    newRect = CGRectOffsetOrigin(newRect, padding, padding);
    
    return newRect;
}

//CGRect for CGRect above a certain point
CGRect CGRectAbovePointY(CGRect rect, CGFloat pointY)
{
    return CGRectChangingOriginY(rect, pointY - rect.size.height);
}

@end
