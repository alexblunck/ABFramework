//
//  ABPrimitiveArray.h
//  ABFramework
//
//  Created by Alexander Blunck on 3/30/13.
//  Copyright (c) 2013 Ablfx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ABPrimitiveArray : NSObject

@property (nonatomic, strong) NSMutableArray *objectArray;

//Properties
@property (nonatomic, assign, readonly) NSUInteger count;

@end
