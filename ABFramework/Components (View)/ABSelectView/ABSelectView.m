//
//  ABSelectView.m
//  ABFramework
//
//  Created by Alexander Blunck on 10/17/12.
//  Copyright (c) 2012 Ablfx. All rights reserved.
//

#import "ABSelectView.h"

@interface ABSelectView () <ABSelectViewItemDelegate>{
    UIView *_selectionTable;
    UIView *_shadowMask;
    ABBlockInteger _completionBlock;
}

@end

@implementation ABSelectView

#pragma mark - Utility
+(id) showWithStringArray:(NSArray*)stringArray
          completionBlock:(ABBlockInteger)block
{
    return [self showWithStringArray:stringArray defaultIndex:stringArray.count completionBlock:block];
}

+(id) showWithStringArray:(NSArray*)stringArray
             defaultIndex:(int)defaultIndex
          completionBlock:(ABBlockInteger)block
{
    return [self showInView:nil WithStringArray:stringArray defaultIndex:defaultIndex theme:[ABSelectViewTheme themeWithTag:ABSELECTVIEW_THEME_DEFAULT] completionBlock:block];
}

+(id) showWithStringArray:(NSArray*)stringArray
             defaultIndex:(int)defaultIndex
                    theme:(ABSelectViewTheme*)theme
          completionBlock:(ABBlockInteger)block
{
    return [self showInView:nil WithStringArray:stringArray defaultIndex:defaultIndex theme:theme completionBlock:block];
}

+(id) showInView:(UIView*)view
 WithStringArray:(NSArray*)stringArray
    defaultIndex:(int)defaultIndex
           theme:(ABSelectViewTheme*)theme
 completionBlock:(ABBlockInteger)block
{
    return [[self alloc] initWithView:view StringArray:stringArray defaultIndex:defaultIndex theme:theme completionBlock:block];
}



#pragma mark - Initializer
-(id) initWithView:(UIView*)view
       StringArray:(NSArray*)stringArray
      defaultIndex:(int)defaultIndex
             theme:(ABSelectViewTheme*)theme
   completionBlock:(ABBlockInteger)block
{
    self = [super init];
    if (self) {
        
        _completionBlock = block;
        
        CGRect applicationFrame = [UIView topView].bounds;
        
        if (UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation]))
        {
            applicationFrame = CGRectMake(applicationFrame.origin.x, applicationFrame.origin.y, applicationFrame.size.height, applicationFrame.size.width);
        }
        
        //Fill out Screen with View
        self.frame = CGRectMake(0, 0, applicationFrame.size.width, applicationFrame.size.height);
        self.backgroundColor = [UIColor clearColor];
        
        //Add Tap Gesture Recognizer On Background
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideWithoutIndex)];
        [self addGestureRecognizer:tapGesture];
        
        //View to hold all Cells
        _selectionTable = [UIView new];
        [self addSubview:_selectionTable];
        
        //Load images for selected theme
        UIImage *topImage = [UIImage imageNamed:theme.topRowImageName];
        UIImage *middleImage = [UIImage imageNamed:theme.middleRowImageName];
        UIImage *bottomImage = [UIImage imageNamed:theme.bottomRowImageName];
        
        //calculate selectionTable frame
        float tableHeight = topImage.size.height + bottomImage.size.height + ((stringArray.count-2)*middleImage.size.height);
        float tableWidth = middleImage.size.width;
        _selectionTable.frame = CGRectMake((self.bounds.size.width-tableWidth)/2, (self.bounds.size.height-tableHeight)/2, tableWidth, tableHeight);
        
        //Loop Through stringArray and create Cells
        int itr = 1;
        float currentYPosition = 0;
        for (NSString *string in stringArray) {
            //Choose correct cell image
            UIImage *cellImage;
            //TOP
            if (itr == 1) {
                cellImage = topImage;
            }
            //Bottom
            else if (itr == stringArray.count) {
                cellImage = bottomImage;
            }
            //Middle
            else {
                cellImage = middleImage;
            }
            
            //Increment current array iteration
            itr += 1;
            
            //Select Item (Cell)
            ABSelectViewItem *cell = [ABSelectViewItem itemWithString:string image:cellImage index:[stringArray indexOfObject:string]];
            cell.frame = CGRectMake(0, currentYPosition, cellImage.size.width, cellImage.size.height);
            cell.delegate = self;
            [_selectionTable addSubview:cell];
            
            //If current string is default index, highlight it
            if (defaultIndex == [stringArray indexOfObject:string]) {
                [cell labelWhite];
            }
            
            //Update Y posiiton for next Cell Background
            currentYPosition += cellImage.size.height;
        }
        
        //Shadow
        _shadowMask = [[UIView alloc] initWithFrame:_selectionTable.frame];
        _shadowMask.backgroundColor = [UIColor clearColor];
        
        _shadowMask.layer.shadowColor = [[UIColor blackColor] CGColor];
        _shadowMask.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
        _shadowMask.layer.shadowOpacity = 0.6f;
        _shadowMask.layer.shadowRadius = 7.0f;
        _shadowMask.layer.shadowPath = [[UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, tableWidth, tableHeight) cornerRadius:4.0f] CGPath];
        _shadowMask.layer.shouldRasterize = YES;
        
        [self insertSubview:_shadowMask belowSubview:_selectionTable];
        
        //Set Scale to 0 to allow animation
        _shadowMask.alpha = 0.0f;
        _shadowMask.transform = CGAffineTransformMakeScale(0.1f, 0.1f);
        _selectionTable.alpha = 0.0f;
        _selectionTable.transform = CGAffineTransformMakeScale(0.1f, 0.1f);
        
        [self showInView:view];
    }
    return self;
}



