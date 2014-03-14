//
//  ABNetworking.h
//  ABFramework
//
//  Created by Alexander Blunck on 4/1/13.
//  Copyright (c) 2013 Ablfx. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef ABNETWORKING_ALLOW_ALL_SSL_CERTIFICATES
#define ABNETWORKING_ALLOW_ALL_SSL_CERTIFICATES 0
#endif

typedef enum {
    ABNetworkingErrorNone,
    ABNetworkingErrorConnection,
    ABNetworkingErrorEmptyResponse
} ABNetworkingError;

typedef enum {
    ABNetworkingRequestTypeNone,
    ABNetworkingRequestTypeHTTP,
    ABNetworkingRequestTypeJSON,
    ABNetworkingRequestTypeXML,
    ABNetworkingRequestTypeString,
    ABNetworkingRequestTypeDownload
} ABNetworkingRequestType;

typedef void (^ABNetworkingCompletionBlock) (id response, NSInteger statusCode, NSDictionary *header, ABNetworkingError error);
typedef void (^ABNetworkingShortCallback) (id response);

@interface ABNetworking : NSObject

// Short
+(instancetype) get:(NSURL*)url completion:(ABNetworkingShortCallback)completion;



// Utility
+(instancetype) httpRequestWithUrl:(NSURL*)url
                              post:(NSDictionary*)post
                        completion:(ABNetworkingCompletionBlock)completion;

+(instancetype) stringRequestWithUrl:(NSURL*)url
                                post:(NSDictionary*)post
                          completion:(ABNetworkingCompletionBlock)completion;

+(instancetype) jsonRequestWithUrl:(NSURL*)url
                              post:(NSDictionary*)post
                        completion:(ABNetworkingCompletionBlock)completion;

+(instancetype) downloadRequestWithUrl:(NSURL*)url
                                  post:(NSDictionary*)post
                              progress:(ABBlockInteger)progress
                            completion:(ABNetworkingCompletionBlock)completion;



//Properties
/**
 * If you're performing requests to a server using self signed SSL certificates,
 * add those hosts e.g. "api.ablfx.com" to the trustedHosts array
 */
//@property (nonatomic, strong) NSMutableArray *trustedHosts;

@end
