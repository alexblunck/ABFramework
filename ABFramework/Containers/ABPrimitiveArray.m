//
//  ABPrimitiveArray.m
//  ABFramework
//
//  Created by Alexander Blunck on 3/30/13.
//  Copyright (c) 2013 Ablfx. All rights reserved.
//

#import "ABPrimitiveArray.h"

@implementation ABPrimitiveArray

#pragma mark - Initializer
-(id) init
{
    self = [super init];
    if (self)
    {
        //Allocation
        self.objectArray = [NSMutableArray new];
    }
    return self;
}



#pragma mark - Accessors
#pragma mark - count
-(NSUInteger) count
{
    return self.objectArray.count;
}
@end
