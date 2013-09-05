//
//  ABFileHelper.m
//  ABFramework
//
//  Created by Alexander Blunck on 3/09/13.
//  Copyright (c) 2013 Ablfx. All rights reserved.
//

#import "ABFileHelper.h"

@implementation ABFileHelper

#pragma mark - Paths
+(NSString*) documentsPath
{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

+(NSString*) tempPath
{
    NSURL *tempUrl = [NSURL fileURLWithPath:NSTemporaryDirectory() isDirectory:YES];
    return [tempUrl path];
}

+(NSString*) pathForPathInDocumentsFolder:(NSString*)folderPath
{
    return [NSString stringWithFormat:@"%@/%@", [self documentsPath], folderPath];
}

+(NSString*) pathForFile:(NSString*)fileName atPathInDocumentsFolder:(NSString*)folderPath
{
    return [NSString stringWithFormat:@"%@/%@/%@", [self documentsPath], folderPath, fileName];
}

+(NSString*) pathForFile:(NSString*)fileName atPath:(NSString*)folderPath
{
    return [NSString stringWithFormat:@"%@/%@", folderPath, fileName];
}



#pragma mark - Write
+(void) writeDataToFile:(NSData*)data fileName:(NSString*)fileName toPathInDocumentsFolder:(NSString*)folderPath
{
    [self writeDataToFile:data path:[self pathForFile:fileName atPathInDocumentsFolder:folderPath]];
}

+(void) writeDataToFile:(NSData*)data path:(NSString*)path
{
    [self createPath:[path stringByDeletingLastPathComponent]];
    
    [data writeToFile:path atomically:YES];
}

+(NSString*) createPath:(NSString*)path
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if (![fileManager fileExistsAtPath:path])
    {
        [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    return path;
}

+(NSString*) createFile:(NSString*)fileName atPath:(NSString*)folderPath;
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    //Create parent folders if neccessary
    [self createPath:folderPath];
    
    NSString *fullPath = [self pathForFile:fileName atPath:folderPath];
    
    //Delete existing file with same name
    [self deleteFileAtPath:fullPath];
    
    //Create new empty file
    [fileManager createFileAtPath:fullPath contents:nil attributes:nil];
    
    return fullPath;
}



#pragma mark - Move
+(void) movePath:(NSString*)aPath toPath:(NSString*)bPath
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if (![fileManager fileExistsAtPath:aPath]) {
        return;
    }
    
    if (![fileManager fileExistsAtPath:[bPath stringByDeletingLastPathComponent] isDirectory:YES])
    {
        [self createPath:[bPath stringByDeletingLastPathComponent]];
    }
    
    [fileManager moveItemAtPath:aPath toPath:bPath error:nil];
}



#pragma mark - Read
+(NSData*) dataFromFile:(NSString*)fileName atPathInDocumentsFolder:(NSString*)folderPath
{
    NSData *data = [[NSData alloc] initWithContentsOfFile:[self pathForFile:fileName atPathInDocumentsFolder:folderPath]];
    return data;
}

+(NSData*) dataFromFile:(NSString *)fileName atPath:(NSString*)folderPath
{
    NSData *data = [[NSData alloc] initWithContentsOfFile:[self pathForFile:fileName atPath:folderPath]];
    return data;
}



#pragma mark - Delete
+(void) deleteFileAtPath:(NSString*)filePath
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if ([fileManager fileExistsAtPath:filePath])
    {
        [fileManager removeItemAtPath:filePath error:nil];
    }
}

+(void) deleteFile:(NSString*)fileName atPathInDocumentsFolder:(NSString*)folderPath
{
    NSString *filePath = [self pathForFile:fileName atPathInDocumentsFolder:folderPath];
    
    [self deleteFileAtPath:filePath];
}

+(void) deleteAllFilesAtFolderPath:(NSString*)folderPath
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error = nil; 
    NSArray *dirFilePaths = [fileManager contentsOfDirectoryAtPath:folderPath error:&error];
    if (error == nil)
    {
        for (NSString *filePath in dirFilePaths)
        {
            NSString *fullPath = [folderPath stringByAppendingPathComponent:filePath];
            [fileManager removeItemAtPath:fullPath error:nil];
        }
   }
}



#pragma mark - Rename
+(void) renameFileAtPath:(NSString*)filePath newName:(NSString*)newName
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if (![fileManager fileExistsAtPath:filePath]) {
        return;
    }
    
    NSString *toPath = [[filePath stringByDeletingLastPathComponent] stringByAppendingPathComponent:newName];
    
    [fileManager moveItemAtPath:filePath toPath:toPath error:nil];
}



#pragma mark - Exists
+(BOOL) fileExistsAtPath:(NSString*)filePath
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager fileExistsAtPath:filePath];
}


@end
