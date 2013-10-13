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

#ifndef ABSAVESYSTEM_VERBOSE_LOGGING
    #define ABSAVESYSTEM_VERBOSE_LOGGING 0
#endif

#ifndef ABSAVESYSTEM_ENCRYPTION_ENABLED
    #define ABSAVESYSTEM_ENCRYPTION_ENABLED NO
#endif

#ifndef ABSAVESYSTEM_AESKEY
    #define ABSAVESYSTEM_AESKEY @"aVt7G67Dgjit2"
#endif

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
+(BOOL) exists:(NSString*)key;
+(BOOL) exists:(NSString*)key encryption:(BOOL)encryption;
+(void) logSavedValues:(BOOL)encrypted;
+(void) truncate; //Deletes everything
+(void) removeValueForKey:(NSString*)key;
+(void) removeValueForKey:(NSString*)key encryption:(BOOL)encryption;

@end
