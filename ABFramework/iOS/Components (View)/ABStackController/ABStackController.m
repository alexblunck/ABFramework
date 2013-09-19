//
//  ABStackController.m
//  ABFramework
//
//  Created by Alexander Blunck on 2/6/13.
//  Copyright (c) 2013 Ablfx. All rights reserved.
//

#import "ABStackController.h"

@interface ABStackController ()
{
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
        
        self.backgroundColor = [UIColor whiteColor];
        
        //Allocation
        _viewArray = [NSMutableArray new];
        
        //Configuration
        _isFixedHeight = (fixedHeight > 0.0f) ? YES : NO;
        _nextOriginY = 0.0f;
        self.delayTouch = NO;
        
        //ScrollView (only instantiate if a fixed height is set)
        if (_isFixedHeight)
        {
            _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
            _scrollView.alwaysBounceVertical = YES;
            _scrollView.showsVerticalScrollIndicator = YES;
            _scrollView.delaysContentTouches = self.delayTouch;
            _scrollView.clipsToBounds = NO;
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
    [self addView:newView centered:YES];
}

-(void) addView:(UIView *)newView appendPadding:(CGFloat)padding
{
    [self addView:newView centered:YES];
    [self addPadding:padding];
}

-(void) addView:(UIView *)newView prependPadding:(CGFloat)padding
{
    [self addPadding:padding];
    [self addView:newView centered:YES];
}

-(void) addViewIgnoringRowBackgroundColor:(UIView*)newView
{
    [self addView:newView centered:YES backgroundColor:nil];
}

-(void) addView:(UIView*)newView centered:(BOOL)centered
{
    [self addView:newView centered:centered backgroundColor:self.rowBackgroundColor];
}

-(void) addView:(UIView*)newView centered:(BOOL)centered backgroundColor:(UIColor*)backgroundColor
{
    //Containment View
    UIView *containmentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, newView.bounds.size.width, newView.bounds.size.height)];
    
    if (backgroundColor)
    {
        containmentView.frame = CGRectChangingSize(containmentView.frame, self.width, newView.height);
        containmentView.backgroundColor = backgroundColor;
        containmentView.clipsToBounds = self.clipsToBounds;
        newView.frame = CGRectCenteredHorizontallyS(newView.frame, containmentView.bounds);
    }
    
    [containmentView addSubview:newView];
    
    //Adjust containment view frame to be placed beneath last view
    containmentView.frame = CGRectChangingOriginY(containmentView.frame, _nextOriginY);
    
    //Center containment view if neccessary
    if (centered && containmentView.bounds.size.width < self.bounds.size.width)
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
        //Adjust scrollView contentSize to account for new view
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
    [self addPadding:padding backgroundColor:self.rowBackgroundColor];
}

-(void) addPaddingIgnoringRowBackgroundColor:(CGFloat)padding
{
    [self addPadding:padding backgroundColor:nil];
}

-(void) addPadding:(CGFloat)padding backgroundColor:(UIColor*)backgroundColor
{
    if (backgroundColor)
    {
        UIView *paddingBackgroundView = [[UIView alloc] initWithFrame:cgr(0, _nextOriginY, self.width, padding)];
        paddingBackgroundView.backgroundColor = backgroundColor;
        
        if (_isFixedHeight)
        {
            [_scrollView addSubview:paddingBackgroundView];
        }
        else
        {
            [self addSubview:paddingBackgroundView];
        }
    }
    
    //Iterate nextOriginY by desired value
    _nextOriginY += padding;
    
    if (_isFixedHeight)
    {
        //Adjust scrollView contentSize to account for added padding
        _scrollView.contentSize = CGSizeOffsetHeight(_scrollView.contentSize, padding);
    }
    else
    {
        //Adjust own view frame to account for added padding
        self.frame = CGRectOffsetSizeHeight(self.frame, padding);
    }
}



#pragma mark - Seperators
-(void) addOnePointSeperator:(UIColor*)color
{
    [self addOnePointSeperator:color preAndAppendPadding:0];
}

-(void) addOnePointSeperator:(UIColor*)color preAndAppendPadding:(CGFloat)padding
{
    [self addSeperator:color height:(IS_RETINA_DISPLAY) ? 0.5f : 1.0f preAndAppendPadding:padding];
}

-(void) addSeperator:(UIColor*)color height:(CGFloat)height
{
    [self addSeperator:color height:height preAndAppendPadding:0];
}

-(void) addSeperator:(UIColor*)color height:(CGFloat)height preAndAppendPadding:(CGFloat)padding
{
    if (padding > 0) [self addPadding:padding];
    
    UIView *sep = [[UIView alloc] initWithFrame:cgr(0, 0, self.width, height)];
    sep.backgroundColor = color;
    [self addView:sep];
    
    if (padding > 0) [self addPadding:padding];
}



#pragma mark - Interaction
-(void) scrollToTop
{
    if (_isFixedHeight)
    {
        [_scrollView setContentOffset:CGPointZero animated:YES];
    }
}

-(void) scrollToBottom
{
    if (_isFixedHeight && _scrollView.contentSize.height > _scrollView.bounds.size.height)
    {
        CGPoint bottomOffset = CGPointMake(0, _scrollView.contentSize.height - _scrollView.bounds.size.height);
        [_scrollView setContentOffset:bottomOffset animated:YES];
    }
}



#pragma mark - Access
-(UIScrollView*) uiScrollView
{
    return _scrollView;
}



#pragma mark - Accessors
#pragma mark - delayTouch
-(void) setDelayTouch:(BOOL)delayTouch
{
    _delayTouch = delayTouch;
    if (_isFixedHeight)
    {
        _scrollView.delaysContentTouches = delayTouch;
    }
}

#pragma mark - stackViews
-(NSArray*) stackViews
{
    NSMutableArray *stackViews = [NSMutableArray new];
    for (UIView *view in _viewArray)
    {
        [stackViews addObject:[[view subviews] safeObjectAtIndex:0]];
    }
    
    return stackViews;
}

#pragma mark - frame
-(void) setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    _scrollView.frame = CGRectChangingCGSize(_scrollView.frame, frame.size);
}

@end