#pragma mark - Helper
-(void) showInView:(UIView*)view
{
    if (view)
    {
        [view addSubview:self];
    } else
    {
        [[UIView topView] addSubview:self];
    }
    
    [UIView animateWithDuration:0.2f delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.400];
        _selectionTable.alpha = 1.0f;
        _selectionTable.transform = CGAffineTransformMakeScale(1.1f, 1.1f);
        
        _shadowMask.alpha = 1.0f;
        _shadowMask.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
        
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1f delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
            _selectionTable.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
        } completion:nil];
    }];
}

-(void) hideWithIndex:(NSInteger)index
{
    if (index >= 0) {
        _completionBlock(index);
    }
    
    [UIView animateWithDuration:0.2f delay:0.0f options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.backgroundColor = [UIColor clearColor];
        _selectionTable.transform = CGAffineTransformMakeScale(0.1f, 0.1f);
        _selectionTable.alpha = 0.0f;
        
        _shadowMask.alpha = 0.0f;
        _shadowMask.transform = CGAffineTransformMakeScale(0.1f, 0.1f);
        
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

-(void) hideWithoutIndex
{
    [self hideWithIndex:-1];
}



#pragma mark - ABSelectViewItemDelegate
-(void) selectedIndex:(int)index
{
    [self hideWithIndex:index];
}



#pragma mark - Accessors
-(void) setLandscape:(BOOL)landscape
{
    _landscape = landscape;
    
    CGRect applicationFrame = applicationFrame = [[UIScreen mainScreen] applicationFrame];
    
    //Landscape
    if (_landscape) {
        applicationFrame = CGRectMake(applicationFrame.origin.x, applicationFrame.origin.y, applicationFrame.size.height, applicationFrame.size.width);
        self.frame = CGRectMake(0, 0, applicationFrame.size.width+20, applicationFrame.size.height);
    }
    //Portrait
    else {
        self.frame = CGRectMake(0, 0, applicationFrame.size.width+20, applicationFrame.size.height);
    }
    
    _selectionTable.center = self.center;
    _shadowMask.center = self.center;
}

@end
