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
    
    UIActivityIndicatorView *_activityView;
    
    UIBarButtonItem *_refreshButton;
    UIBarButtonItem *_cancelButton;
    UIBarButtonItem *_backButton;
    UIBarButtonItem *_forwardButton;
    UIBarButtonItem *_moreButton;
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
    
    if ([self wasPresented]) self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTitle:@"Close" target:self action:@selector(dismiss)];
    
    [self layout];
    
    self.url = self.url;
}



#pragma mark - Layout
-(void) layout
{
    //ActivityView
    UIActivityIndicatorViewStyle style = (self.navigationController.navigationBar.barStyle == UIBarStyleBlack) ? UIActivityIndicatorViewStyleWhiteLarge : UIActivityIndicatorViewStyleGray;
    
    _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:style];
    _activityView.hidesWhenStopped = YES;
    //_activityView.frame = CGRectInsideRightCenter(_activityView.frame, self.navigationController.navigationBar, <#CGFloat padding#>)
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_activityView];
    
    //WebView
    _webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    _webView.delegate = self;
    [self.view addSubview:_webView];
    
    //Tabbar
    _tabbar = [[UIToolbar alloc] initWithFrame:cgr(0, 0, self.view.width, 49.0f)];
    _tabbar.frame = CGRectInsideBottomCenter(_tabbar.frame, self.view.bounds, 0);
    _tabbar.barStyle = self.navigationController.navigationBar.barStyle;
    _tabbar.translucent = YES;
    [self.view addSubview:_tabbar];
    
    //WebView Config
    _webView.scrollView.contentInset = UIEdgeInsetsMake(0, 0, _tabbar.height, 0);
    _webView.scrollView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, _webView.scrollView.contentInset.bottom, 0);
    
    //Tabbar items
    UIColor *iconColor = (_tabbar.barStyle == UIBarStyleBlack || _tabbar.barStyle == UIBarStyleBlackTranslucent) ? [UIColor whiteColor] : [UIColor blackColor];
    
    ABEntypoButton *cancelEButton = [ABEntypoButton buttonWithIconName:@"cross" size:32.0f];
    cancelEButton.iconColor = iconColor;
    [cancelEButton addTouchUpInsideTarget:self action:@selector(cancelButtonSelected)];
    _cancelButton = [cancelEButton barButtonItem];
    
    ABEntypoButton *refreshEButton = [ABEntypoButton buttonWithIconName:@"cw" size:32.0f];
    refreshEButton.iconColor = iconColor;
    [refreshEButton addTouchUpInsideTarget:self action:@selector(refreshButtonSelected)];
    _refreshButton = [refreshEButton barButtonItem];
    
    ABEntypoButton *backEButton = [ABEntypoButton buttonWithIconName:@"chevron-thin-left" size:32.0f];
    backEButton.iconColor = iconColor;
    [backEButton addTouchUpInsideTarget:self action:@selector(backButtonSelected)];
    _backButton = [backEButton barButtonItem];
    
    ABEntypoButton *forwardEButton = [ABEntypoButton buttonWithIconName:@"chevron-thin-right" size:32.0f];
    forwardEButton.iconColor = iconColor;
    [forwardEButton addTouchUpInsideTarget:self action:@selector(forwardButtonSelected)];
    _forwardButton = [forwardEButton barButtonItem];
    
    ABEntypoButton *moreEButton = [ABEntypoButton buttonWithIconName:@"export" size:32.0f];
    moreEButton.iconColor = iconColor;
    [moreEButton addTouchUpInsideTarget:self action:@selector(moreButtonSelected)];
    _moreButton = [moreEButton barButtonItem];
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
    [_webView reload];
}

-(void) cancelButtonSelected
{
    [_webView stopLoading];
}

-(void) backButtonSelected
{
    [_webView goBack];
}

-(void) forwardButtonSelected
{
    [_webView goForward];
}

-(void) moreButtonSelected
{
    
}



#pragma mark - Helper
-(void) updateToolbarItems
{
    UIBarButtonItem *leftItem = (_webView.isLoading) ? _cancelButton : _refreshButton;
    
    NSArray *items = @[
                      [UIBarButtonItem flexibleSpace],
                      leftItem,
                      [UIBarButtonItem flexibleSpace],
                      _backButton,
                      _forwardButton,
                      [UIBarButtonItem flexibleSpace],
                      _moreButton,
                      [UIBarButtonItem flexibleSpace]
                      ];
    
    [self.tabbar setItems:items animated:YES];
    
    _backButton.enabled = _webView.canGoBack;
    _forwardButton.enabled = _webView.canGoForward;
    
    _backButton.customView.alpha = (_backButton.enabled) ? 1.0f : 0.4f;
    _forwardButton.customView.alpha = (_forwardButton.enabled) ? 1.0f : 0.4f;
}



#pragma mark - UIWebViewDelegate
-(void) webViewDidStartLoad:(UIWebView *)webView
{
    [_activityView startAnimating];
    [self updateToolbarItems];
}

-(void) webViewDidFinishLoad:(UIWebView *)webView
{
    [_activityView stopAnimating];
    [self updateToolbarItems];
}

-(void) webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [_activityView stopAnimating];
    [self updateToolbarItems];
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
