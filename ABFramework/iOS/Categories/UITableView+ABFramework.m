//
//  UITableView+ABFramework.m
//  ABFramework
//
//  Created by Alexander Blunck on 4/25/13.
//  Copyright (c) 2013 Ablfx. All rights reserved.
//

#import "UITableView+ABFramework.h"

@implementation UITableView (ABFramework)

-(void) scrollToBottom
{
    if (self.contentSize.height > self.bounds.size.height)
    {
        CGPoint bottomOffset = CGPointMake(0, (self.contentSize.height - self.bounds.size.height)+self.tableFooterView.height);
        [self setContentOffset:bottomOffset animated:YES];
    }
}

@end
