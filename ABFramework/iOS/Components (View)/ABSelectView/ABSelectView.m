//
//  ABSelectView.m
//  ABFramework
//
//  Created by Alexander Blunck on 10/17/12.
//  Copyright (c) 2012 Ablfx. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "ABSelectView.h"

@interface ABSelectView () <ABViewDelegate>
{
    UIView *_presentingView;
    NSArray *_stringArray;
    NSInteger _initialIndex;
    ABSelectViewTheme _theme;
    ABBlockInteger _completionBlock;
    
    UIImageView *_blurredView;
    UIView *_backgroundView;
    ABStackController *_stack;
    NSMutableArray *_labelArray;
    UIView *_stackContainmentView;
}
@end

const ABSelectViewTheme ABSelectViewDefaultTheme = ABSelectViewThemeTranslucent;

@implementation ABSelectView

#pragma mark - Utility
+(id) showWithStringArray:(NSArray*)stringArray completion:(ABBlockInteger)block
{
    return [self showWithStringArray:stringArray selectedIndex:-1 completion:block];
}

+(id) showWithStringArray:(NSArray*)stringArray
            selectedIndex:(NSInteger)index
               completion:(ABBlockInteger)block
{
    return [self showWithPresentingView:nil stringArray:stringArray selectedIndex:index theme:nil completion:block];
}

+(id) showWithPresentingView:(UIView*)view
                 stringArray:(NSArray*)stringArray
               selectedIndex:(NSInteger)index
                       theme:(ABSelectViewTheme)theme
                  completion:(ABBlockInteger)block
{
    ABSelectView *selectView = [[self alloc] initWithPresentingView:view stringArray:stringArray selectedIndex:index theme:theme completion:block];
    [selectView show];
    return selectView;
}



#pragma mark - Initializer
-(id) initWithPresentingView:(UIView*)view
                 stringArray:(NSArray*)stringArray
               selectedIndex:(NSInteger)index
                       theme:(ABSelectViewTheme)theme
                  completion:(ABBlockInteger)block
{
    self = [super init];
    if (self)
    {
        //Config
        self.tableWidth = 230.0f;
        self.callCompletionBlockAfterHideAnimation = NO;
        
        _presentingView = (view) ? view : [UIView topView];
        _stringArray = stringArray;
        _initialIndex = index;
        _theme = (theme) ? theme : ABSelectViewDefaultTheme;
        _completionBlock = [block copy];
        
        _labelArray = [NSMutableArray new];
    }
    return self;
}



#pragma mark - LifeCycle
-(void) willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    
    self.frame = _presentingView.bounds;
    
    [self layout];
    
    [self setSelectedIndex:_initialIndex];
    
    [ABTapGestureRecognizer tapGestureWithTaps:1 onView:_backgroundView block:^{
        [self hide];
    }];
}



#pragma mark - Layout
-(void) layout
{
    //Background
    if (_theme == ABSelectViewThemeTranslucent)
    {
        UIImage *screenImage = [_presentingView renderCGRect:_presentingView.bounds];
        screenImage = [screenImage applyBlurWithRadius:4.0f tintColor:nil saturationDeltaFactor:1.0f maskImage:nil];
        _blurredView = [[UIImageView alloc] initWithImage:screenImage];
        _blurredView.alpha = 0.0f;
        [self addSubview:_blurredView];
    }
    
    _backgroundView = [[UIView alloc] initWithFrame:self.bounds];
    _backgroundView.backgroundColor = [UIColor blackColor];
    _backgroundView.alpha = 0.0f;
    [self addSubview:_backgroundView];
    
    //Stack
    _stackContainmentView = [UIView new];
    _stackContainmentView.clipsToBounds = YES;
    _stackContainmentView.layer.cornerRadius = 6.0f;
    [self addSubview:_stackContainmentView];
    
    _stack = [[ABStackController alloc] initWithWidth:self.tableWidth fixedHeight:0.0f];
    _stack.backgroundColor = [UIColor clearColor];
    [_stackContainmentView addSubview:_stack];
    
    for (NSString *string in _stringArray)
    {
        ABView *view = [[ABView alloc] initWithFrame:cgr(0, 0, _stack.width, 50.0f)];
        view.delegate = self;
        view.selectRecursively = YES;
        view.backgroundColor = [self colorRow];
        view.selectedBackgroundColor = [self colorRowSelected];
        
        if ([self seperator] && [_stringArray indexOfObject:string] != _stringArray.count-1)
        {
            UIView *sep = [[UIView alloc] initWithFrame:cgr(0, 0, view.width - 80.0f, 0.5f)];
            sep.backgroundColor = [UIColor colorWithWhite:1.0f alpha:0.2f];
            sep.frame = CGRectInsideBottomCenter(sep.frame, view.bounds, 0);
            [view addSubview:sep];
        }
        
        ABLabel *label = [ABLabel new];
        label.centeredHorizontally = YES;
        label.frame = CGRectOffsetSizeWidth(view.bounds, -20.0f);
        label.frame = CGRectCenteredHorizontallyS(label.frame, view.bounds);
        label.text = string;
        label.textColor = [self colorLabel];
        label.selectedTextColor = [self colorLabelHighlighted];
        [view addSubview:label];
        
        [_labelArray addObject:label];
        
        [_stack addView:view];
    }
    
    _stackContainmentView.frame = _stack.bounds;
    _stackContainmentView.frame = CGRectCenteredWithCGRect(_stackContainmentView.frame, self.bounds);
    _stackContainmentView.alpha = 0.0f;
    _stackContainmentView.transform = CGAffineTransformMakeScale(0.1f, 0.1f);
}



