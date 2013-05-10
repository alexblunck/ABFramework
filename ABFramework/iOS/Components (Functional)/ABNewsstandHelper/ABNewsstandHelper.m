//
//  ABNewsstandHelper.m
//  ABFramework
//
//  Created by Alexander Blunck on 3/16/13.
//  Copyright (c) 2013 Ablfx. All rights reserved.
//

#import "ABNewsstandHelper.h"

@interface ABNewsstandHelper () <NSURLConnectionDelegate, NSURLConnectionDownloadDelegate>
{
    NSMutableArray *_trustedHosts;
    
    ABNewsstandHelperBlockProgress _issueDownloadProgressBlock;
    ABNewsstandHelperBlockCompletion _issueDownloadCompletionBlock;
}

@end

@implementation ABNewsstandHelper

#pragma mark - Singleton
+(id) sharedHelper
{
    static ABNewsstandHelper *sharedHelper = nil;
    static dispatch_once_t once = 0;
    dispatch_once(&once, ^{sharedHelper = [[self alloc] init];});
    return sharedHelper;
}

#pragma mark - Initializer
-(id) init
{
    self = [super init];
    if (self)
    {
        _trustedHosts = [NSMutableArray new];
    }
    return self;
}



#pragma mark - Setup
-(void) addTrustedHost:(NSString*)host
{
    [_trustedHosts addObject:host];
}



#pragma mark - State
-(BOOL) isDownloading
{
    NSArray *downloads = [[NKLibrary sharedLibrary] downloadingAssets];
    return (downloads.count != 0) ? YES : NO;
}



#pragma mark - Issues
-(BOOL) issueExists:(NSString*)issueName
{
    NKIssue *issue = [[NKLibrary sharedLibrary] issueWithName:issueName];
    return (issue) ? YES : NO;
}

-(void) addIssue:(NSString*)issueName date:(NSDate*)date
{
    if (![self issueExists:issueName])
    {
        [[NKLibrary sharedLibrary] addIssueWithName:issueName date:date];
    }
}

-(void) removeIssue:(NSString*)issueName
{
    NKIssue *issue = [[NKLibrary sharedLibrary] issueWithName:issueName];
    if (issue)
    {
        [[NKLibrary sharedLibrary] removeIssue:issue];
    }
}



#pragma mark - Download
-(void) downloadIssue:(NSString*)issueName
             assetUrl:(NSString*)assetUrl
              postDic:(NSDictionary*)postDic
        progressBlock:(ABNewsstandHelperBlockProgress)pBlock
      completionBlock:(ABNewsstandHelperBlockCompletion)cBlock
{
    NKIssue *issue = [[NKLibrary sharedLibrary] issueWithName:issueName];
    if (issue)
    {
        _issueDownloadCompletionBlock = [cBlock copy];
        _issueDownloadProgressBlock = [pBlock copy];
        
        //NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:assetUrl]];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:assetUrl]];
        
        if (postDic != nil)
        {
            //Turn postDic into string
            NSString *requestBody = [postDic httpBodyString];
            
            //Create/Add HTTP Body to request
            NSData *requestData = [NSData dataWithBytes:[requestBody UTF8String] length:[requestBody length]];
            [request setHTTPBody:requestData];
            [request setHTTPMethod:@"POST"];
        }
         
        NKAssetDownload *assetDownload = [issue addAssetWithRequest:request];
        
        [assetDownload downloadWithDelegate:self];
    }
    else
    {
        if (cBlock)
        {
            cBlock(NO, NO, nil, nil);
        }
    }
    
}

-(void) resumeAllDownloadsWithProgressBlock:(ABNewsstandHelperBlockProgress)pBlock
                            completionBlock:(ABNewsstandHelperBlockCompletion)cBlock
{
    _issueDownloadProgressBlock = [pBlock copy];
    _issueDownloadCompletionBlock = [cBlock copy];
    
    NSArray *downloads = [[NKLibrary sharedLibrary] downloadingAssets];
    for (NKAssetDownload *download in downloads)
    {
        [download downloadWithDelegate:self];
    }
}

