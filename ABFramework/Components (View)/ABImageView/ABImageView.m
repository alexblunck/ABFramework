//
//  ABImageView.m
//  ComingUp iOS
//
//  Created by Alexander Blunck on 3/10/13.
//  Copyright (c) 2013 Ablfx. All rights reserved.
//

#import "ABImageView.h"

@implementation ABImageView

#pragma mark - Utility
+(id) imageViewWithImageName:(NSString*)imageName
{
    return [[self alloc] initWithImage:[UIImage imageNamed:imageName]];
}

@end
