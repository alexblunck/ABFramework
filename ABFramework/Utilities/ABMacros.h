//
//  ABMacros.h
//  ABFramework
//
//  Created by Alexander Blunck on 1/12/13.
//  Copyright (c) 2013 Ablfx. All rights reserved.
//

/*
DEVICE 
*/
//Returns YES on retina display
#define IS_RETINA_DISPLAY() [[UIScreen mainScreen] respondsToSelector:@selector(scale)] && [[UIScreen mainScreen] scale] == 2.0f
//Returns YES on 4 inch display
#define IS_4_INCH() ([[UIScreen mainScreen] applicationFrame].size.height > 480)
//Returns YES on device running iOS 6.0+
#define IS_IOS6 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0f)
//Returns YES on iPad
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)




/*
LOGGING
*/
#define ABLogNSString(string) NSLog(@"ABLogNSString -> %s = \"%@\"", #string, string)
#define ABLogCGRect(rect) NSLog(@"ABLogCGRect -> %s -> %@", #rect, NSStringFromCGRect(rect))
#define ABLogBOOL(bool) NSLog(@"ABLogBOOL -> %s -> %@", #bool, (bool) ? @"YES" : @"NO")