-(void) processApplicationLaunchOptionsOrNotificationUserInfo:(NSDictionary*)info
                                                    postDic:(NSDictionary*)postDic
                                            completionBlock:(ABNewsstandHelperBlockCompletion)cBlock
{
    //"aps" key contains the push notification payload
    //App Launched while in background/foreground: "didReceiveRemoteNotification" in AppDelegate is called with "aps" key on parent level
    //                App Launched while inactive: "didLaunchWithOptions" in AppDeleagte is called with "aps" key as a child of "UIApplicationLaunchOptionsRemoteNotificationKey" key
    NSDictionary *aps = nil;
    NSDictionary *payload = [info objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    if (payload)
    {
        aps = [payload objectForKey:@"aps"];
    }
    else if ([info objectForKey:@"aps"])
    {
        aps = [info objectForKey:@"aps"];
    }
    
    if (aps)
    {
        [self downloadIssue:[aps objectForKey:@"issue_name"]
                   assetUrl:[aps objectForKey:@"payload_url"]
                    postDic:postDic
              progressBlock:nil
            completionBlock:cBlock];
    }
}



#pragma mark - Helper
-(NKIssue*) issueForConnection:(NSURLConnection*)connection
{
    NKAssetDownload *assetDownload = connection.newsstandAssetDownload;
    NKIssue *issue = assetDownload.issue;
    return issue;
}



#pragma mark - NSURLConnectionDelegate
-(void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    //Execute Block
    if (_issueDownloadCompletionBlock)
    {
        _issueDownloadCompletionBlock(YES, YES, [self issueForConnection:connection], nil);
    }
    
    //Remove blocks if everything has finished downloading
    if (![self isDownloading])
    {
        _issueDownloadCompletionBlock = nil;
        _issueDownloadProgressBlock = nil;
    }
}

//Self signed SSL certificate support
- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace
{
    return [protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust];
}
- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{    
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust])
    {
        if ([_trustedHosts containsObject:challenge.protectionSpace.host])
        {
            [challenge.sender useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust] forAuthenticationChallenge:challenge];
        }
    }
        
    [challenge.sender continueWithoutCredentialForAuthenticationChallenge:challenge];
}



#pragma mark - NSURLConnectionDownloadDelegate
-(void) connection:(NSURLConnection *)connection didWriteData:(long long)bytesWritten totalBytesWritten:(long long)totalBytesWritten expectedTotalBytes:(long long)expectedTotalBytes
{
    NKAssetDownload *assetDownload = connection.newsstandAssetDownload;
    NKIssue *issue = assetDownload.issue;
    
    if (_issueDownloadProgressBlock)
    {
         _issueDownloadProgressBlock(ABMathPercent(totalBytesWritten, expectedTotalBytes), issue);
    }
}

-(void) connectionDidResumeDownloading:(NSURLConnection *)connection totalBytesWritten:(long long)totalBytesWritten expectedTotalBytes:(long long)expectedTotalBytes
{
    NKAssetDownload *assetDownload = connection.newsstandAssetDownload;
    NKIssue *issue = assetDownload.issue;
    
    if (_issueDownloadProgressBlock)
    {
        _issueDownloadProgressBlock(ABMathPercent(totalBytesWritten, expectedTotalBytes), issue);
    }
}

-(void) connectionDidFinishDownloading:(NSURLConnection *)connection destinationURL:(NSURL *)destinationURL
{
    NKAssetDownload *assetDownload = connection.newsstandAssetDownload;
    NKIssue *issue = assetDownload.issue;
    
    //Execute Block
    if (_issueDownloadCompletionBlock)
    {
        _issueDownloadCompletionBlock(NO, YES, issue, [destinationURL path]);
    }
    
    //Remove blocks if everything has finished downloading
    if (![self isDownloading])
    {
        _issueDownloadCompletionBlock = nil;
        _issueDownloadProgressBlock = nil;
    }
}

@end
