//
//  ABNetworking.m
//  ABFramework
//
//  Created by Alexander Blunck on 4/1/13.
//  Copyright (c) 2013 Ablfx. All rights reserved.
//

#import "ABNetworking.h"

#define MAX_DOWNLOAD_MEM_BYTES 2621440

@interface ABNetworking () <NSURLConnectionDelegate, NSURLConnectionDataDelegate>
{
    ABNetworkingRequestType _requestType;
    
    ABBlockInteger _progress;
    ABNetworkingCompletionBlock _completion;
    
    NSString *_filePath;
    NSFileHandle *_fileHandle;
    
    long long _expectedTotalBytes;
    NSInteger _statusCode;
    NSDictionary *_responseHeader;
    
    NSMutableData *_data;
}
@end

@implementation ABNetworking

#pragma mark - Short
+(instancetype) get:(NSURL*)url completion:(ABNetworkingShortCallback)completion
{
    return [self jsonRequestWithUrl:url post:nil completion:^(id response, NSInteger statusCode, NSDictionary *header, ABNetworkingError error) {
        if (completion)
        {
            completion(response);
        }
    }];
}



#pragma mark - Untility
+(instancetype) httpRequestWithUrl:(NSURL*)url
                              post:(NSDictionary*)post
                        completion:(ABNetworkingCompletionBlock)completion
{
    return [[self alloc] initWithRequestUrl:url type:ABNetworkingRequestTypeHTTP postData:post progress:nil completion:completion];
}

+(instancetype) stringRequestWithUrl:(NSURL*)url
                                post:(NSDictionary*)post
                          completion:(ABNetworkingCompletionBlock)completion
{
    return [[self alloc] initWithRequestUrl:url type:ABNetworkingRequestTypeString postData:post progress:nil completion:completion];
}

+(instancetype) jsonRequestWithUrl:(NSURL*)url
                              post:(NSDictionary*)post
                        completion:(ABNetworkingCompletionBlock)completion
{
    return [[self alloc] initWithRequestUrl:url type:ABNetworkingRequestTypeJSON postData:post progress:nil completion:completion];
}

+(instancetype) downloadRequestWithUrl:(NSURL*)url
                                  post:(NSDictionary*)post
                              progress:(ABBlockInteger)progress
                            completion:(ABNetworkingCompletionBlock)completion
{
    return [[self alloc] initWithRequestUrl:url type:ABNetworkingRequestTypeDownload postData:post progress:progress completion:completion];
}



#pragma mark - Initializer
-(id) initWithRequestUrl:(NSURL*)url
                    type:(ABNetworkingRequestType)type
                postData:(NSDictionary*)postDic
                progress:(ABBlockInteger)pBlock
              completion:(ABNetworkingCompletionBlock)cBlock
{
    self = [super init];
    if (self)
    {
        _requestType = type;
        _progress = [pBlock copy];
        _completion = [cBlock copy];
        
        //Allocation
        _data = [[NSMutableData alloc] init];
        
        //Request
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
        request.timeoutInterval = 30.0f;
        request.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
        
        //POST body
        if (postDic != nil)
        {
            NSString *postBody = [postDic httpBodyString];
            NSData *postBodyData = [NSData dataWithBytes:[postBody UTF8String] length:[postBody length]];
            [request setHTTPMethod:@"POST"];
            [request setHTTPBody:postBodyData];
        }
        
        //Connection
        NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
        [connection start];
    }
    return self;
}



#pragma mark - Response
-(void) recievedData:(NSData*)data
{
    id response = nil;
    
    //HTTP (NSData)
    if (_requestType == ABNetworkingRequestTypeHTTP)
    {
        response = data;
    }
    //String (NSString)
    else if (_requestType == ABNetworkingRequestTypeString)
    {
        response = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    //JSON
    else if (_requestType == ABNetworkingRequestTypeJSON)
    {
        response = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    }
    //DOWNLOAD
    else if (_requestType == ABNetworkingRequestTypeDownload)
    {
        response = _filePath;
    }
    
    if (_completion)
    {
        _completion(response, _statusCode, _responseHeader, ABNetworkingErrorNone);
    }
}

-(void) connectionError:(NSError*)error
{
    if (ABFRAMEWORK_LOGGING) NSLog(@"ABNetworking: Error -> %@", error);
    
    if (_completion)
    {
        _completion(nil, 0, nil, ABNetworkingErrorConnection);
    }
}



#pragma mark - NSURLConnectionDelegate
- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace
{
    return [protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust];
}

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust])
    {
        if (ABNETWORKING_ALLOW_ALL_SSL_CERTIFICATES /*|| [self.trustedHosts containsObject:challenge.protectionSpace.host]*/)
        {
            [challenge.sender useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust] forAuthenticationChallenge:challenge];
        }
    }
    
    [challenge.sender continueWithoutCredentialForAuthenticationChallenge:challenge];
}

-(void)connection:(NSURLConnection*)connection didFailWithError:(NSError*)error
{
    [self connectionError:error];
}



#pragma mark - NSURLConnectionDataDelegate
-(void)connection:(NSURLConnection*)connection didReceiveResponse:(NSURLResponse*)response
{
    //File handle setup for download
    if (_requestType == ABNetworkingRequestTypeDownload)
    {
        //Create folder in "tmp" dir with unique name
        NSString *folderPath = [ABFileHelper createPath:[[ABFileHelper tempPath] stringByAppendingPathComponent:[NSString uniqueString]]];
        _filePath = [ABFileHelper createFile:[response suggestedFilename] atPath:folderPath];
        _fileHandle = [NSFileHandle fileHandleForUpdatingAtPath:_filePath];
    }
    
    _statusCode = [(NSHTTPURLResponse*)response statusCode];
    _responseHeader = [(NSHTTPURLResponse*)response allHeaderFields];
    _expectedTotalBytes = [response expectedContentLength];
}

-(void)connection:(NSURLConnection*)connection didReceiveData:(NSData*)data
{
    //Write download data to file handle
    if (_requestType == ABNetworkingRequestTypeDownload)
    {
        [_fileHandle writeData:data];
    }
    //Non download
    else
    {
        [_data appendData:data];
    }
    
    if (_progress)
    {
        long long totalBytesWritten = [_data length];
        _progress(ABMathPercent(totalBytesWritten, _expectedTotalBytes));
    }
}

-(void)connectionDidFinishLoading:(NSURLConnection*)connection
{
    [_fileHandle closeFile];
    
    [self recievedData:_data];
}

@end
