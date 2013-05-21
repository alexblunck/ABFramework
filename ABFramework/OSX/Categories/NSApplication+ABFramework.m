//
//  NSApplication+ABFramework.m
//  ABFramework
//
//  Created by Alexander Blunck on 5/19/13.
//  Copyright (c) 2013 Alexander Blunck. All rights reserved.
//

#import "NSApplication+ABFramework.h"

@implementation NSApplication (ABFramework)

#pragma mark - Info
+(NSString*) bundleIdentifier
{
    return [[NSBundle mainBundle] bundleIdentifier];
}

+(NSURL*) applicationURL
{
    return [NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]];
}

+(NSString*) deviceName
{
    return [[NSHost currentHost] localizedName];
}

+(NSString*) hostName
{
    return [[NSHost currentHost] name];
}



#pragma mark - Launch At Login
+(BOOL) launchesAtLogin
{
    return [self loginItemSet:NO enabled:NO];
}

+(void) setToLaunchAtLogin:(BOOL)launch
{
    [self loginItemSet:YES enabled:launch];
}

+(BOOL) loginItemSet:(BOOL)set enabled:(BOOL)enabled
{
    BOOL itemFound = NO;
    
    LSSharedFileListItemRef loginItem = nil;
    
    //Iterate through login items
    LSSharedFileListRef loginItems = LSSharedFileListCreate(nil, kLSSharedFileListSessionLoginItems, nil);
    NSArray *loginItemObjects = CFBridgingRelease(LSSharedFileListCopySnapshot(loginItems, (UInt32)0U));
    
    for (id loginItemObject in loginItemObjects)
    {
        LSSharedFileListItemRef item = (__bridge LSSharedFileListItemRef)loginItemObject;
        
        UInt32 flags = kLSSharedFileListNoUserInteraction|kLSSharedFileListDoNotMountVolumes;
        CFURLRef url = nil;
        OSStatus error = LSSharedFileListItemResolve(item, flags, &url, nil);
        
        if (error == noErr)
        {
            itemFound = CFEqual(url, (__bridge CFTypeRef)([self applicationURL]));
            CFRelease(url);
            
            if (itemFound)
            {
                loginItem = (__bridge LSSharedFileListItemRef)(loginItemObject);
            }
        }
    }
    
    //Insert
    if (set && enabled && !loginItem)
    {
        LSSharedFileListInsertItemURL(loginItems, kLSSharedFileListItemBeforeFirst, nil, nil, (__bridge CFURLRef)[self applicationURL], nil, nil);
    }
    
    //Remove
    else if (set && !enabled && loginItem)
    {
        LSSharedFileListItemRemove(loginItems, loginItem);
    }
    
    CFRelease(loginItems);
    
    return itemFound;
}

@end
