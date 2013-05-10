//
//  NSData+ABFramework.h
//  ABFramework
//
//  Created by Alexander Blunck on 11/11/12.
//  Copyright (c) 2012 Ablfx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (ABFramework)

//Encryption
-(NSData*) encryptedWithKey:(NSData*)key;
-(NSData*) decryptedWithKey:(NSData*)key;

@end
