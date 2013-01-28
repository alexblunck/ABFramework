//
//  ABDateDescriptor.h
//  ABFramework
//
//  Created by Alexander Blunck on 9/11/12.
//  Copyright (c) 2012 Ablfx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ABDateDescriptor : NSObject

@property (nonatomic, assign) NSInteger dateUnits;
@property (nonatomic, strong) NSString *dateUnitName;

@end
