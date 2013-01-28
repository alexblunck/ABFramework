//
//  ABTabBarItem.m
//  ABFramework
//
//  Created by Alexander Blunck on 9/7/12.
//  Copyright (c) 2012 Ablfx. All rights reserved.
//

#import "ABTabBarItem.h"

@implementation ABTabBarItem

-(id) initWithImage:(UIImage*)image selectedImage:(UIImage*)selectedImage {
    self = [super init];
    if (self) {
        
        self.image = image;
        self.selectedImage = selectedImage;
        
    } return self;
}

+(id) itemWithImage:(UIImage*)image selectedImage:(UIImage*)selectedImage {
    return [[self alloc] initWithImage:image selectedImage:selectedImage];
}

+(id) itemWithImageName:(NSString*)imageName selectedImageName:(NSString*)selectedImageName {
    UIImage *image = [UIImage imageNamed:imageName];
    UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
    return [self itemWithImage:image selectedImage:selectedImage];
}

@end
