//
//  ABTabBarItem.h
//  ABFramework
//
//  Created by Alexander Blunck on 9/7/12.
//  Copyright (c) 2012 Ablfx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ABTabBarItem : NSObject

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) UIImage *selectedImage;
@property (nonatomic, assign) BOOL isDefaultTab;

//Utility Method's that return a ABTabBarItem
+(id) itemWithImage:(UIImage*)image selectedImage:(UIImage*)selectedImage;
+(id) itemWithImageName:(NSString*)imageName selectedImageName:(NSString*)selectedImageName;

@end
