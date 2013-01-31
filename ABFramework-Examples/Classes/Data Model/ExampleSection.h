//
//  ExampleSection.h
//  ABFramework-Examples
//
//  Created by Alexander Blunck on 1/31/13.
//  Copyright (c) 2013 Ablfx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ExampleSection : NSObject

+(id) sectionWithName:(NSString*)name exampleObjectArray:(NSArray*)exampleObjectArray;

@property(nonatomic, strong) NSString *name;
@property(nonatomic, strong) NSArray *exampleObjectArray;

@end
