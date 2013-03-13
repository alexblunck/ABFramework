//
//  ABSaveSystem.h
//  ABFramework
//
//  Created by Alexander Blunck on 11/11/12.
//  Copyright (c) 2012 Ablfx. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef ABSAVESYSTEM_LOGGING
#define ABSAVESYSTEM_LOGGING 1
#endif

#define ENCRYPTION_ENABLED NO
#define AESKEY @"aVt7G67Dgjit2"

typedef enum {
    ABSaveSystemOSNone,
    ABSaveSystemOSMacOSX,
    ABSaveSystemOSIOS
} ABSaveSystemOS;

@interface ABSaveSystem : NSObject

//
//Objects
//

//NSData (Encryption selectable)
+(void) saveData:(NSData*)data key:(NSString*)key encryption:(BOOL)encryption;
+(NSData*) dataForKey:(NSString*)key encryption:(BOOL)encryption;
//NSData (Use "ENCRYPTION_ENABLED" setting)
+(void) saveData:(NSData*)data key:(NSString*)key;
+(NSData*) dataForKey:(NSString*)key;

//Object
+(void) saveObject:(id<NSCoding>)object key:(NSString*)key;
+(id) objectForKey:(NSString*)key;

//NSString
+(void) saveString:(NSString*)string key:(NSString*)key;
+(NSString*) stringForKey:(NSString*)key;

//NSNumber
+(void) saveNumber:(NSNumber*)number key:(NSString*)key;
+(NSNumber*) numberForKey:(NSString*)key;

//NSDate
+(void) saveDate:(NSDate*)date key:(NSString*)key;
+(NSDate*) dateForKey:(NSString*)key;



//
//Primitives
//

//NSInteger
+(void) saveInteger:(NSInteger)integer key:(NSString*)key;
+(NSInteger) integerForKey:(NSString*)key;

//CGFloat
+(void) saveFloat:(CGFloat)aFloat key:(NSString*)key;
+(CGFloat) floatForKey:(NSString*)key;

//BOOL
+(void) saveBool:(BOOL)boolean key:(NSString*)key;
+(BOOL) boolForKey:(NSString*)key;



//
//Misc
//

+(void) logSavedValues:(BOOL)encrypted;

@end
