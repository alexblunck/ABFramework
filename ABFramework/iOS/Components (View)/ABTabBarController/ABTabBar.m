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
    NSMutableArray *_tabViewArray;
    UIView *_backgroundView;
}
@end

@implementation ABTabBar

#pragma mark - Initializer
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        //Allocation
        _tabViewArray = [NSMutableArray new];
    }
    return self;
}



#pragma mark - LifeCycle
-(void) willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    
    //Set Background Image
    if (self.backgroundImageName)
    {
        _backgroundView = [[ABView alloc] initWithBackgroundImageName:self.backgroundImageName];
        [self addSubview:_backgroundView];
    }
    //If none has been specified use a UIToolBar View
    else
    {
        UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, newSuperview.bounds.size.width, self.height)];
        [self addSubview:toolBar];
    }
    
    //Layout Tabs
    [self layoutTabs];
}



#pragma mark - Layout
-(void) layoutTabs
{
    //Retrieve Screen Dimensions
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    CGFloat screenWidth = screenSize.width;
    
    NSInteger tabCount = self.tabBarItems.count;
    
    //Calculate width of all tabs combined
    CGFloat tabsWidth = 0;
    for (ABTabBarItem *item in self.tabBarItems)
    {
        UIImage *tabImage = [UIImage imageNamed:item.imageName];
        tabsWidth += tabImage.size.width;
    }
    
    //Width Of all tabs + spacing
    CGFloat tabsWidthWithSpacing = tabsWidth + ((tabCount -1) * self.tabSpacing);
    
    //Keep track of Origin
    //Computer first tab 's origin to center all tabs (don't add the actual tabSpacing before the first tab)
    CGFloat currentOrigin = (screenWidth - tabsWidthWithSpacing) / 2;
    
    //Loop through ABTabBarItem 's and create tabs
    for (ABTabBarItem *item in self.tabBarItems)
    {
        //Retrieve ABTabBarItem For Controller
        ABView *view = [[ABView alloc] initWithBackgroundImageName:item.imageName];
        view.selectedBackgroundImageName = [item.imageName stringByAppendingString:@"-sel"];
        view.frame = CGRectChangingOriginX(view.frame, currentOrigin);
        
        view.userData = @{@"itemIndex": NSNumberInteger([self.tabBarItems indexOfObject:item])};
        view.delegate = self;
        
        //[ABAlertView showAlertWithMessage:item.imageName];
        
        [_tabViewArray addObject:view];

        [_backgroundView addSubview:[_tabViewArray lastObject]];
        
        //Compute Origin for next Tab Button
        currentOrigin = view.frame.origin.x + view.width + self.tabSpacing;
    }
    
    //Set Initial selected Tab
    ABView *selectedTabView = [_tabViewArray safeObjectAtIndex:self.selectedIndex];
    selectedTabView.selected = YES;
}



#pragma mark - ABViewDelegate
-(void) abViewDidTouchUpInside:(ABView *)selectedView
{
    ABTabBarItem *item = [self.tabBarItems safeObjectAtIndex:[[selectedView.userData safeObjectForKey:@"itemIndex"] integerValue]];
    
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
    
    [self.delegate tabBarItemSelected:item];
}



#pragma mark - Helper
-(void) forceSwitchToTabIndex:(NSInteger)tabIndex
{
    //Highlight Correct Tab
    ABView *tabView = [_tabViewArray safeObjectAtIndex:tabIndex];
    //tabView.selected = YES;
    
    //Simulate touchUpInside
    [self abViewDidTouchUpInside:tabView];
}

@end