#pragma mark - Show / Hide
-(void) show
{
    [_presentingView addSubview:self];
    
    [UIView animateWithDuration:0.2f delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        _backgroundView.alpha = [self alphaBackgroundView];
        if (_theme == ABSelectViewThemeTranslucent) _blurredView.alpha = 1.0f;
        
        _stackContainmentView.alpha = 1.0f;
        _stackContainmentView.transform = CGAffineTransformMakeScale(1.1f, 1.1f);
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.1f delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
            
            _stackContainmentView.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
            
        } completion:nil];
        
    }];
}

-(void) hide
{
    [self hideWithSelectedIndex:nil];
}

-(void) hideWithSelectedIndex:(NSNumber*)index
{
    if (!self.callCompletionBlockAfterHideAnimation && index && _completionBlock)
    {
        _completionBlock(index.integerValue);
    }
    
    [UIView animateWithDuration:0.2f delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        _backgroundView.alpha = 0.0f;
        if (_theme == ABSelectViewThemeTranslucent) _blurredView.alpha = 0.0f;
        
        _stackContainmentView.alpha = 0.0f;
        _stackContainmentView.transform = CGAffineTransformMakeScale(0.1f, 0.1f);
        
    } completion:^(BOOL finished) {
        
        if (self.callCompletionBlockAfterHideAnimation && index && _completionBlock)
        {
            _completionBlock(index.integerValue);
        }
        
        [self removeFromSuperview];
        
    }];
}



#pragma mark - Selection
-(void) setSelectedIndex:(NSInteger)index
{
    for (ABLabel *label in _labelArray)
    {
        NSInteger currentIndex = [_labelArray indexOfObject:label];
        label.selected = (currentIndex == index);
    }
}



#pragma mark - ABViewDelegate
-(void) abViewDidTouchUpInside:(ABView *)view
{
    NSInteger index = [_stack.stackViews indexOfObject:view];
    if (index != _initialIndex)
    {
        [self hideWithSelectedIndex:@(index)];
        return;
    }
    [self hide];
}



#pragma mark - Theme
-(CGFloat) alphaBackgroundView
{
    switch (_theme) {
        case ABSelectViewThemeDark:         return 0.5f;
        case ABSelectViewThemeTranslucent:  return 0.3f;
        case ABSelectViewThemeNone:         return 1.0f;
    }
    return 1.0f;
}

-(UIColor*) colorRow
{
    switch (_theme) {
        case ABSelectViewThemeDark:         return nil;
        case ABSelectViewThemeTranslucent:  return [UIColor colorWithWhite:0.0f alpha:0.9f];
        case ABSelectViewThemeNone:         return nil;
    }
    return nil;
}

-(UIColor*) colorRowSelected
{
    switch (_theme) {
        case ABSelectViewThemeDark:         return nil;
        case ABSelectViewThemeTranslucent:  return [UIColor colorWithWhite:0.1f alpha:0.9f];
        case ABSelectViewThemeNone:         return nil;
    }
    return nil;
}

-(UIColor*) colorLabel
{
    switch (_theme) {
        case ABSelectViewThemeDark:         return [UIColor colorWithWhite:0.1f alpha:1.0f];
        case ABSelectViewThemeTranslucent:  return [UIColor whiteColor];
        case ABSelectViewThemeNone:         return nil;
    }
    return nil;
}

-(UIColor*) colorLabelHighlighted
{
    switch (_theme) {
        case ABSelectViewThemeDark:         return [UIColor whiteColor];
        case ABSelectViewThemeTranslucent:  return [UIColor colorWithRed:0.561 green:0.913 blue:0.921 alpha:1.000];
        case ABSelectViewThemeNone:         return nil;
    }
    return nil;
}

-(BOOL) seperator
{
    switch (_theme) {
        case ABSelectViewThemeDark:         return NO;
        case ABSelectViewThemeTranslucent:  return YES;
        case ABSelectViewThemeNone:         return NO;
    }
    return NO;
}

@end
