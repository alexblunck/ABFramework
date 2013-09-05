//
//  ABFileHelper.h
//  ABFramework
//
//  Created by Alexander Blunck on 3/09/13.
//  Copyright (c) 2013 Ablfx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ABFileHelper : NSObject

//Paths
/**
 * Returns full path for a file in a folder
 */
+(NSString*) pathForFile:(NSString*)fileName atPath:(NSString*)folderPath;

/**
 * Returns full path to "documents" directory
 */
+(NSString*) documentsPath;

/**
 * Returns full path to "tmp" directory
 */
+(NSString*) tempPath;

/**
 * Returns full path for a folder in the "documents" directory
 */
+(NSString*) pathForPathInDocumentsFolder:(NSString*)folderPath;

/**
 * Returns full path for a file in a folder in der "documents" directory
 *
 * Example: [ABFileHelper pathForFile:@"myFile.json" forPathInDocumentsFolder:@"some/sub/folder"];
 */
+(NSString*) pathForFile:(NSString*)fileName atPathInDocumentsFolder:(NSString*)folderPath;



//Write
/**
 * Write data to a file in a folder in the "documents" directory
 */
+(void) writeDataToFile:(NSData*)data fileName:(NSString*)fileName toPathInDocumentsFolder:(NSString*)folderPath;

/**
 * Create a specific path
 * Returns path that was created
 */
+(NSString*) createPath:(NSString*)path;

/**
 * Create an empty file, overwrite existing
 * Returns path to created file
 */
+(NSString*) createFile:(NSString*)fileName atPath:(NSString*)folderPath;



//Move
+(void) movePath:(NSString*)aPath toPath:(NSString*)bPath;



//Read
+(NSData*) dataFromFile:(NSString *)fileName atPath:(NSString*)folderPath;
+(NSData*) dataFromFile:(NSString*)fileName atPathInDocumentsFolder:(NSString*)folderPath;



//Delete
+(void) deleteFileAtPath:(NSString*)filePath;
+(void) deleteFile:(NSString*)fileName atPathInDocumentsFolder:(NSString*)folderPath;
+(void) deleteAllFilesAtFolderPath:(NSString*)folderPath;



//Rename
+(void) renameFileAtPath:(NSString*)filePath newName:(NSString*)newName;



//Exists
+(BOOL) fileExistsAtPath:(NSString*)filePath;

@end
