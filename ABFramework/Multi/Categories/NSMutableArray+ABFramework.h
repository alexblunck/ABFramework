//
//  NSMutableArray+ABFramework.h
//  ABFramework
//
//  Created by Alexander Blunck on 6/17/13.
//  Copyright (c) 2013 Ablfx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (ABFramework)

-(void) moveObjectAtIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex;

-(void) safeAddObject:(id)object;

@end
