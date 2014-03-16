//
//  ABPair.h
//  ABFramework
//
//  Created by Alexander Blunck on 2/23/13.
//  Copyright (c) 2013 Ablfx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ABPair : NSObject

//Utility
+(id) pairWithObjectA:(id)a andObjectB:(id)b;
+(id) pairWithIntegerA:(NSInteger)a andIntegerB:(NSInteger)b;

@property (nonatomic, strong) id a;
@property (nonatomic, strong) id b;

@end
