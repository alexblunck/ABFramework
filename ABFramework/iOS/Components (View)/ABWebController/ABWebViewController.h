//
//  ABWebViewController.h
//  ABFramework
//
//  Created by Alexander Blunck on 7/23/13.
//  Copyright (c) 2013 Ablfx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ABWebViewController : UIViewController

//Initializer
-(id) initWithUrlString:(NSString*)urlString;

@property (nonatomic, copy) NSURL *url;

@property (nonatomic, strong, readonly) UIToolbar *tabbar;

//Config
@property (nonatomic, copy) NSString *navBarTitle;
@property (nonatomic, copy) UIColor *iconColor;

@end
