//
//  ABSaveSystem.m
//  ABFramework
//
//  Created by Alexander Blunck on 11/11/12.
//  Copyright (c) 2012 Ablfx. All rights reserved.
//

#import "ABSaveSystem.h"

@implementation ABSaveSystem

#pragma mark - Path
+(NSString*) filePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *fullFileName = [NSString stringWithFormat:@"%@.absave", APPNAME];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:fullFileName];
    NSString *filePath = path;
    return filePath;
}



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

+(NSMutableDictionary*) loadDictionary
{
    NSData *binaryFile = [NSData dataWithContentsOfFile:[self filePath]];
    
    if (binaryFile == NULL) {
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

+(NSData*) dataForKey:(NSString*)key
{
    NSMutableDictionary *tempDic = [self loadDictionary];
    
    //Get NSData for specific key
    NSData *loadedData = [tempDic objectForKey:key];
    return loadedData;
}



#pragma mark - NSInteger
+(void) saveInteger:(NSInteger)integer key:(NSString*)key
{
    NSNumber *object = [NSNumber numberWithInteger:integer];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:object];
    [self saveData:data key:key];
}

+(NSInteger) integerForKey:(NSString*)key
{
    NSData *data = [self dataForKey:key];
    if (data != nil) {
        NSNumber *object = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        return [object integerValue];
    }
    return 0;
}



#pragma mark - BOOL
+(void) saveBool:(BOOL)boolean key:(NSString*)key
{
    NSNumber *object = [NSNumber numberWithBool:boolean];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:object];
    [self saveData:data key:key];
}

+(BOOL) boolForKey:(NSString*)key
{
    NSData *data = [self dataForKey:key];
    if (data != nil) {
        NSNumber *object = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        return [object boolValue];
    }
    return NO;
}



#pragma mark - NSDate
+(void) saveDate:(NSDate*)date key:(NSString*)key
{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:date];
    [self saveData:data key:key];
}

+(NSDate*) dateForKey:(NSString*)key
{
    NSData *data = [self dataForKey:key];
    if (data != nil) {
        NSDate *date = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        return date;
    }
    return nil;
}



#pragma mark - NSNumber
+(void) saveNumber:(NSNumber*)number key:(NSString*)key
{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:number];
    [self saveData:data key:key];
}

+(NSNumber*) numberForKey:(NSString*)key
{
    NSData *data = [self dataForKey:key];
    if (data != nil) {
        NSNumber *number = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        return number;
    }
    return nil;
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
