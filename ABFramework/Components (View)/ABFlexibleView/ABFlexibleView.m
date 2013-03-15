//
//  ABFlexibleView.m
//  ComingUp iOS
//
//  Created by Alexander Blunck on 3/14/13.
//  Copyright (c) 2013 Ablfx. All rights reserved.
//

#import "ABFlexibleView.h"

@interface ABFlexibleView ()
{
    ABFlexibleViewType _type;
    NSString *_baseName;
    CGFloat _partWidth;
    UIView *_topContainer;
    UIView *_bottomContainer;
    UIImageView *_left;
    UIImageView *_middle;
    UIImageView *_right;
}
@end

@implementation ABFlexibleView

#pragma mark - Initializer
-(id) initWithBaseName:(NSString*)baseName type:(ABFlexibleViewType)type frame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _type = type;
        _baseName = [baseName copy];
        
        if (type == ABFlexibleViewTypeAll)
        {
            [self layoutAll];
        }
        else if (type == ABFlexibleViewTypeHorizontal)
        {
            [self layoutHorizontal];
        }
    }
    return self;
}

-(id) init
{
    NSLog(@"ABFlexibleView -> Use custom initializer");
    return nil;
}

-(id) initWithFrame:(CGRect)frame
{
    return [self init];
}



#pragma mark - Layout
-(void) layoutAll
{
    //Top
    UIImageView *topLeft = [UIImageView imageViewWithImageName:[NSString stringWithFormat:@"%@-top-left", _baseName]];
    UIImageView *top = [UIImageView imageViewWithImageName:[NSString stringWithFormat:@"%@-top", _baseName]];
    UIImageView *topRight = [UIImageView imageViewWithImageName:[NSString stringWithFormat:@"%@-top-right", _baseName]];
    
    //Sides
    _left = [UIImageView imageViewWithImageName:[NSString stringWithFormat:@"%@-left", _baseName]];
    _right = [UIImageView imageViewWithImageName:[NSString stringWithFormat:@"%@-right", _baseName]];
    
    //Bottom
    UIImageView *bottomLeft = [UIImageView imageViewWithImageName:[NSString stringWithFormat:@"%@-bottom-left", _baseName]];
    UIImageView *bottom = [UIImageView imageViewWithImageName:[NSString stringWithFormat:@"%@-bottom", _baseName]];
    UIImageView *bottomRight = [UIImageView imageViewWithImageName:[NSString stringWithFormat:@"%@-bottom-right", _baseName]];
    
    //Part width
    _partWidth = topLeft.bounds.size.width;
    
    //Adjust sides frame height/width to fit within corners
    top.frame = CGRectChangingSizeWidth(top.frame, self.bounds.size.width - (_partWidth*2));
    bottom.frame = CGRectChangingSizeWidth(bottom.frame, self.bounds.size.width - (_partWidth*2));
    _left.frame = CGRectChangingSizeHeight(_left.frame, self.bounds.size.height - (_partWidth*2));
    _right.frame = CGRectChangingSizeHeight(_right.frame, self.bounds.size.height - (_partWidth*2));
    
    //Top / Bottom Containers
    _topContainer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, top.bounds.size.width + (_partWidth*2), _partWidth)];
    _bottomContainer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, bottom.bounds.size.width + (_partWidth*2), _partWidth)];
    
    //Position everything
    //Sides
    top.frame = CGRectInsideTopCenter(top.frame, _topContainer.bounds, 0);
    bottom.frame = CGRectInsideBottomCenter(bottom.frame, _bottomContainer.bounds, 0);
    _left.frame = CGRectInsideLeftCenter(_left.frame, self.bounds, 0);
    _right.frame = CGRectInsideRightCenter(_right.frame, self.bounds, 0);
    //Corners
    topLeft.frame = CGRectInsideTopLeft(topLeft.frame, _topContainer.bounds, 0);
    topRight.frame = CGRectInsideTopRight(topRight.frame, _topContainer.bounds, 0);
    bottomLeft.frame = CGRectInsideBottomLeft(bottomLeft.frame, _bottomContainer.bounds, 0);
    bottomRight.frame = CGRectInsideRightBottom(bottomRight.frame, _bottomContainer.bounds, 0);
    //Containers
    _topContainer.frame = CGRectInsideTopCenter(_topContainer.frame, self.bounds, 0);
    _bottomContainer.frame = CGRectInsideBottomCenter(_bottomContainer.frame, self.bounds, 0);
    
    //Add parts to containers
    [_topContainer addSubview:top];
    [_topContainer addSubview:topLeft];
    [_topContainer addSubview:topRight];
    [_bottomContainer addSubview:bottom];
    [_bottomContainer addSubview:bottomLeft];
    [_bottomContainer addSubview:bottomRight];
    
    //Add everything to own view
    [self addSubview:_topContainer];
    [self addSubview:_bottomContainer];
    [self addSubview:_left];
    [self addSubview:_right];
}

