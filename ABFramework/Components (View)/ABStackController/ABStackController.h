//
//  ABStackController.h
//  ABFramework
//
//  Created by Alexander Blunck on 2/6/13.
//  Copyright (c) 2013 Ablfx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ABStackController : UIView

//Initializer
-(id) initWithWidth:(CGFloat)width fixedHeight:(CGFloat)fixedHeight;

//Add Views
-(void) addView:(UIView*)newView;
-(void) addViews:(NSArray*)newViews;

//Add Padding
-(void) addPadding:(CGFloat)padding;

@end
