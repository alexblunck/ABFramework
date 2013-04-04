//
//  ABTableStackController.m
//  ABFramework
//
//  Created by Alexander Blunck on 3/8/13.
//  Copyright (c) 2013 Ablfx. All rights reserved.
//

#import "ABTableStackController.h"

@interface ABTableStackController () <UITableViewDataSource, UITableViewDelegate>
{
    UITableView *_tableView;
    NSMutableArray *_viewArray;
}

@end

@implementation ABTableStackController

#pragma mark - Initializer
-(id) initWithWidth:(CGFloat)width fixedHeight:(CGFloat)fixedHeight
{
    self = [super init];
    if (self)
    {
        //Assume Frame
        self.frame = CGRectMake(0, 0, width, fixedHeight);
        
        //Allocation
        _viewArray = [NSMutableArray new];
        
        _tableView = [UITableView new];
        _tableView.frame = self.bounds;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = [UIColor clearColor];
        [self addSubview:_tableView];
    }
    return self;
}



#pragma mark - LifeCycle



#pragma mark - Reset
-(void) resetStack
{
    [_viewArray removeAllObjects];
    [_tableView reloadData];
}



#pragma mark - Add Views
-(void) addView:(UIView*)newView
{
    [self addView:newView centered:YES];
}

-(void) addView:(UIView*)newView centered:(BOOL)centered
{
    //Containment View
    UIView *containmentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, newView.bounds.size.height)];
    [containmentView addSubview:newView];
    
    //Center containment view if neccessary
    if (centered)
    {
        newView.frame = CGRectCenteredHorizontallyS(newView.frame, containmentView.bounds);
    }
    
    //Add to view array
    [_viewArray addObject:containmentView];
    
    [_tableView reloadData];
}

-(void) addViews:(NSArray*)newViews
{
    [self addViews:newViews centered:YES];
}

-(void) addViews:(NSArray*)newViews centered:(BOOL)centered
{
    for (UIView *view in newViews)
    {
        [self addView:view centered:centered];
    }
}


#pragma mark - Add Padding
-(void) addPadding:(CGFloat)padding
{
    //Create empty UIView
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, padding)];
    [_viewArray addObject:paddingView];
    
    [_tableView reloadData];
}



#pragma mark - Interaction
-(void) scrollToTop
{
    [_tableView setContentOffset:CGPointZero animated:YES];
}



#pragma mark - Helper
-(UIView*) viewAtIndexPath:(NSIndexPath *)indexPath
{
    return [_viewArray objectAtIndex:indexPath.row];
}


#pragma mark - UITableViewDelegate
-(CGFloat) tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath
{
    UIView *view = [self viewAtIndexPath:indexPath];
    return view.bounds.size.height;
}


#pragma mark - UITableViewDataSource
-(NSInteger) tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    return _viewArray.count;
}

-(UITableViewCell*) tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    /*
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        [cell.contentView addSubview:[self viewAtIndexPath:indexPath]];
    }
    */
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    [cell.contentView addSubview:[self viewAtIndexPath:indexPath]];
    
    return cell;
}


#pragma mark - Accessors
-(void) setDelayTouch:(BOOL)delayTouch
{
    _delayTouch = delayTouch;
    _tableView.delaysContentTouches = _delayTouch;
}
@end
