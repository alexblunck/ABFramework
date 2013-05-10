//
//  ABTabButton.h
//  ABFramework
//
//  Created by Alexander Blunck on 9/7/12.
//  Copyright (c) 2012 Ablfx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ABTabButton : UIButton

@property (nonatomic, assign) int viewControllerIndex;
@property (nonatomic, strong) UIImageView *tabImageView;

@end
