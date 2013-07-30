//
//  ABWebViewController.m
//  ABFramework
//
//  Created by Alexander Blunck on 7/23/13.
//  Copyright (c) 2013 Ablfx. All rights reserved.
//

#import "ABWebViewController.h"

@interface ABWebViewController () <UIWebViewDelegate>
{
    UIWebView *_webView;
}
@end

@implementation ABWebViewController

#pragma mark - Initializer
-(id) initWithUrlString:(NSString*)urlString
{
    self = [super init];
    if (self)
    {
        _url = [urlString url];
    }
    return self;
}



#pragma mark - LifeCycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self layout];
    
    self.url = self.url;
}



#pragma mark - Layout
-(void) layout
{
    _webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    _webView.delegate = self;
    [self.view addSubview:_webView];
    
    _tabbar = [[UIToolbar alloc] initWithFrame:cgr(0, 0, self.view.width, 49.0f)];
    _tabbar.frame = CGRectInsideBottomCenter(_tabbar.frame, self.view.bounds, 0);
    _tabbar.barStyle = self.navigationController.navigationBar.barStyle;
    _tabbar.translucent = YES;
    [self.view addSubview:_tabbar];
    
    _webView.scrollView.contentInset = UIEdgeInsetsMake(0, 0, _tabbar.height, 0);
    _webView.scrollView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, _webView.scrollView.contentInset.bottom, 0);
    
    //NavBar items
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTitle:@"Close" target:self action:@selector(dismiss)];
    
    //Tabbar items
    ABEntypoButton *refreshButton = [[ABEntypoButton alloc] initWithFrame:cgr(0, 0, 50.0f, _tabbar.height) iconName:@"cw" iconSize:30.0f];
    refreshButton.iconColor = self.iconColor;
    [refreshButton addTouchUpInsideTarget:self action:@selector(refreshButtonSelected)];
    UIBarButtonItem *refreshButtonItem = [refreshButton barButtonItem];
    
    _tabbar.items = @[refreshButtonItem];
}



#pragma mark - Buttons
-(void) dismiss
{
    if ([self wasPresented])
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
    if ([self wasPushed])
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void) refreshButtonSelected
{
    ABLogMethod();
}



#pragma mark - Accessors
-(void) setUrl:(NSURL *)url
{
    _url = url;
    
    [_webView loadRequest:[NSURLRequest requestWithURL:self.url]];
}

-(void) setNavBarTitle:(NSString *)navBarTitle
{
    _navBarTitle = navBarTitle;
    
    self.title = _navBarTitle;
}

@end
