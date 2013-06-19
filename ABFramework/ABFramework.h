//
//  ABFramework.h
//  ABFramework
//
//  Created by Alexander Blunck on 9/5/12.
//  Copyright (c) 2012 Ablfx. All rights reserved.
//
#import <Availability.h>

#define ABFRAMEWORK_VERSION 0.1.0
#define ABFRAMEWORK_LAST_EDIT @"19.06.2013 - 10:20"

#ifndef ABFRAMEWORK_LOGGING
#define ABFRAMEWORK_LOGGING 1
#endif

/**
 * Multi
 */
#import "ABFrameworkMulti.h"

/**
 * iOS
 */
#if TARGET_OS_IPHONE
#define ABFRAMEWORK_IOS
#import "ABFrameworkIOS.h"

/**
 * Mac
 */
#else
#define ABFRAMEWORK_MAC
#import "ABFrameworkMac.h"
#endif





