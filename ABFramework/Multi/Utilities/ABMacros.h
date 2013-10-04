//
//  ABMacros.h
//  ABFramework
//
//  Created by Alexander Blunck on 1/12/13.
//  Copyright (c) 2013 Ablfx. All rights reserved.
//

/*
 * DEVICE
 */
//Returns YES on retina display
#define IS_RETINA_DISPLAY [[UIScreen mainScreen] respondsToSelector:@selector(scale)] && [[UIScreen mainScreen] scale] == 2.0f
//Returns YES on 4 inch display
#define IS_4_INCH ([[UIScreen mainScreen] applicationFrame].size.height > 480)
//Returns YES on device running at least / max iOS x
#define AB_SYSTEM_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
#define IS_MIN_IOS6 (AB_SYSTEM_VERSION >= 6.0f)
#define IS_MAX_IOS6X (AB_SYSTEM_VERSION < 7.0f)
#define IS_MIN_IOS7 (AB_SYSTEM_VERSION >= 7.0f)
//Returns YES on a device running a a specific major iOS version
#define IS_IOS6X (AB_SYSTEM_VERSION >= 6.0f && AB_SYSTEM_VERSION < 7.0f)
//Returns YES on iPad
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

//iOS 6 max
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 70000
    #define DEF_IS_MAX_IOS6
#endif

//iOS 6.X
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 70000 && __IPHONE_OS_VERSION_MIN_REQUIRED >= 6000
    #define DEF_IS_IOS6X
#endif

//iOS 5 Max
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 60000
    #define DEF_IS_MAX_IOS5
#endif




/*
 * LOGGING
 */
#define ABLogNSString(string) NSLog(@"ABLogNSString -> %s = \"%@\"", #string, string)
#define ABLogCGRect(rect) NSLog(@"ABLogCGRect -> %s = %@", #rect, NSStringFromCGRect(rect))
#define ABLogCGSize(size) NSLog(@"ABLogCGSize -> %s = %@", #size, NSStringFromCGSize(size))
#define ABLogCGPoint(point) NSLog(@"ABLogCGPoint -> %s = %@", #point, NSStringFromCGPoint(point))
#define ABLogBOOL(bool) NSLog(@"ABLogBOOL -> %s = %@", #bool, (bool) ? @"YES" : @"NO")
#define ABLogInteger(integer) NSLog(@"ABLogInteger -> %s = %i", #integer, integer)
#define ABLogDouble(double) NSLog(@"ABLogDouble -> %s = %f", #double, double)
#define ABLogFloat(float) NSLog(@"ABLogFloat -> %s = %f", #float, float)
#define ABLogLong(long) NSLog(@"ABLogFloat -> %s = %lu", #long, long)
#define ABLogLongLong(longLong) NSLog(@"ABLogFloat -> %s = %llu", #longLong, longLong)
#define ABLogMethod() NSLog(@"ABLogMethod -> %s", __PRETTY_FUNCTION__)
#define ABLogClass(object) NSLog(@"ABLogBOOL -> %s = %@", #object, NSStringFromClass([object class]))
