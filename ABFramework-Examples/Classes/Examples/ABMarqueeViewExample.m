//
//  ABMarqueeViewExample.m
//  ABFramework-Examples
//
//  Created by Alexander Blunck on 21/04/14.
//  Copyright (c) 2014 Ablfx. All rights reserved.
//

#import "ABMarqueeViewExample.h"

@implementation ABMarqueeViewExample


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    ABMarqueeView *marqueeView = [[ABMarqueeView alloc] initWithFrame:cgr(0, 0, self.view.width, 50.0f)];
    [marqueeView centerInView:self.view];
    [self.view addSubview:marqueeView];
}

@end
