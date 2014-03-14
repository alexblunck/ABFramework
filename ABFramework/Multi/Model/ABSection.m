//
//  ABSection.m
//  ABFramework
//
//  Created by Alexander Blunck on 7/25/13.
//  Copyright (c) 2013 Ablfx. All rights reserved.
//

#import "ABSection.h"

@implementation ABSection

#pragma mark - Initializer
-(id) init
{
    self = [super init];
    if (self)
    {
        self.items = [NSMutableArray new];
    }
    return self;
}



#pragma mark - Accessors
-(NSString*) description
{
    return [NSString stringWithFormat:@"ABSection: %@ (%i)", self.headerTitle, (int)self.items.count];
}

@end