-(void) layoutHorizontal
{
    _left = [UIImageView imageViewWithImageName:[NSString stringWithFormat:@"%@-left", _baseName]];
    _middle = [UIImageView imageViewWithImageName:[NSString stringWithFormat:@"%@-middle", _baseName]];
    _right = [UIImageView imageViewWithImageName:[NSString stringWithFormat:@"%@-right", _baseName]];
    
    //Size
    _left.frame = CGRectChangingSizeHeight(_left.frame, self.bounds.size.height);
    _middle.frame = CGRectChangingSizeHeight(_middle.frame, self.bounds.size.height);
    _middle.frame = CGRectChangingSizeWidth(_middle.frame, self.bounds.size.width - _left.bounds.size.width - _right.bounds.size.width);
    _right.frame = CGRectChangingSizeHeight(_right.frame, self.bounds.size.height);
    
    //Position
    _left.frame = CGRectInsideLeftCenter(_left.frame, self.bounds, 0);
    _middle.frame = CGRectCenteredWithCGRect(_middle.frame, self.bounds);
    _right.frame = CGRectInsideRightCenter(_right.frame, self.bounds, 0);
    
    [self addSubview:_left];
    [self addSubview:_middle];
    [self addSubview:_right];
}



#pragma mark - Change
-(void) changeWidth:(CGFloat)newWidth animated:(BOOL)animated
{
    if (newWidth == self.bounds.size.width)
    {
        return;
    }
    
    //Own frame
    CGRect newRect = CGRectChangingSizeWidth(self.frame, newWidth);
    
    CGRect newRightRect = CGRectInsideRightCenter(_right.frame, newRect, 0);
    
    CGRect newMiddleRect = CGRectChangingSizeWidth(newRect, newRect.size.width - _left.bounds.size.width - newRightRect.size.width);
    newMiddleRect = CGRectCenteredWithCGRect(newMiddleRect, newRect);
    
    if (animated)
    {
        [UIView animateWithDuration:0.5f delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
            //
            self.frame = newRect;
            _right.frame = newRightRect;
            _middle.frame = newMiddleRect;
        } completion:^(BOOL finished) {
            //
        }];
    }
    else
    {
        self.frame = newRect;
        _right.frame = newRightRect;
        _middle.frame = newMiddleRect;
    }
}

-(void) changeHeight:(CGFloat)newHeight animated:(BOOL)animated
{
    //Don't do anything if height is the same
    if (newHeight == self.bounds.size.height)
    {
        return;
    }
    
    //Own frame
    CGRect newRect = CGRectChangingSizeHeight(self.frame, newHeight);
    
    //Bottom container
    CGRect newBottomRect = CGRectInsideBottomCenter(_bottomContainer.frame, CGRectChangingCGSize(CGRectZero, newRect.size), 0);
    
    //Left
    CGRect newLeftRect = CGRectChangingSizeHeight(_left.frame, newHeight - (_partWidth*2));
    
    //Right
    CGRect newRightRect = CGRectChangingSizeHeight(_right.frame, newHeight - (_partWidth*2));
    
    if (animated) {
        [UIView animateWithDuration:0.5f delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
            //
            self.frame = newRect;
            _bottomContainer.frame = newBottomRect;
            _left.frame = newLeftRect;
            _right.frame = newRightRect;
        } completion:^(BOOL finished) {
            //
        }];
    }
    else
    {
        self.frame = newRect;
        _bottomContainer.frame = newBottomRect;
        _left.frame = newLeftRect;
        _right.frame = newRightRect;
    }
}

@end
