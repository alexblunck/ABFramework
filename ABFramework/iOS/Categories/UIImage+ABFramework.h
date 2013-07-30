//
//  UIImage+ABFramework.h
//  ABFramework
//
//  Created by Alexander Blunck on 10/23/12.
//  Copyright (c) 2012 Ablfx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ABFramework)

//Save / Load / Delete
-(void) saveImage:(NSString*)imageName;
+(UIImage*) loadImage:(NSString*)fileName;
+(void) removeImage:(NSString*)fileName;

//Resize
-(UIImage*) resizedImageWithMaxSize:(CGSize)maxSize;
-(UIImage*) resizedImageWithMaxSize:(CGSize)maxSize compression:(CGFloat)compression;

//Info
+(CGSize) sizeForImageName:(NSString*)imageName;

//Blur
-(UIImage*) applyBlurWithRadius:(CGFloat)blurRadius
                      tintColor:(UIColor*)tintColor
          saturationDeltaFactor:(CGFloat)saturationDeltaFactor
                      maskImage:(UIImage*)maskImage;

//Color
+(instancetype) imageWithColor:(UIColor*)color size:(CGSize)size;

@end
