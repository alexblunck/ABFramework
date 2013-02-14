//
//  ABStackController.m
//  ABFramework
//
//  Created by Alexander Blunck on 2/6/13.
//  Copyright (c) 2013 Ablfx. All rights reserved.
//

#import "ABStackController.h"

@interface ABStackController () {
    //If a fixed height is set, views will be added to a scrollView,
    //otherwise the stack will grow with each added item
    BOOL _isFixedHeight;
    
    //ScrollView to hold all views if a fixed height is set
    UIScrollView *_scrollView;
    
    //Array to hold all views added to stack
    NSMutableArray *_viewArray;
    
    //Keeps track of next Y Origin to place next view
    CGFloat _nextOriginY;
}
@end

@implementation ABStackController

#pragma mark - Initializer
-(id) initWithWidth:(CGFloat)width fixedHeight:(CGFloat)fixedHeight
{
    self = [super initWithFrame:CGRectMake(0, 0, width, fixedHeight)];
    if (self) {
        
        //Allocation
        _viewArray = [NSMutableArray new];
        
        //Configuration
        _isFixedHeight = (fixedHeight > 0.0f) ? YES : NO;
        _nextOriginY = 0.0f;
        
        //ScrollView (only instantiate if a fixed height is set)
        if (_isFixedHeight)
        {
            _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
            _scrollView.alwaysBounceVertical = YES;
            _scrollView.showsVerticalScrollIndicator = YES;
            [self addSubview:_scrollView];
        }
        
    }
    return self;
}

-(id) init
{
    NSLog(@"ABStackController ERROR -> Please use custom initializer!");
    return nil;
}

#pragma mark - LifeCycle
-(void) willMoveToSuperview:(UIView *)newSuperview
{
    
}



#pragma mark - Reset
-(void) resetStack
{
    //Reset nextOriginY to 0
    _nextOriginY = 0.0f;
    
    //Remove all views
    for (UIView *view in _viewArray)
    {
        [view removeFromSuperview];
    }
    
    //Empty Array
    [_viewArray removeAllObjects];
    
    //Reset scrollView contentSize
    _scrollView.contentSize = CGSizeMake(_scrollView.contentSize.width, 0.0f);
    
    //Reset own frame if fixedHeight wasn't set
    if (!_isFixedHeight)
    {
        self.frame = CGRectChangingSizeHeight(self.frame, 0.0f);
    }
}



#pragma mark - Add Views
-(void) addView:(UIView*)newView
{
    //Containment View
    UIView *containmentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, newView.bounds.size.width, newView.bounds.size.height)];
    [containmentView addSubview:newView];
    
    //Retrieve last added view and get it's bottom Y Origin
    //UIView *lastView = [_viewArray lastObject];
    //CGFloat lastViewBottomOriginY = (lastView) ? CGFloatBottomOriginY(lastView.frame) : 0.0f;
    
    //Adjust containment view frame to be placed beneath last view
    containmentView.frame = CGRectChangingOriginY(containmentView.frame, _nextOriginY);
    
    //Center containment view if neccessary
    if (containmentView.bounds.size.width < self.bounds.size.width)
    {
        containmentView.frame = CGRectCenteredHorizontallyS(containmentView.frame, self.frame);
    }
    
    //Add to viewArray
    [_viewArray addObject:containmentView];
    
    //Determine where to add view
    if (_isFixedHeight)
    {
        //Add to scrollView
        [_scrollView addSubview:containmentView];
        //Adjust scrollView frame to account for new view
        _scrollView.contentSize = CGSizeOffsetHeight(_scrollView.contentSize, containmentView.bounds.size.height);
    }
    else
    {
        //Add to own view
        [self addSubview:containmentView];
        //Adjust own view frame to account for new view
        self.frame = CGRectOffsetSizeHeight(self.frame, containmentView.bounds.size.height);
    }
    
    //Iterate nextOriginY
    _nextOriginY = containmentView.bottom;
}

-(void) addViews:(NSArray*)newViews
{
    for (id newView in newViews)
    {
        if ([newView isKindOfClass:[UIView class]])
        {
            [self addView:newView];
        }
    }
    
}



#pragma mark - Add Padding
-(void) addPadding:(CGFloat)padding
{
    //Iterate nextOriginY by desired value
    _nextOriginY += padding;
}



#pragma mark - Accessors

@end
