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

#pragma mark - NSNumber Fast Creation
NSNumber* NSNumberInteger(NSInteger aInteger)
{
    return [NSNumber numberWithInteger:aInteger];
}

NSNumber* NSNumberDouble(double aDouble)
{
    return [NSNumber numberWithDouble:aDouble];
}

NSNumber* NSNumberFloat(CGFloat aFloat)
{
    return [NSNumber numberWithFloat:aFloat];
}

NSNumber* NSNumberBOOL(BOOL aBoolean)
{
    return [NSNumber numberWithBool:aBoolean];
}


#pragma mark - Type Checking
BOOL isNSArray(id object)
{
    return isClassOfType(object, [NSArray class]);
}

BOOL isNSDictionary(id object)
{
    return isClassOfType(object, [NSDictionary class]);
}

BOOL isClassOfType(id object, Class aClass)
{
    if ([object isKindOfClass:aClass])
    {
        return YES;
    }
    return NO;
}


#pragma mark - Networking
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

@end
