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
#pragma mark - CGFloat Relative
//Bottom Point Of CGRect
CGFloat CGFloatBottomPointY(CGRect rect)
{
    return rect.origin.y + rect.size.height;
}



#pragma mark - CGPoint
#pragma mark - CGPoint Make
CGPoint cgp(CGFloat x, CGFloat y)
{
    return CGPointMake(x, y);
}



#pragma mark - CGSize
#pragma mark - CGSize Make
CGSize cgs(CGFloat width, CGFloat height)
{
    return CGSizeMake(height, width);
}

#pragma mark - CGSize Offset
//Size
CGSize CGSizeOffset(CGSize size, CGFloat sizeWidthBy, CGFloat sizeHeightBy)
{
    return CGSizeMake(size.width + sizeWidthBy, size.height + sizeHeightBy);
}

//Size Width
CGSize CGSizeOffsetWidth(CGSize size, CGFloat sizeWidthBy)
{
    return CGSizeOffset(size, sizeWidthBy, 0);
}

//Size Height
CGSize CGSizeOffsetHeight(CGSize size, CGFloat sizeHeightBy)
{
    return CGSizeOffset(size, 0, sizeHeightBy);
}



#pragma mark - NSRect
#pragma mark - NSRect Make
#ifdef ABFRAMEWORK_MAC
NSRect nsr(CGFloat x, CGFloat y, CGFloat width, CGFloat height)
{
    return NSMakeRect(x, y, width, height);
}

NSRect NSRectMake(CGFloat x, CGFloat y, CGFloat width, CGFloat height)
{
    
    return NSMakeRect(x, y, width, height);
}
#endif


#pragma mark - CGRect
#pragma mark - CGRect Make
CGRect cgr(CGFloat x, CGFloat y, CGFloat w, CGFloat h)
{
    return CGRectMake(x, y, w, h);
}

#pragma mark - CGRect Centered
//CGRect Centered in CGRect
CGRect CGRectCenteredWithCGRect (CGRect rect, CGRect rectToCenterWith)
{
    CGRect newRect;
    //Horizontal
    newRect = CGRectCenteredHorizontallyS(rect, rectToCenterWith);
    //Vertical
    newRect = CGRectCenteredVerticallyS(newRect, rectToCenterWith);
    
    return newRect;
}

//CGRect Centered Horizontally With CGRect
CGRect CGRectCenteredHorizontally(CGRect rect, CGRect rectToCenterWith, CGFloat originY)
{
    return CGRectChangingOrigin(rect,
                                rectToCenterWith.origin.x + (rectToCenterWith.size.width-rect.size.width)/2,
                                originY
                                );
}

//CGRect Centered Vertically With CGRect
CGRect CGRectCenteredVertically(CGRect rect, CGRect rectToCenterWith, CGFloat originX)
{
    return CGRectChangingOrigin(rect,
                                originX,
                                rectToCenterWith.origin.y + (rectToCenterWith.size.height-rect.size.height)/2
                                );
}

//CGRect Centered Horizontally With CGRect (Simple)
CGRect CGRectCenteredHorizontallyS(CGRect rect, CGRect rectToCenterWith)
{
    return CGRectCenteredHorizontally(rect, rectToCenterWith, rect.origin.y);
}

//CGRect Centered Vertically With CGRect (Simple)
CGRect CGRectCenteredVerticallyS(CGRect rect, CGRect rectToCenterWith)
{
    return CGRectCenteredVertically(rect, rectToCenterWith, rect.origin.x);
}


#pragma mark - CGRect Changing Origin
//Origin
CGRect CGRectChangingOrigin (CGRect rect, CGFloat originX, CGFloat originY)
{
    return CGRectMake(originX, originY, rect.size.width, rect.size.height);
}

//Origin X
CGRect CGRectChangingOriginX (CGRect rect, CGFloat originX)
{
    return CGRectChangingOrigin(rect, originX, rect.origin.y);
}

//Origin Y
CGRect CGRectChangingOriginY (CGRect rect, CGFloat originY)
{
    return CGRectChangingOrigin(rect, rect.origin.x, originY);
}


#pragma mark - CGRect Changing Size
//Size
CGRect CGRectChangingSize (CGRect rect, CGFloat sizeWidth, CGFloat sizeHeight)
{
    return CGRectMake(rect.origin.x, rect.origin.y, sizeWidth, sizeHeight);
}

