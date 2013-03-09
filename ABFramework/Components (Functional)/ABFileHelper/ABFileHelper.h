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
 * Returns full path for a file in a folder in der "documents" directory
 *
 * Example: [ABFileHelper pathForFile:@"myFile.json" forPathInDocumentsFolder:@"some/sub/folder"];
 */
+(NSString*) pathForFile:(NSString*)fileName forPathInDocumentsFolder:(NSString*)folderPath;



//Write
+(void) writeDataToFile:(NSData*)data fileName:(NSString*)fileName toPathInDocumentsFolder:(NSString*)folderPath;

@end
