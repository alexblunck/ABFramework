//
//  UIImage+ABFramework.h
//  ABFramework
//
//  Created by Alexander Blunck on 10/23/12.
//  Copyright (c) 2012 Ablfx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ABFramework)

//SAVE - LOAD - DELETE
-(void)saveImage:(NSString*)imageName;
+(UIImage*)loadImage:(NSString*)imageName;
+(void)removeImage:(NSString*)fileName;

//RESIZE
-(UIImage*)resizedImageToSize:(CGSize)dstSize;
-(UIImage*)resizedImageToFitInSize:(CGSize)boundingSize scaleIfSmaller:(BOOL)scale;

@end