//CGSize
CGRect CGRectChangingCGSize(CGRect rect, CGSize size)
{
    return CGRectChangingSize(rect, size.width, size.height);
}

//Size Width
CGRect CGRectChangingSizeWidth (CGRect rect, CGFloat sizeWidth)
{
    return CGRectChangingSize(rect, sizeWidth, rect.size.height);
}

//Size Height
CGRect CGRectChangingSizeHeight (CGRect rect, CGFloat sizeHeight)
{
    return CGRectChangingSize(rect, rect.size.width, sizeHeight);
}


#pragma mark - CGRect Offset Origin
//Origin
CGRect CGRectOffsetOrigin (CGRect rect, CGFloat originXBy, CGFloat originYBy)
{
    return CGRectChangingOrigin(rect, rect.origin.x+originXBy, rect.origin.y+originYBy);
}

//Origin X
CGRect CGRectOffsetOriginX (CGRect rect, CGFloat originXBy)
{
    return CGRectOffsetOrigin(rect, originXBy, 0);
}

//Origin Y
CGRect CGRectOffsetOriginY (CGRect rect, CGFloat originYBy)
{
    return CGRectOffsetOrigin(rect, 0, originYBy);
}


#pragma mark - CGRect Offset Size
//Size
CGRect CGRectOffsetSize (CGRect rect, CGFloat sizeWidthBy, CGFloat sizeHeightBy)
{
    return CGRectChangingSize(rect, rect.size.width+sizeWidthBy, rect.size.height+sizeHeightBy);
}

//Size Width
CGRect CGRectOffsetSizeWidth (CGRect rect, CGFloat sizeWidthBy)
{
    return CGRectOffsetSize(rect, sizeWidthBy, 0);
}

//Size Height
CGRect CGRectOffsetSizeHeight (CGRect rect, CGFloat sizeHeightBy)
{
    return CGRectOffsetSize(rect, 0, sizeHeightBy);
}


#pragma mark - CGRect Relative Inside
//TopLeft
CGRect CGRectInsideTopLeft(CGRect rect, CGRect rectToTopLeftWith, CGFloat padding)
{
    CGRect newRect;
    //Inside
    newRect = CGRectChangingOrigin(rect, rectToTopLeftWith.origin.x, rectToTopLeftWith.origin.y);
    //Padding
    newRect = CGRectOffsetOrigin(newRect, padding, padding);
    
    return newRect;
}

//TopCenter
CGRect CGRectInsideTopCenter(CGRect rect, CGRect rectToTopCenterWith, CGFloat padding)
{
    CGRect newRect;
    //Inside
    newRect = CGRectChangingOrigin(rect, rectToTopCenterWith.origin.x, rectToTopCenterWith.origin.y);
    //Center
    newRect = CGRectCenteredHorizontallyS(newRect, rectToTopCenterWith);
    //Padding
    newRect = CGRectOffsetOriginY(newRect, padding);
    
    return newRect;
}

//TopRight
CGRect CGRectInsideTopRight(CGRect rect, CGRect rectToTopRightWith, CGFloat padding)
{
    CGRect newRect;
    //Inside
    newRect = CGRectChangingOrigin(rect,
                                   rectToTopRightWith.origin.x + rectToTopRightWith.size.width - rect.size.width,
                                   rectToTopRightWith.origin.y
                                   );
    //Padding
    newRect = CGRectOffsetOrigin(newRect, -padding, padding);
    
    return newRect;
}

//RightCenter
CGRect CGRectInsideRightCenter(CGRect rect, CGRect rectToRightCenterWith, CGFloat padding)
{
    CGRect newRect;
    //Inside
    newRect = CGRectChangingOriginX(rect,
                                    rectToRightCenterWith.origin.x + rectToRightCenterWith.size.width - rect.size.width
                                    );
    //Center
    newRect = CGRectCenteredVerticallyS(newRect, rectToRightCenterWith);
    //Padding
    newRect = CGRectOffsetOriginX(newRect, -padding);
    
    return newRect;
}

