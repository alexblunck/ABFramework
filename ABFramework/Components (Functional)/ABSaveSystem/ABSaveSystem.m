//
//  ABSaveSystem.m
//  ABFramework
//
//  Created by Alexander Blunck on 11/11/12.
//  Copyright (c) 2012 Ablfx. All rights reserved.
//

#import "ABSaveSystem.h"

@implementation ABSaveSystem

#pragma mark - Helper
+(NSString*) appName
{
    NSString *bundlePath = [[[NSBundle mainBundle] bundleURL] lastPathComponent];
    return [bundlePath stringByDeletingPathExtension];
}

+(ABSaveSystemOS) os
{
#if TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR
    return ABSaveSystemOSIOS;
#else
    return ABSaveSystemOSMacOSX;
#endif
}

+(NSString*) filePath
{
    ABSaveSystemOS os = [self os];
    
    NSString *fileName = [NSString stringWithFormat:@"%@.abss", [[self appName] lowercaseString]];
    
    if (os == ABSaveSystemOSIOS)
    {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *path = [documentsDirectory stringByAppendingPathComponent:fileName];
        return path;
    }
    else if (os == ABSaveSystemOSMacOSX)
    {
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSString *folderPath = [NSString stringWithFormat:@"~/Library/Application Support/%@/", [self appName]];
        folderPath = [folderPath stringByExpandingTildeInPath];
        if ([fileManager fileExistsAtPath:folderPath] == NO)
        {
            [fileManager createDirectoryAtPath:folderPath withIntermediateDirectories:NO attributes:nil error:nil];
        }
        return  [folderPath stringByAppendingPathComponent:fileName];
    }

    return nil;
}

+(NSMutableDictionary*) loadDictionary
{
    NSData *binaryFile = [NSData dataWithContentsOfFile:[self filePath]];
    
    if (binaryFile == nil) {
        return nil;
    }
    
    NSMutableDictionary *dictionary;
    //Either Decrypt saved data or just load it
    if (ENCRYPTION_ENABLED) {
        NSData *dataKey = [AESKEY dataUsingEncoding:NSUTF8StringEncoding];
        NSData *decryptedData = [binaryFile decryptedWithKey:dataKey];
        dictionary = [NSKeyedUnarchiver unarchiveObjectWithData:decryptedData];
    } else {
        dictionary = [NSKeyedUnarchiver unarchiveObjectWithData:binaryFile];
    }
    
    return dictionary;
}



#pragma mark - Objects
#pragma mark - NSData
+(void) saveData:(NSData*)data key:(NSString*)key
{
    //Check if file exits, if so init Dictionary with it's content, otherwise allocate new one
    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:[self filePath]];
    NSMutableDictionary *tempDic = nil;
    if (fileExists == NO) {
        tempDic = [[NSMutableDictionary alloc] init];
    } else {
        tempDic = [self loadDictionary];
    }
    
    //Populate Dictionary with to save value/key and write to file
    [tempDic setObject:data forKey:key];
    
    NSData *dicData = [NSKeyedArchiver archivedDataWithRootObject:tempDic];
    
    //Either encrypt Data or just save
    if (ENCRYPTION_ENABLED) {
        NSData *dataKey = [AESKEY dataUsingEncoding:NSUTF8StringEncoding];
        NSData *encryptedData = [dicData encryptedWithKey:dataKey];
        [encryptedData writeToFile:[self filePath] atomically:YES];
    } else {
        [dicData writeToFile:[self filePath] atomically:YES];
    }
    
}

+(NSData*) dataForKey:(NSString*)key
{
    NSMutableDictionary *tempDic = [self loadDictionary];
    
    //Retrieve NSData for specific key
    NSData *loadedData = [tempDic objectForKey:key];
    
    //Check if data exists for key
    if (loadedData != nil)
    {
        return loadedData;
    }
    else
    {
        NSLog(@"ABSaveSystem ERROR: objectForKey:\"%@\" -> object for key does not exist!", key);
    }
    return nil;
}


#pragma mark - Object
+(void) saveObject:(id)object key:(NSString*)key
{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:object];
    [self saveData:data key:key];
}

+(id) objectForKey:(NSString*)key checkClass:(Class)aClass
{
    NSData *data = [self dataForKey:key];
    if (data != nil)
    {
        //Check that the correct kind of class was retrieved from storage (skip check if class is not set)
        id object = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        if (aClass == nil || [object isKindOfClass:aClass])
        {
            return object;
        }
        else
        {
            NSLog(@"ABSaveSystem ERROR: objectForKey:\"%@\" -> saved object is %@ not a %@", key, [object class],  aClass);
        }
    }
    return nil;
}

+(id) objectForKey:(NSString*)key
{
    return [self objectForKey:key checkClass:nil];
}


#pragma mark - NSString
+(void) saveString:(NSString*)string key:(NSString*)key
{
    [self saveObject:string key:key];
}

+(NSString*) stringForKey:(NSString*)key
{
    return [self objectForKey:key checkClass:[NSString class]];
}


#pragma mark - NSNumber
+(void) saveNumber:(NSNumber*)number key:(NSString*)key
{
    [self saveObject:number key:key];
}

+(NSNumber*) numberForKey:(NSString*)key
{
    return [self objectForKey:key checkClass:[NSNumber class]];
}


#pragma mark - NSDate
+(void) saveDate:(NSDate*)date key:(NSString*)key
{
    [self saveObject:date key:key];
}

+(NSDate*) dateForKey:(NSString*)key
{
    return [self objectForKey:key checkClass:[NSDate class]];
}



#pragma mark - Primitives
#pragma mark - NSInteger
+(void) saveInteger:(NSInteger)integer key:(NSString*)key
{
    [self saveNumber:[NSNumber numberWithInteger:integer] key:key];
}

+(NSInteger) integerForKey:(NSString*)key
{
    NSNumber *number = [self numberForKey:key];
    if (number != nil) {
        return [number integerValue];
    }
    return 0;
}


#pragma mark - CGFloat
+(void) saveFloat:(CGFloat)aFloat key:(NSString*)key
{
    [self saveNumber:[NSNumber numberWithFloat:aFloat] key:key];
}

+(CGFloat) floatForKey:(NSString*)key
{
    NSNumber *number = [self numberForKey:key];
    if (number != nil) {
        return [number floatValue];
    }
    return 0.0f;
}


#pragma mark - BOOL
+(void) saveBool:(BOOL)boolean key:(NSString*)key
{
    [self saveNumber:[NSNumber numberWithBool:boolean] key:key];
}

+(BOOL) boolForKey:(NSString*)key
{
    NSNumber *number = [self numberForKey:key];
    if (number != nil) {
        return [number boolValue];
    }
    return NO;
}



#pragma mark - Misc
+(void) logSavedValues
{
    NSMutableDictionary *tempDic= [self loadDictionary];
    if (tempDic == nil) {
        NSLog(@"ABSaveSystem: logSavedValues -> NO DATA SAVED!");
        return;
    }
    
    NSLog(@"ABSaveSystem: logSavedValues -> START LOG");
    
    [tempDic enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop)
     {
         NSString *valueString = [NSKeyedUnarchiver unarchiveObjectWithData:obj];
         
         NSLog(@"ABSaveSystem: logSavedValues -> Key:%@ -> %@", key, valueString);
     }];
    
    NSLog(@"ABSaveSystem: logSavedValues -> END LOG");
}

@end
