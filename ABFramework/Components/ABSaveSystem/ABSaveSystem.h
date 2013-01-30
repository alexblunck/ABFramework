//
//  ABSaveSystem.h
//  ABFramework
//
//  Created by Alexander Blunck on 11/11/12.
//  Copyright (c) 2012 Ablfx. All rights reserved.
//

#import <Foundation/Foundation.h>

#define APPNAME @"APPNAME_GOES_HERE"
#define OS @"IOS" /* @"IOS" for iPhone/iPad/iPod & @"MAC" for mac */
#define ENCRYPTION_ENABLED NO
#define AESKEY @"aVt7G67Dgjit2"

@interface ABSaveSystem : NSObject

//NSInteger
+(void) saveInteger:(NSInteger)integer key:(NSString*)key;
+(NSInteger) integerForKey:(NSString*)key;

//BOOL
+(void) saveBool:(BOOL)boolean key:(NSString*)key;
+(BOOL) boolForKey:(NSString*)key;

//NSDate
+(void) saveDate:(NSDate*)date key:(NSString*)key;
+(NSDate*) dateForKey:(NSString*)key;

//Misc
+(void) logSavedValues;

@end
