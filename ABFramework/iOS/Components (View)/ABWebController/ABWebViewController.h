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
-(id) initWithUrl:(NSURL*)url;
-(id) initWithHTMLString:(NSString*)htmlString;

@property (nonatomic, copy) NSURL *url;
@property (nonatomic, copy) NSString *htmlString;

@property (nonatomic, strong, readonly) UIToolbar *tabbar;

@property (nonatomic, copy) ABBlockVoid wantsToDismissHandler;

//Config
@property (nonatomic, copy) NSString *navBarTitle;
@property (nonatomic, copy) UIColor *iconColor;
@property (nonatomic, assign) BOOL canRotate;
@property (nonatomic, assign) BOOL hideToolbar;

@end
