//
//  UIImage+ABFramework.m
//  ABFramework
//
//  Created by Alexander Blunck on 10/23/12.
//  Copyright (c) 2012 Ablfx. All rights reserved.
//

#import "UIImage+ABFramework.h"

@implementation UIImage (ABFramework)

#pragma mark - Save / Load / Delete
-(void) saveImage:(NSString*)imageName
{
    //Convert image into .png format
    NSData *imageData = UIImagePNGRepresentation(self);
    //Create instance of NSFileManager
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //Create an array and store result of our search for the documents directory in it
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //Create NSString object, that holds our exact path to the documents directory
    NSString *documentsDirectory = [paths safeObjectAtIndex:0];
    //Add our image to the path
    NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png", imageName]];
    //Finally save the path (image)
    [fileManager createFileAtPath:fullPath contents:imageData attributes:nil]; 
}

+(void) removeImage:(NSString*)fileName
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths safeObjectAtIndex:0];
    NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png", fileName]];
    [fileManager removeItemAtPath: fullPath error:NULL];
}

+(UIImage*) loadImage:(NSString*)imageName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths safeObjectAtIndex:0];
    NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png", imageName]];
    return [UIImage imageWithContentsOfFile:fullPath];
}



#pragma mark - Resize
-(UIImage*) resizedImageWithMaxSize:(CGSize)maxSize
{
    return [self resizedImageWithMaxSize:maxSize compression:1.0f];
}

-(UIImage*) resizedImageWithMaxSize:(CGSize)maxSize compression:(CGFloat)compression
{
    float actualHeight = self.size.height;
    float actualWidth = self.size.width;
    float imgRatio = actualWidth/actualHeight;
    float maxRatio = maxSize.width/maxSize.height;
    
    if(imgRatio!=maxRatio){
        if(imgRatio < maxRatio){
            imgRatio = maxSize.height / actualHeight;
            actualWidth = imgRatio * actualWidth;
            actualHeight = maxSize.height;
        }
        else{
            imgRatio = maxSize.width / actualWidth;
            actualHeight = imgRatio * actualHeight;
            actualWidth = maxSize.width;
        }
    }
    CGRect rect = CGRectMake(0.0, 0.0, actualWidth, actualHeight);
    UIGraphicsBeginImageContext(rect.size);
    [self drawInRect:rect];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    if (compression > 1.0f)
    {
        compression = 1.0f;
    }
    
    return [UIImage imageWithData:UIImageJPEGRepresentation(img, compression)];
}


#pragma mark - Info
+(CGSize) sizeForImageName:(NSString*)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    CGSize size = image.size;
    image = nil;
    return size;
}

@end
