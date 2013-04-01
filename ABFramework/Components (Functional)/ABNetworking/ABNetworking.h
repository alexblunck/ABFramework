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

@interface ABNetworking : NSObject

//Utility
+(id) performHTTPRequestWithUrl:(NSString*)url
                         postData:(NSDictionary*)postDic
                       completion:(ABNetworkingCompletionBlock)cBlock;

+(id) performStringRequestWithUrl:(NSString*)url
                         postData:(NSDictionary*)postDic
                       completion:(ABNetworkingCompletionBlock)cBlock;

+(id) performJSONRequestWithUrl:(NSString*)url
                       postData:(NSDictionary*)postDic
                     completion:(ABNetworkingCompletionBlock)cBlock;

+(id) performDownloadRequestWithUrl:(NSString*)url
                           postData:(NSDictionary*)postDic
                           progress:(ABBlockInteger)pBlock
                         completion:(ABNetworkingCompletionBlock)cBlock;


//Properties
/**
 * If you're perforing requests to a server using self signed SSL certificates,
 * add those hosts e.g. "api.ablfx.com" to the trustedHosts array
 */
//@property (nonatomic, strong) NSMutableArray *trustedHosts;

@end
