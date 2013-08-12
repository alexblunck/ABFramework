//
//  ABInfiniteViewExample.m
//  ABFramework-Examples
//
//  Created by Alexander Blunck on 4/21/13.
//  Copyright (c) 2013 Ablfx. All rights reserved.
//

#import "ABInfiniteViewExample.h"

@interface ABInfiniteViewExample () <ABInfiniteViewDataSource, ABInfiniteViewDelegate>
{
    NSArray *_colorArray;
}

@end

@implementation ABInfiniteViewExample

#pragma mark - LifeCycle
- (void)viewDidLoad
{
    [super viewDidLoad];
	
    _colorArray = @[[UIColor redColor], [UIColor greenColor], [UIColor blueColor]];
    
    //Init infinite view
    ABInfiniteView *infiniteView = [[ABInfiniteView alloc] initWithFrame:cgr(0, 100.0f, self.view.width, 200.0f)];
    infiniteView.dataSource = self;
    infiniteView.delegate = self;
    [self.view addSubview:infiniteView];
    
    //Automatically scroll to next view every 2 seconds
    [infiniteView scrollWithTimeInterval:2.0f];
}



#pragma mark - ABInfiniteViewDataSource
-(NSUInteger) abInfiniteViewCount:(ABInfiniteView *)infiniteView
{
    return _colorArray.count;
}

-(ABView*) abInfiniteView:(ABInfiniteView *)infiniteView viewForIndex:(NSUInteger)index
{
    UIColor *color = [_colorArray objectAtIndex:index];
    
    ABView *view = [[ABView alloc] initWithFrame:cgr(0, 0, infiniteView.width, infiniteView.height)];
    view.backgroundColor = color;
    
    return view;
}



#pragma mark - ABInfiniteViewDelegate
-(void) abInfiniteView:(ABInfiniteView *)infiniteView didSelectViewAtIndex:(NSUInteger)index
{
    ABLogInteger(index);
}

@end
