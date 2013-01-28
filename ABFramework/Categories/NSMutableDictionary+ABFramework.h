//
//  NSMutableDictionary+ABFramework.h
//  ABFramework
//
//  Created by Alexander Blunck on 1/23/13.
//  Copyright (c) 2013 Ablfx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary (ABFramework)

-(void) safeSetObject:(id)anObject forKey:(id<NSCopying>)aKey;

@end
