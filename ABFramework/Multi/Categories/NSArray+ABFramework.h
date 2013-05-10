//
//  NSArray+ABFramework.h
//  ABFramework
//
//  Created by Alexander Blunck on 4/17/13.
//  Copyright (c) 2013 Ablfx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (ABFramework)

-(NSString*) jsonString;

-(id) safeObjectAtIndex:(NSUInteger)index;

@end
