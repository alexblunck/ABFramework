//
//  NSArray+ABFramework.h
//  ABFramework
//
//  Created by Alexander Blunck on 4/17/13.
//  Copyright (c) 2013 Ablfx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (ABFramework)

//Conversion
-(NSString*) jsonString;

//Safe Access
-(id) safeObjectAtIndex:(NSUInteger)index;
-(id) safeObjectAtIndex:(NSUInteger)index verbose:(BOOL)verbose; //Be careful with this one

//Add
-(NSArray*) arrayByAddingObject:(id)object;

//Remove
-(NSArray*) arrayByRemovingObject:(id)object;

@end
