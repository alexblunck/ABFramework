//
//  ABTabBar.m
//  ABFramework
//
//  Created by Alexander Blunck on 9/7/12.
//  Copyright (c) 2012 Ablfx. All rights reserved.
//

#import "ABTabBar.h"

@interface ABTabBar () <ABViewDelegate>
{
    NSArray *_tabBarItems;
    CGFloat _taBarHeight;
    NSString *_backgroundImageName;
    CGFloat _tabSpacing;
    
    NSMutableArray *_tabViewArray;
    UIView *_backgroundView;
    UIToolbar *_toolBar;
    
    __weak id<ABTabBarDelegate> _delegate;
}
@end

@implementation ABTabBar

#pragma mark - Initializer
- (id)initWithTabBarItems:(NSArray*)tabBarItems
             tabBarHeight:(CGFloat)tabBarHeight
      backgroundImageName:(NSString*)backgroundImageName
               tabSpacing:(CGFloat)tabSpacing
                 delegate:(id<ABTabBarDelegate>)delegate
{
    self = [super init];
    if (self)
    {
        _tabBarItems = tabBarItems;
        _taBarHeight = tabBarHeight;
        _backgroundImageName = backgroundImageName;
        _tabSpacing = tabSpacing;
        _delegate = delegate;
        
        //Allocation
        _tabViewArray = [NSMutableArray new];
        
        _toolBar = [UIToolbar new];
    }
    return self;
}



#pragma mark - LifeCycle
-(void) willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    
    //Background image
    if (_backgroundImageName)
    {
        _backgroundView = [[ABView alloc] initWithBackgroundImageName:_backgroundImageName];
        [self addSubview:_backgroundView];
    }
    //If none is set use UIToolbar appearance
    else
    {
        _backgroundView = [ABView new];
        _backgroundView.frame = cgr(0, 0, newSuperview.bounds.size.width, self.height);
        
        _toolBar.frame = _backgroundView.bounds;
        [_backgroundView addSubview:_toolBar];
        
        [self addSubview:_backgroundView];
    }
    
    //Layout tabs
    [self layoutTabs];
}



#pragma mark - Layout
-(void) layoutTabs
{
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    
    NSInteger tabCount = _tabBarItems.count;
    
    //Calculate width of all tabs combined
    CGFloat tabsWidth = 0;
    for (ABTabBarItem *item in _tabBarItems)
    {
        UIImage *tabImage = [UIImage imageNamed:item.tabImageName];
        tabsWidth += tabImage.size.width;
    }
    
    //Width Of all tabs + spacing
    CGFloat tabsWidthWithSpacing = tabsWidth + ((tabCount -1) * _tabSpacing);
    
    //Keep track of Y origin
    //Computer first tab 's origin to center all tabs (don't add the actual tabSpacing before the first tab)
    CGFloat currentOrigin = (screenWidth - tabsWidthWithSpacing) / 2;
    
    //Loop through ABTabBarItem 's and create tabs
    for (ABTabBarItem *item in _tabBarItems)
    {
        //Retrieve ABTabBarItem for controller
        ABView *view = [[ABView alloc] initWithBackgroundImageName:item.tabImageName];
        view.selectedBackgroundImageName = [item.tabImageName stringByAppendingString:@"-sel"];
        view.frame = CGRectChangingOriginX(view.frame, currentOrigin);
        
        view.abUserData = @{@"itemIndex": NSNumberInteger([_tabBarItems indexOfObject:item])};
        view.delegate = self;
        
        [_tabViewArray addObject:view];
        
        [_backgroundView addSubview:[_tabViewArray lastObject]];
        
        //Compute Origin for next tab view
        currentOrigin = view.frame.origin.x + view.width + _tabSpacing;
    }
}



#pragma mark - ABViewDelegate
-(void) abViewDidTouchUpInside:(ABView *)selectedView
{
    ABTabBarItem *item = [_tabBarItems safeObjectAtIndex:[[selectedView.abUserData safeObjectForKey:@"itemIndex"] integerValue]];
    
    //Unhightlight all other tabs / highlight selected one
    for (ABView *view in _tabViewArray)
    {
        if (view != selectedView)
        {
            view.selected = NO;
        }
        else
        {
            view.selected = YES;
        }
    }
    
    [_delegate tabBarItemSelected:item];
}

-(void) abViewDidDoubleTouchUpInside:(ABView *)selectedView
{
    ABTabBarItem *item = [_tabBarItems safeObjectAtIndex:[[selectedView.abUserData safeObjectForKey:@"itemIndex"] integerValue]];
    [_delegate tabBarItemSelectedDouble:item];
}



#pragma mark - Accessors
-(void) setBarStyle:(UIBarStyle)barStyle
{
    _barStyle = barStyle;
    
    _toolBar.barStyle = _barStyle;
}

-(void) setTranslucent:(BOOL)translucent
{
    _translucent = translucent;
    
    _toolBar.translucent = _translucent;
}

-(void) setSelectedIndex:(NSUInteger)selectedIndex
{
    _selectedIndex = selectedIndex;
    
    for (ABView *tabView in _tabViewArray)
    {
        NSUInteger index = [_tabViewArray indexOfObject:tabView];
        tabView.selected = (index == selectedIndex);
    }
}

@end
