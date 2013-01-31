//
//  ExampleObject.m
//  ABFramework-Examples
//
//  Created by Alexander Blunck on 1/31/13.
//  Copyright (c) 2013 Ablfx. All rights reserved.
//

#import "ExampleObject.h"

@implementation ExampleObject

+(id) objectWithName:(NSString*)name viewControllerClass:(id)viewControllerClass
{
    return [[self alloc] initWithName:name viewControllerClass:viewControllerClass];
}

-(id) initWithName:(NSString*)name viewControllerClass:(id)viewControllerClass
{
    self = [super init];
    if (self) {
        
        self.name = name;
        self.viewControllerClass = viewControllerClass;
        
    } return self;
}

@end
