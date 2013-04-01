//
//  ABNewsstandHelper.h
//  ABFramework
//
//  Created by Alexander Blunck on 3/16/13.
//  Copyright (c) 2013 Ablfx. All rights reserved.
//

#ifdef ABFRAMEWORK_NEWSSTAND

#import <Foundation/Foundation.h>

typedef void (^ABNewsstandHelperBlockProgress) (NSInteger percent, NKIssue *issue);
typedef void (^ABNewsstandHelperBlockCompletion) (BOOL connectionError, BOOL issueExists, NKIssue *issue, NSString *localAssetPath);

@interface ABNewsstandHelper : NSObject

//Singleton
+(id) sharedHelper;

//Setup
/**
 * Add a host name with this method to support self signed SSL certificates, if you are using an https connection to download issues
 * Example: "api.ablfx.com"
 */
-(void) addTrustedHost:(NSString*)host;

//State
-(BOOL) isDownloading;

//Issues
-(void) addIssue:(NSString*)issueName date:(NSDate*)date;
-(void) removeIssue:(NSString*)issueName;

//Download
-(void) downloadIssue:(NSString*)issueName
             assetUrl:(NSString*)assetUrl
              postDic:(NSDictionary*)postDic
        progressBlock:(ABNewsstandHelperBlockProgress)pBlock
      completionBlock:(ABNewsstandHelperBlockCompletion)cBlock;

/**
 * Call this method in the AppDelegate to process / continue any qeued downloads
 */
-(void) resumeAllDownloadsWithProgressBlock:(ABNewsstandHelperBlockProgress)pBlock
                            completionBlock:(ABNewsstandHelperBlockCompletion)cBlock;

/**
 * Method to process a push notification that is suppsed to iniate a background download
 * Expect following payload
 *
 * "content-available" = 1;
 * "issue_name" = "1";
 * "payload_url" = "http://domain.com/issue.zip";
 */
-(void) processApplicationLaunchOptionsOrNotificationUserInfo:(NSDictionary*)info
                                                      postDic:(NSDictionary*)postDic
                                              completionBlock:(ABNewsstandHelperBlockCompletion)cBlock;

@end

#endif
