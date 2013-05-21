//
//  NSApplication+ABFramework.h
//  ABFramework-Examples-Mac
//
//  Created by Alexander Blunck on 5/19/13.
//  Copyright (c) 2013 Alexander Blunck. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NSApplication (ABFramework)

//Info
/**
 * com.ablfx.appName
 */
+(NSString*) bundleIdentifier;

/**
 * ../../appName.app
 */
+(NSURL*) applicationURL;

/**
 * Alexander's MacBook Pro
 */
+(NSString*) deviceName;

/**
 * 
 */
+(NSString*) hostName;


//Launch At Login
+(BOOL) launchesAtLogin;
+(void) setToLaunchAtLogin:(BOOL)launch;

@end
