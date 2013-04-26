//
//  ABTabBar.m
//  ABFramework
//
//  Created by Alexander Blunck on 9/7/12.
//  Copyright (c) 2012 Ablfx. All rights reserved.
//

#import "ABTabBar.h"

@interface ABTabBar () {
    NSMutableArray *_tabButtonArray;
}
@end

@implementation ABTabBar

#pragma mark - Initializer
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}



#pragma mark - LifeCycle
-(void) willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    
    //Allocation
    _tabButtonArray = [NSMutableArray new];
    
    //Set Background Image
    if (self.backgroundImage) {
        UIImageView *backgroundImageView = [[UIImageView alloc] initWithImage:self.backgroundImage];
        backgroundImageView.frame = CGRectMake(0, 0, self.backgroundImage.size.width, self.backgroundImage.size.height);
        [self addSubview:backgroundImageView];
    }
    //If none has been specified use a UIToolBar View
    else {
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
    int screenWidth = screenSize.width;
    
    int tabCount = self.viewControllers.count;
    
    //Get width of all tabs combined
    int tabsWidth = 0;
    for (ABViewController *viewController in self.viewControllers) {
        tabsWidth += viewController.abTabBarItem.image.size.width;
    }
    
    //Width Of all tabs + spacing
    //int tabsWidthWithSpacing = tabsWidth + ((tabCount - 1) * self.tabSpacing);
    int tabsWidthWithSpacing = tabsWidth + ((tabCount -1) * self.tabSpacing);
    
    //Keep track of Origin
    //Computer first tab 's origin to center all tabs (don't add the actual tabSpacing before the first tab)
    int currentOrigin = (screenWidth - tabsWidthWithSpacing) / 2;
    
    //Loop through ViewControllers and create tabs
    for (ABViewController *viewController in self.viewControllers) {
        
        //Retrieve ABTabBarItem For Controller
        ABTabBarItem *tabBarItem = viewController.abTabBarItem;
        
        //Create Button
        ABTabButton *tabButton = [ABTabButton buttonWithType:UIButtonTypeCustom];
        //Set Custom ImageView on Button
        tabButton.tabImageView = [[UIImageView alloc] initWithImage:tabBarItem.image highlightedImage:tabBarItem.selectedImage];
        //Button frame.size = Size of Image
        tabButton.frame = CGRectMake(currentOrigin, 0, tabBarItem.image.size.width, tabBarItem.image.size.height);
        
        //Set ViewController's array index
        tabButton.viewControllerIndex = [self.viewControllers indexOfObject:viewController];
        
        //Set image highlighted on Touch Down
        [tabButton addTarget:self action:@selector(highlight:) forControlEvents:UIControlEventTouchDown];
        //Set image unHighlighted on Touch Up Outside / Drag Outside
        [tabButton addTarget:self action:@selector(unHighlight:) forControlEvents:UIControlEventTouchUpOutside|UIControlEventTouchDragOutside];
        //Perform action on Touch Up Inside
        [tabButton addTarget:self action:@selector(tabTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
        
        //Add to tabButtonArray
        [_tabButtonArray addObject:tabButton];
        [self addSubview:_tabButtonArray.lastObject];
        
        //Compute Origin for next Tab Button
        currentOrigin = tabButton.frame.origin.x + tabBarItem.image.size.width + self.tabSpacing;
    }
    
    //Set Initial selected Tab
    ABTabButton *selectedButton = [_tabButtonArray safeObjectAtIndex:self.selectedIndex];
    [self highlight:selectedButton];
}



#pragma mark - Buttons
-(void) tabTouchUpInside:(id)sender
{
    ABTabButton *tabButton = sender;
    ABViewController *viewController = [self.viewControllers safeObjectAtIndex:tabButton.viewControllerIndex];
    
    //Unhightlight all other tabs / highlight selected one
    for (ABTabButton *button in _tabButtonArray) {
        if (button != tabButton) {
            [self unHighlight:button];
        }
    }
    
    [self.delegate tabBarTabSelected:viewController];
}



#pragma mark - Helper
-(void) forceSwitchToTabIndex:(int)tabIndex
{
    //Highlight Correct Tab
    ABTabButton *tabButton = [_tabButtonArray safeObjectAtIndex:tabIndex];
    [self highlight:tabButton];
    
    //Simulate touchUpInside
    [self tabTouchUpInside:tabButton];
}

-(void) highlight:(id)sender
{
    ABTabButton *tabButton = sender;
    tabButton.tabImageView.highlighted = YES;
}

-(void) unHighlight:(id)sender
{
    ABTabButton *tabButton = sender;
    tabButton.tabImageView.highlighted = NO;
}

@end
