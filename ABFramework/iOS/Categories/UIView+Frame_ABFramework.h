//
//  UIView+Frame_ABFramework.h
//  
//
//  Created by Alexander Blunck on 26/03/14.
//
//

#import <UIKit/UIKit.h>

@interface UIView (Frame_ABFramework)

// Access
-(CGFloat) right; //Returns X Point of the right edge of View
-(CGFloat) left; //Returns X Point of the left edge of View
-(CGFloat) top; //Returns Y Point of the top edge of View
-(CGFloat) bottom; //Returns Y Point of the bottom edge of View
-(CGFloat) width;
-(CGFloat) height;


// Position - Center
-(void) centerInView:(UIView*)view;
-(void) centerWithView:(UIView*)view;
-(void) centerWithCGRect:(CGRect)rect;
// Position - Center - Horizontally
-(void) centerHorizontallyInView:(UIView*)view;
-(void) centerHorizontallyWithView:(UIView*)view;
-(void) centerHorizontallyWithCGRect:(CGRect)rect;
-(void) centerHorizontallyInView:(UIView*)view originY:(CGFloat)y;
-(void) centerHorizontallyWithView:(UIView*)view originY:(CGFloat)y;
-(void) centerHorizontallyWithCGRect:(CGRect)rect originY:(CGFloat)y;
// Position - Center - Vertically
-(void) centerVerticallyInView:(UIView*)view;
-(void) centerVerticallyWithView:(UIView*)view;
-(void) centerVerticallyWithCGRect:(CGRect)rect;
-(void) centerVerticallyInView:(UIView*)view originX:(CGFloat)x;
-(void) centerVerticallyWithView:(UIView*)view originX:(CGFloat)x;
-(void) centerVerticallyWithCGRect:(CGRect)rect originX:(CGFloat)x;
// Frame - Position - Relative - Inside
-(void) positionInsideTopLeft:(UIView*)view padding:(CGFloat)p;
-(void) positionInsideTopCenter:(UIView*)view padding:(CGFloat)p;
-(void) positionInsideTopRight:(UIView*)view padding:(CGFloat)p;
-(void) positionInsideRightCenter:(UIView*)view padding:(CGFloat)p;
-(void) positionInsideRightBottom:(UIView*)view padding:(CGFloat)p;
-(void) positionInsideBottomCenter:(UIView*)view padding:(CGFloat)p;
-(void) positionInsideBottomLeft:(UIView*)view padding:(CGFloat)p;
-(void) positionInsideLeftCenter:(UIView*)view padding:(CGFloat)p;
// Frame - Position - Relative - Outside
-(void) positionOutsideTopCenter:(UIView*)view padding:(CGFloat)p;
-(void) positionOutsideRightCenter:(UIView*)view padding:(CGFloat)p;
-(void) positionOutsideBottomCenter:(UIView*)view padding:(CGFloat)p;
-(void) positionOutsideLeftCenter:(UIView*)view padding:(CGFloat)p;


// Frame - Changing - Origin
-(void) changeOriginX:(CGFloat)x;
-(void) changeOriginY:(CGFloat)y;
-(void) changeOriginX:(CGFloat)x originY:(CGFloat)y;
// Frame - Changing - Size
-(void) changeWidth:(CGFloat)width;
-(void) changeHeight:(CGFloat)height;
-(void) changeWidth:(CGFloat)width height:(CGFloat)height;


// Frame - Offset - Origin
-(void) offsetOriginX:(CGFloat)x;
-(void) offsetOriginY:(CGFloat)y;
-(void) offsetOriginX:(CGFloat)x originY:(CGFloat)y;
// Frame - Offset - Size
-(void) offsetWidth:(CGFloat)width;
-(void) offsetHeight:(CGFloat)height;
-(void) offsetWidth:(CGFloat)width height:(CGFloat)height;

@end
