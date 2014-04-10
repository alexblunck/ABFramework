//
//  UIView+Frame_ABFramework.m
//  
//
//  Created by Alexander Blunck on 26/03/14.
//
//

#import "UIView+Frame_ABFramework.h"

@implementation UIView (Frame_ABFramework)

#pragma mark - Access
-(CGFloat) right
{
    return self.frame.origin.x + self.frame.size.width;
}

-(CGFloat) left
{
    return self.frame.origin.x;
}

-(CGFloat) top
{
    return self.frame.origin.y;
}

-(CGFloat) bottom
{
    return self.frame.origin.y + self.frame.size.height;
}

-(CGFloat) width
{
    return self.frame.size.width;
}

-(CGFloat) height
{
    return self.frame.size.height;
}



#pragma mark - Position - Center
-(void) centerInView:(UIView*)view
{
    [self centerWithCGRect:view.bounds];
}

-(void) centerWithView:(UIView*)view
{
    [self centerWithCGRect:view.frame];
}

-(void) centerWithCGRect:(CGRect)rect
{
    self.frame = CGRectCenteredWithCGRect(self.frame, rect);
}

#pragma mark - Position - Center - Horizontally
-(void) centerHorizontallyInView:(UIView*)view
{
    [self centerHorizontallyWithCGRect:view.bounds originY:self.frame.origin.y];
}

-(void) centerHorizontallyWithView:(UIView*)view
{
    [self centerHorizontallyWithCGRect:view.frame originY:self.frame.origin.y];
}

-(void) centerHorizontallyWithCGRect:(CGRect)rect
{
    [self centerHorizontallyWithCGRect:rect originY:self.frame.origin.y];
}

-(void) centerHorizontallyInView:(UIView*)view originY:(CGFloat)y
{
    [self centerHorizontallyWithCGRect:view.bounds originY:y];
}

-(void) centerHorizontallyWithView:(UIView*)view originY:(CGFloat)y
{
    [self centerHorizontallyWithCGRect:view.frame originY:y];
}

-(void) centerHorizontallyWithCGRect:(CGRect)rect originY:(CGFloat)y
{
    self.frame = CGRectCenteredHorizontally(self.frame, rect, y);
}

#pragma mark - Position - Center - Vertically
-(void) centerVerticallyInView:(UIView*)view
{
    [self centerVerticallyWithCGRect:view.bounds originX:self.frame.origin.x];
}

-(void) centerVerticallyWithView:(UIView*)view
{
    [self centerVerticallyWithCGRect:view.frame originX:self.frame.origin.x];
}

-(void) centerVerticallyWithCGRect:(CGRect)rect
{
    [self centerVerticallyWithCGRect:rect originX:self.frame.origin.x];
}

-(void) centerVerticallyInView:(UIView*)view originX:(CGFloat)x
{
    [self centerVerticallyWithCGRect:view.bounds originX:x];
}

-(void) centerVerticallyWithView:(UIView*)view originX:(CGFloat)x
{
    [self centerVerticallyWithCGRect:view.frame originX:x];
}

-(void) centerVerticallyWithCGRect:(CGRect)rect originX:(CGFloat)x
{
    self.frame = CGRectCenteredVertically(self.frame, rect, x);
}

#pragma mark - Position - Relative - Inside
-(void) positionInsideTopLeft:(UIView*)view padding:(CGFloat)p
{
    self.frame = CGRectInsideTopLeft(self.frame, view.bounds, p);
}

-(void) positionInsideTopCenter:(UIView*)view padding:(CGFloat)p
{
    self.frame = CGRectInsideTopCenter(self.frame, view.bounds, p);
}

-(void) positionInsideTopRight:(UIView*)view padding:(CGFloat)p
{
    self.frame = CGRectInsideTopRight(self.frame, view.bounds, p);
}

-(void) positionInsideRightCenter:(UIView*)view padding:(CGFloat)p
{
    self.frame = CGRectInsideRightCenter(self.frame, view.bounds, p);
}

-(void) positionInsideRightBottom:(UIView*)view padding:(CGFloat)p
{
    self.frame = CGRectInsideRightBottom(self.frame, view.bounds, p);
}

-(void) positionInsideBottomCenter:(UIView*)view padding:(CGFloat)p
{
    self.frame = CGRectInsideBottomCenter(self.frame, view.bounds, p);
}

-(void) positionInsideBottomLeft:(UIView*)view padding:(CGFloat)p
{
    self.frame = CGRectInsideBottomLeft(self.frame, view.bounds, p);
}

-(void) positionInsideLeftCenter:(UIView*)view padding:(CGFloat)p
{
    self.frame = CGRectInsideLeftCenter(self.frame, view.bounds, p);
}


#pragma mark - Position - Relative - Outside
-(void) positionOutsideTopCenter:(UIView*)view padding:(CGFloat)p
{
    self.frame = CGRectOutsideTopCenter(self.frame, view.frame, p);
}

-(void) positionOutsideRightCenter:(UIView*)view padding:(CGFloat)p
{
    self.frame = CGRectOutsideRightCenter(self.frame, view.frame, p);
}

-(void) positionOutsideBottomCenter:(UIView*)view padding:(CGFloat)p
{
    self.frame = CGRectOutsideBottomCenter(self.frame, view.frame, p);
}

-(void) positionOutsideLeftCenter:(UIView*)view padding:(CGFloat)p
{
    self.frame = CGRectOutsideLeftCenter(self.frame, view.frame, p);
}



#pragma mark - Changing - Origin
-(void) changeOriginX:(CGFloat)x
{
    self.frame = CGRectChangingOriginX(self.frame, x);
}

-(void) changeOriginY:(CGFloat)y
{
    self.frame = CGRectChangingOriginY(self.frame, y);
}

-(void) changeOriginX:(CGFloat)x originY:(CGFloat)y
{
    self.frame = CGRectChangingOrigin(self.frame, x, y);
}

#pragma mark - Changing - Size
-(void) changeWidth:(CGFloat)width
{
    self.frame = CGRectChangingSizeWidth(self.frame, width);
}

-(void) changeHeight:(CGFloat)height
{
    self.frame = CGRectChangingSizeHeight(self.frame, height);
}

-(void) changeWidth:(CGFloat)width height:(CGFloat)height
{
    self.frame = CGRectChangingCGSize(self.frame, cgs(width, height));
}



#pragma mark - Offset - Origin
-(void) offsetOriginX:(CGFloat)x
{
    self.frame = CGRectOffsetOriginX(self.frame, x);
}

-(void) offsetOriginY:(CGFloat)y
{
    self.frame = CGRectOffsetOriginY(self.frame, y);
}

-(void) offsetOriginX:(CGFloat)x originY:(CGFloat)y
{
    self.frame = CGRectOffsetOrigin(self.frame, x, y);
}

#pragma mark - Offset - Size
-(void) offsetWidth:(CGFloat)width
{
    self.frame = CGRectOffsetSizeWidth(self.frame, width);
}

-(void) offsetHeight:(CGFloat)height
{
    self.frame = CGRectOffsetSizeHeight(self.frame, height);
}

-(void) offsetWidth:(CGFloat)width height:(CGFloat)height
{
    self.frame = CGRectOffsetSize(self.frame, width, height);
}

@end
