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
 * Returns full path to "documents" directory
 */
+(NSString*) documentsPath;

/**
 * Returns full path for a folder in the "documents" directory
 */
+(NSString*) pathForPathInDocumentsFolder:(NSString*)folderPath;

/**
 * Returns full path for a file in a folder in der "documents" directory
 *
 * Example: [ABFileHelper pathForFile:@"myFile.json" forPathInDocumentsFolder:@"some/sub/folder"];
 */
+(NSString*) pathForFile:(NSString*)fileName forPathInDocumentsFolder:(NSString*)folderPath;



//Write

/**
 * Write data to a file in a folder in the "documents" directory
 */
+(void) writeDataToFile:(NSData*)data fileName:(NSString*)fileName toPathInDocumentsFolder:(NSString*)folderPath;



//Read

+(NSData*) dataFromFile:(NSString*)fileName inPathInDocumentsFolder:(NSString*)folderPath;


//Delete

+(void) deleteFile:(NSString*)fileName inPathInDocumentsFolder:(NSString*)folderPath;

@end