//RightBottom
CGRect CGRectInsideRightBottom(CGRect rect, CGRect rectToRightBottomWith, CGFloat padding)
{
    CGRect newRect;
    //Inside
    newRect = CGRectChangingOrigin(rect,
                                   rectToRightBottomWith.origin.x + rectToRightBottomWith.size.width - rect.size.width,
                                   rectToRightBottomWith.origin.y + rectToRightBottomWith.size.height - rect.size.height
                                   );
    //Padding
    newRect = CGRectOffsetOrigin(newRect, -padding, -padding);
    
    return newRect;
}

//BottomCenter
CGRect CGRectInsideBottomCenter(CGRect rect, CGRect rectToBottomCenterWith, CGFloat padding)
{
    CGRect newRect;
    //Inside
    newRect = CGRectChangingOriginY(rect,
                                    rectToBottomCenterWith.origin.y + rectToBottomCenterWith.size.height - rect.size.height
                                    );
    //Center
    newRect = CGRectCenteredHorizontallyS(newRect, rectToBottomCenterWith);
    //Padding
    newRect = CGRectOffsetOriginY(newRect, -padding);
    
    return newRect;
}

//BottomLeft
CGRect CGRectInsideBottomLeft(CGRect rect, CGRect rectToBottomLeftWith, CGFloat padding)
{
    CGRect newRect;
    //Inside
    newRect = CGRectChangingOrigin(rect,
                                   rectToBottomLeftWith.origin.x,
                                   rectToBottomLeftWith.origin.y + rectToBottomLeftWith.size.height - rect.size.height
                                   );
    //Padding
    newRect = CGRectOffsetOrigin(newRect, padding, -padding);
    
    return newRect;
}

//LeftCenter
CGRect CGRectInsideLeftCenter(CGRect rect, CGRect rectToLeftCenterWith, CGFloat padding)
{
    CGRect newRect;
    //Inside
    newRect = CGRectChangingOriginX(rect,
                                    rectToLeftCenterWith.origin.x
                                    );
    //Center
    newRect = CGRectCenteredVerticallyS(newRect, rectToLeftCenterWith);
    //Padding
    newRect = CGRectOffsetOriginX(newRect, padding);
    
    return newRect;
}


#pragma mark - CGRect Relative Outside
//TopCenter
CGRect CGRectOutsideTopCenter(CGRect rect, CGRect rectToTopCenterWith, CGFloat padding)
{
    CGRect newRect;
    //Inside Top Center
    newRect = CGRectInsideTopCenter(rect, rectToTopCenterWith, 0.0f);
    //Offset to position above rectToTopCenterWith + Padding
    newRect = CGRectOffsetOriginY(newRect, -(rect.size.height + padding));
    
    return newRect;
}

//RightCenter
CGRect CGRectOutsideRightCenter(CGRect rect, CGRect rectToRightCenterWith, CGFloat padding)
{
    CGRect newRect;
    //Inside Right Center
    newRect = CGRectInsideRightCenter(rect, rectToRightCenterWith, 0.0f);
    //Offset to position right beside rectToRightCenterWith + Padding
    newRect = CGRectOffsetOriginX(newRect, (rect.size.width + padding));
    
    return newRect;
}

//BottomCenter
CGRect CGRectOutsideBottomCenter(CGRect rect, CGRect rectToBottomCenterWith, CGFloat padding)
{
    CGRect newRect;
    //Inside Bottom Center
    newRect = CGRectInsideBottomCenter(rect, rectToBottomCenterWith, 0.0f);
    //Offset to position below rectToBottomCenterWith + Padding
    newRect = CGRectOffsetOriginY(newRect, (rect.size.height + padding));
    
    return newRect;
}

//LeftCenter
CGRect CGRectOutsideLeftCenter(CGRect rect, CGRect rectToLeftCenterWith, CGFloat padding)
{
    CGRect newRect;
    //Inside Left Center
    newRect = CGRectInsideLeftCenter(rect, rectToLeftCenterWith, 0.0f);
    //Offset to position left beside rectToLeftCenterWith + Padding
    newRect = CGRectOffsetOriginX(newRect, -(rect.size.width + padding));
    
    return newRect;
}


#pragma mark - CGRect Relative With Points
//Above
CGRect CGRectAbovePointY(CGRect rect, CGFloat pointY)
{
    return CGRectChangingOriginY(rect, pointY - rect.size.height);
}

@end
