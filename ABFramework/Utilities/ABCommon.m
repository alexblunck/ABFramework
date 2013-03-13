//
//  ABCommon.m
//  ABFramework
//
//  Created by Alexander Blunck on 8/27/12.
//  Copyright (c) 2012 Ablfx. All rights reserved.
//

#import "ABCommon.h"
#import "ABReachability.h"

@implementation ABCommon

#pragma mark - Network
+(BOOL) isOnWifiNetwork
{
    ABReachability *reachability = [ABReachability reachabilityForInternetConnection];
    [reachability startNotifier];
    NetworkStatus status = [reachability currentReachabilityStatus];
    if (status == ReachableViaWiFi) {
        return YES;
    }
    return NO;
    [reachability stopNotifier];
}



#pragma mark - Toggle
+(BOOL) toggleBoolean:(BOOL)boolean
{
    return (boolean) ? NO : YES;
}



#pragma mark - Key/Value
+(id) safeObjectForKey:(id)key from:(id)object imidate:(Class)class
{
    id returnObject = nil;
    
    if ([object objectForKey:key] != [NSNull null] && [object objectForKey:key] != nil) {
        returnObject = [object objectForKey:key];
    }
    
    else if (class != nil) {
        if (class == [NSString class]) {
            returnObject = [NSString string];
        }
    }
    
    return returnObject;
}

@end