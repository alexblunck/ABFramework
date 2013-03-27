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
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSString *pathWithoutFileName = [path stringByDeletingLastPathComponent];
    
    //Create path if it doesn't exist yet
    if (![fileManager fileExistsAtPath:pathWithoutFileName])
    {
        [fileManager createDirectoryAtPath:pathWithoutFileName withIntermediateDirectories:NO attributes:nil error:nil];
    }
    
    [data writeToFile:path atomically:YES];
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

@end
