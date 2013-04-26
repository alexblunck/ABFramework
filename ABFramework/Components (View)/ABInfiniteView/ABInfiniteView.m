//
//  ABInfiniteView.m
//  ABFramework
//
//  Created by Alexander Blunck on 4/21/13.
//  Copyright (c) 2013 Ablfx. All rights reserved.
//

#import "ABInfiniteView.h"

@interface ABInfiniteView () <UIScrollViewDelegate>
{
    UIScrollView *_scrollView;
    NSMutableArray *_viewArray;
    
    NSNumber *_viewWidth;
    
    NSTimer *_timer;
    BOOL _timerScheduled;
    NSTimeInterval _timerInterval;
}

@end

@implementation ABInfiniteView

#pragma mark - Initializer
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _viewArray = [NSMutableArray new];
    }
    return self;
}



#pragma mark - LifeCycle
- (void)willMoveToWindow:(UIWindow *)newWindow
{
    [super willMoveToWindow:newWindow];
    if (newWindow == (id)[NSNull null] || newWindow == nil)
    {
        [_timer invalidate];
        _timer = nil;
    }
    else
    {
        if (_timerScheduled) {
            [self scrollWithTimeInterval:_timerInterval];
        }
    }
}

-(void) didMoveToSuperview
{
    _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    _scrollView.delegate = self;
    _scrollView.pagingEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:_scrollView];
    
    _scrollView.backgroundColor = [UIColor blackColor];
    
    if (!self.dataSource)
    {
        NSLog(@"ABInfiniteScrollView: Error -> No data source set!");
        return;
    }
    
    //Ask data soure for view count
    NSUInteger viewCount = [self.dataSource abInfiniteViewCount:self];
    
    //Add all views to the scrollView, 3 times
    CGFloat xPos = 0.0f;
    
    for (int i = 0; i < 3; i++)
    {
        for (int index = 0; index < viewCount; index++)
        {
            //Ask data source for view for index
            ABView *view = [self.dataSource abInfiniteView:self viewForIndex:index];
            
            if (![view isKindOfClass:[ABView class]])
            {
                NSLog(@"ABInfiniteScrollView: Error -> All views need to be a ABView, or a subclass of ABView");
                continue;
            }
            
            if (![self validViewWidth:view.bounds.size.width])
            {
                NSLog(@"ABInfiniteScrollView: Error -> All views need to have the same width! (index:%i)", index);
                continue;
            }
            
            //Keep track of index
            NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:view.userData];
            [dic setObject:[NSNumber numberWithInteger:index] forKey:@"ABInfiniteView.index"];
            view.userData = dic;
            
            //Touch handeling
            [view setTarget:self selector:@selector(viewSelected:)];
            
            //Position view after last added view
            view.frame = CGRectChangingOriginX(view.frame, xPos);
            //Increment xPos for next view
            xPos = view.right;
            
            //Add view to array & scroll view
            [_viewArray addObject:view];
            [_scrollView addSubview:[_viewArray lastObject]];
        }
    }
    
    //Size & position scroll view
    _scrollView.contentSize = CGSizeMake([self viewWidth] * (viewCount*3), _scrollView.height);
    [_scrollView scrollRectToVisible:cgr([self viewWidth], 0, [self viewWidth], _scrollView.height) animated:NO];
}



#pragma mark - Helper
-(CGFloat) viewWidth
{
    return _viewWidth.floatValue;
}

-(BOOL) validViewWidth:(CGFloat)width
{
    if (_viewWidth == nil)
    {
        _viewWidth = [NSNumber numberWithFloat:width];
    }
    
    if ([self viewWidth] == width)
    {
        return YES;
    }
    return NO;
}



#pragma mark - Automatic Scrolling
-(void) scrollWithTimeInterval:(NSTimeInterval)timeInterval
{
    [_timer invalidate];
    _timer = nil;
    
    _timerScheduled = YES;
    _timerInterval = timeInterval;
    _timer = [NSTimer scheduledTimerWithTimeInterval:timeInterval target:self selector:@selector(scrollToNextView) userInfo:nil repeats:YES];
}

-(void) stopScrolling
{
    [_timer invalidate];
    _timer = nil;
    _timerScheduled = NO;
}

-(void) scrollToNextView
{
    [_scrollView setContentOffset:CGPointMake(_scrollView.contentOffset.x+[self viewWidth], 0) animated:YES];
}



#pragma mark - Selection
-(void) viewSelected:(ABView*)view
{
    id indexObject = [view.userData safeObjectForKey:@"ABInfiniteView.index"];
    
    if (indexObject)
    {
        NSUInteger index = [indexObject integerValue];
        
        if ([self.delegate respondsToSelector:@selector(abInfiniteView:didSelectViewAtIndex:)])
        {
            [self.delegate abInfiniteView:self didSelectViewAtIndex:index];
        }
    }
}



#pragma mark - UIScrollViewDelegate
-(void) scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [_timer invalidate];
    _timer = nil;
    
    [self processScroll:scrollView];
}

-(void) scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self processScroll:scrollView];
}

-(void) scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (_timerScheduled)
    {
        [self scrollWithTimeInterval:_timerInterval];
    }
}

-(void) processScroll:(UIScrollView *)scrollView
{
    if (_scrollView.contentOffset.x <= ( (self.uniqueViews.count - 1) * [self viewWidth]) )
    {
        [_scrollView setContentOffset:CGPointMake( (self.uniqueViews.count + (self.uniqueViews.count - 1)) * [self viewWidth], 0)];
    }
    else if (_scrollView.contentOffset.x >= (2 * self.uniqueViews.count * [self viewWidth]))
    {
        [_scrollView setContentOffset:CGPointMake(self.uniqueViews.count * [self viewWidth], 0)];
    }
}



#pragma mark - Access
-(UIView*) viewAtIndex:(NSUInteger)index
{
    return [_viewArray safeObjectAtIndex:index];
}

-(NSArray*) allViews
{
    return _viewArray;
}

-(NSArray*) uniqueViews
{
    NSMutableArray *array = [NSMutableArray new];
    
    for (int index = 0; index < (_viewArray.count/3); index++)
    {
        [array addObject:[_viewArray safeObjectAtIndex:index]];
    }
    
    return array;
}

@end
