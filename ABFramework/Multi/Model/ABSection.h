//
//  ABSection.h
//  ABFramework
//
//  Created by Alexander Blunck on 7/25/13.
//  Copyright (c) 2013 Ablfx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ABSection : NSObject

@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, copy) NSString *headerTitle;
@property (nonatomic, copy) NSString *footerTitle;
@property (nonatomic, assign) NSInteger priority;

@end
