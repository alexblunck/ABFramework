//
//  ExampleObject.h
//  ABFramework-Examples
//
//  Created by Alexander Blunck on 1/31/13.
//  Copyright (c) 2013 Ablfx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ExampleObject : NSObject

@property(nonatomic, strong) NSString *name;
@property(nonatomic, assign) id viewControllerClass;

+(id) objectWithName:(NSString*)name viewControllerClass:(id)viewControllerClass;

@end
