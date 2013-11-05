//
//  ABWebController.m
//  ABFramework
//
//  Created by Alexander Blunck on 7/23/13.
//  Copyright (c) 2013 Ablfx. All rights reserved.
//

#import "ABWebController.h"

@interface ABWebController ()
{
    ABWebViewController *_webViewController;
}
@end

@implementation ABWebController

#pragma mark - Utility
+(id) controllerWithUrlString:(NSString*)urlString
{
    return [self controllerWithUrl:[urlString url]];
}

+(id) controllerWithUrl:(NSURL*)url
{
    return [[self alloc] initWithUrl:url];
}



#pragma mark - Initializer
-(id) initWithUrl:(NSURL*)url
{
    ABWebViewController *webViewController = [[ABWebViewController alloc] initWithUrl:url];
    self = [super initWithRootViewController:webViewController];
    if (self)
    {
        _webViewController = webViewController;
    }
    return self;
}



#pragma mark - LifeCycle
- (void)viewDidLoad
{
    [super viewDidLoad];
}



#pragma mark - Style
-(void) imitateNavigationControllerStyle:(UINavigationController*)navigationController
{
    self.navigationBar.titleTextAttributes = navigationController.navigationBar.titleTextAttributes;
    self.navigationBar.barStyle = navigationController.navigationBar.barStyle;
    self.navigationBar.tintColor = navigationController.navigationBar.tintColor;
    self.navigationBar.translucent = navigationController.navigationBar.translucent;
}



#pragma mark - Accessors
-(void) setUrl:(NSURL *)url
{
    _url = url;
    [_webViewController setUrl:_url];
}

-(void) setNavBarTitle:(NSString *)navBarTitle
{
    _navBarTitle = navBarTitle;
    _webViewController.navBarTitle = _navBarTitle;
}

-(void) setIconColor:(UIColor *)iconColor
{
    _iconColor = iconColor;
    _webViewController.iconColor = _iconColor;
}

@end
