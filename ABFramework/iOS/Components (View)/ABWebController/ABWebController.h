//
//  ABWebController.h
//  ABFramework
//
//  Created by Alexander Blunck on 7/23/13.
//  Copyright (c) 2013 Ablfx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ABWebController : UINavigationController

//Utility
+(id) controllerWithUrlString:(NSString*)urlString;
+(id) controllerWithUrl:(NSURL*)url;

//Style
-(void) imitateNavigationControllerStyle:(UINavigationController*)navigationController;

@property (nonatomic, copy) NSURL *url;

//Config
@property (nonatomic, copy) NSString *navBarTitle;
@property (nonatomic, copy) UIColor *iconColor;

@end
