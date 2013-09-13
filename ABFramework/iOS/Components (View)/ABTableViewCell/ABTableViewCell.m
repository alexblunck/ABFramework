//
//  ABTableViewCell.m
//  ABFramework
//
//  Created by Alexander Blunck on 7/15/13.
//  Copyright (c) 2013 Ablfx. All rights reserved.
//

#import "ABTableViewCell.h"

@interface ABTableViewCell ()
{
    BOOL _baseLayout;
    UIView *_selectedBackgroundView;
}
@end

@implementation ABTableViewCell

#pragma mark - LifeCycle
-(void) willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    
    self.contentView.frame = self.bounds;
    
    if (!_baseLayout) [self baseLayout];
}



#pragma mark - Layout
-(void) baseLayout
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    _selectedBackgroundView = [[UIView alloc] initWithFrame:self.contentView.bounds];
    _selectedBackgroundView.backgroundColor = self.backgroundColorSelected;
    _selectedBackgroundView.alpha = 0.0f;
    [self.contentView insertSubview:_selectedBackgroundView atIndex:0];
    
    if ([self respondsToSelector:@selector(abLayout)])
    {
        [self abLayout];
    }
}



#pragma mark - Long Touch
-(void) longTouch
{
    if ([self.delegate respondsToSelector:@selector(cellDidRecieveLongTouch:)])
    {
        [self.delegate cellDidRecieveLongTouch:self];
        
        //Make sure background selection is reversed after
        [self touchesEnded:nil withEvent:nil];
    }
}



#pragma mark - Touch
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self performSelector:@selector(longTouch) withObject:nil afterDelay:0.5];
    
    [UIView animateWithDuration:0.2f animations:^{
        _selectedBackgroundView.alpha = 1.0f;
    } completion:nil];
    
    [super touchesBegan:touches withEvent:event];
}

-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    
    [UIView animateWithDuration:0.2f animations:^{
        _selectedBackgroundView.alpha = 0.0f;
    } completion:nil];
    
    [super touchesEnded:touches withEvent:event];
}

-(void) touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    
    [UIView animateWithDuration:0.2f animations:^{
        _selectedBackgroundView.alpha = 0.0f;
    } completion:nil];
    
    [super touchesCancelled:touches withEvent:event];
}

-(void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [super touchesMoved:touches withEvent:event];
}



#pragma mark - Accessors
-(void) setBackgroundColorSelected:(UIColor*)backgroundColorSelected
{
    _backgroundColorSelected = backgroundColorSelected;
    
    _selectedBackgroundView.backgroundColor = _backgroundColorSelected;
}

-(void) setIndexPath:(NSIndexPath *)indexPath
{
    _indexPath = indexPath;
    
    [self setOddCell:(indexPath.row%2)];
}

-(void) setOddCell:(BOOL)oddCell
{
    _oddCell = oddCell;
    
    if (self.backgroundColorOdd && _oddCell)
    {
        self.backgroundColor = self.backgroundColorOdd;
        self.contentView.backgroundColor = self.backgroundColorOdd;
    }
    if (self.backgroundColorEven && !_oddCell)
    {
        self.backgroundColor = self.backgroundColorEven;
        self.contentView.backgroundColor = self.backgroundColorEven;
    }
}

-(void) setBackgroundColorOdd:(UIColor *)backgroundColorOdd
{
    _backgroundColorOdd = backgroundColorOdd;
    
    if (_oddCell) self.backgroundColor = self.backgroundColorOdd;
}

-(void) setBackgroundColorEven:(UIColor *)backgroundColorEven
{
    _backgroundColorEven = backgroundColorEven;
    
    if (!_oddCell) self.backgroundColor = self.backgroundColorEven;
    
}

@end
