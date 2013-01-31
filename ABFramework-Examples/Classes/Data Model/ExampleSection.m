//
//  ExampleSection.m
//  ABFramework-Examples
//
//  Created by Alexander Blunck on 1/31/13.
//  Copyright (c) 2013 Ablfx. All rights reserved.
//

#import "ExampleSection.h"

@implementation ExampleSection

+(id) sectionWithName:(NSString*)name exampleObjectArray:(NSArray*)exampleObjectArray
{
    return [[self alloc] initWithName:name exampleObjectArray:exampleObjectArray];
}

-(id) initWithName:(NSString*)name exampleObjectArray:(NSArray*)exampleObjectArray
{
    self = [super init];
    if (self) {
        
        self.name = name;
        self.exampleObjectArray = exampleObjectArray;
        
    } return self;
}

@end
