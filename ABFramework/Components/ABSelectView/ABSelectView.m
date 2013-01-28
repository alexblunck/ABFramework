//
//  ABSelectView.m
//  ABFramework
//
//  Created by Alexander Blunck on 10/17/12.
//  Copyright (c) 2012 Ablfx. All rights reserved.
//

#import "ABSelectView.h"

@interface ABSelectView () <ABSelectViewItemDelegate>{
    UIView *selectionTable;
    UIView *shadowMask;
    void (^completionBlock) (int selectedIndex);
}

@end

@implementation ABSelectView

-(id) initWithView:(UIView*)view
       StringArray:(NSArray*)stringArray
      defaultIndex:(int)defaultIndex
             theme:(ABSelectViewTheme*)theme
   completionBlock:( void (^) (int selectedIndex) )block
{
    self = [super init];
    if (self) {
        
        completionBlock = block;
        
        CGRect applicationFrame = [[UIScreen mainScreen] applicationFrame];
        if (UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation])) {
            applicationFrame = CGRectMake(applicationFrame.origin.x, applicationFrame.origin.y, applicationFrame.size.height, applicationFrame.size.width);
        }
        
        //Fill out Screen with View
        self.frame = CGRectMake(0, 0, applicationFrame.size.width, applicationFrame.size.height);
        self.backgroundColor = [UIColor clearColor];
        
        //Add Tap Gesture Recognizer On Background
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideWithoutIndex)];
        [self addGestureRecognizer:tapGesture];
        
        //View to hold all Cells
        selectionTable = [UIView new];
        [self addSubview:selectionTable];
        
        //Load images for selected theme
        UIImage *topImage = [UIImage imageNamed:theme.topRowImageName];
        UIImage *middleImage = [UIImage imageNamed:theme.middleRowImageName];
        UIImage *bottomImage = [UIImage imageNamed:theme.bottomRowImageName];
        
        //calculate selectionTable frame
        float tableHeight = topImage.size.height + bottomImage.size.height + ((stringArray.count-2)*middleImage.size.height);
        float tableWidth = middleImage.size.width;
        selectionTable.frame = CGRectMake((self.bounds.size.width-tableWidth)/2, (self.bounds.size.height-tableHeight)/2, tableWidth, tableHeight);
        
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
            [selectionTable addSubview:cell];
            
            //If current string is default index, highlight it
            if (defaultIndex == [stringArray indexOfObject:string]) {
                [cell labelWhite];
            }
            
            //Update Y posiiton for next Cell Background
            currentYPosition += cellImage.size.height;
        }
        
        //Shadow
        shadowMask = [[UIView alloc] initWithFrame:selectionTable.frame];
        shadowMask.backgroundColor = [UIColor clearColor];
        
        shadowMask.layer.shadowColor = [[UIColor blackColor] CGColor];
        shadowMask.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
        shadowMask.layer.shadowOpacity = 0.6f;
        shadowMask.layer.shadowRadius = 7.0f;
        shadowMask.layer.shadowPath = [[UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, tableWidth, tableHeight) cornerRadius:4.0f] CGPath];
        shadowMask.layer.shouldRasterize = YES;
        
        [self insertSubview:shadowMask belowSubview:selectionTable];
        
        //Set Scale to 0 to allow animation
        shadowMask.alpha = 0.0f;
        shadowMask.transform = CGAffineTransformMakeScale(0.1f, 0.1f);
        selectionTable.alpha = 0.0f;
        selectionTable.transform = CGAffineTransformMakeScale(0.1f, 0.1f);
        
        [self showInView:view];
    }
    return self;
}

+(id) showInView:(UIView*)view
 WithStringArray:(NSArray*)stringArray
    defaultIndex:(int)defaultIndex
           theme:(ABSelectViewTheme*)theme
 completionBlock:( void (^) (int selectedIndex) )block
{
    return [[self alloc] initWithView:view StringArray:stringArray defaultIndex:defaultIndex theme:theme completionBlock:block];
}

+(id) showWithStringArray:(NSArray*)stringArray
             defaultIndex:(int)defaultIndex
                    theme:(ABSelectViewTheme*)theme
          completionBlock:( void (^) (int selectedIndex) )block
{
    return [[self alloc] initWithView:nil StringArray:stringArray defaultIndex:defaultIndex theme:theme completionBlock:block];
}

-(void) showInView:(UIView*)view {
    if (view) {
        [view addSubview:self];
    } else {
        [[[[[UIApplication sharedApplication] keyWindow] rootViewController] view] addSubview:self];
    }
    
    [UIView animateWithDuration:0.2f delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.400];
        selectionTable.alpha = 1.0f;
        selectionTable.transform = CGAffineTransformMakeScale(1.1f, 1.1f);
        
        shadowMask.alpha = 1.0f;
        shadowMask.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
        
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1f delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
            selectionTable.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
        } completion:nil];
    }];
    
}

-(void) hideWithIndex:(NSInteger)index {
    
    completionBlock(index);
    
    [UIView animateWithDuration:0.2f delay:0.0f options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.backgroundColor = [UIColor clearColor];
        selectionTable.transform = CGAffineTransformMakeScale(0.1f, 0.1f);
        selectionTable.alpha = 0.0f;
        
        shadowMask.alpha = 0.0f;
        shadowMask.transform = CGAffineTransformMakeScale(0.1f, 0.1f);
        
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

-(void) hideWithoutIndex {
    [self hideWithIndex:-1];
}

#pragma mark - ABSelectViewItemDelegate
-(void) selectedIndex:(int)index {
    [self hideWithIndex:index];
}

-(void) setLandscape:(BOOL)landscape {
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
    
    selectionTable.center = self.center;
    shadowMask.center = self.center;
    
}

@end