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
CGRect
*/
//CGRect for one CGRect centered in another
CGRect CGRectCenteredInCGRect (CGRect rect, CGRect rectToCenterIn);
//CGRect for one CGRect centered horizontally in another
CGRect CGRectCenteredHorizontally(CGRect rect, CGRect rectToCenterIn, CGFloat originY);
//CGRect for one CGRect centered vertically in another
CGRect CGRectCenteredVertically(CGRect rect, CGRect rectToCenterIn, CGFloat originX);
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

//Returns zeroed CGRect for an imageName (located in bundle)
+(CGRect) frameForImageName:(NSString*)imageName;

@end
