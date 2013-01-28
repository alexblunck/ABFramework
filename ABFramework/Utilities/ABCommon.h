//
//  ABCommon.h
//  ABFramework
//
//  Created by Alexander Blunck on 8/27/12.
//  Copyright (c) 2012 Ablfx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ABCommon : NSObject

#pragma mark - NETWORK
+(BOOL) isOnWifiNetwork;

#pragma mark - URL 's
+(NSString *)urlEncodeUsingEncoding:(NSStringEncoding)encoding string:(NSString*)string;

#pragma mark - Toggle
+(BOOL) toggleBoolean:(BOOL)boolean;

#pragma mark - Key/Value
+(id) safeObjectForKey:(id)key from:(id)object imidate:(Class)class;

@end
