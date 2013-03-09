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

+(NSString*) pathForFile:(NSString*)fileName forPathInDocumentsFolder:(NSString*)folderPath
{
    return [NSString stringWithFormat:@"%@/%@/%@", [self documentsPath], folderPath, fileName];
}



#pragma mark - Write
+(void) writeDataToFile:(NSData*)data fileName:(NSString*)fileName toPathInDocumentsFolder:(NSString*)folderPath
{
    [self writeDataToFile:data path:[self pathForFile:fileName forPathInDocumentsFolder:folderPath]];
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

@end
