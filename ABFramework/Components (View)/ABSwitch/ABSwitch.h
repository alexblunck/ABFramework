//
//  ABSwitch.h
//  ABFramework
//
//  Created by Alexander Blunck on 11/7/12.
//  Copyright (c) 2012 Ablfx. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ABSwitch;

@protocol ABSwitchDelegate <NSObject>
@optional
-(void) abSwitchDidChangeIndex:(ABSwitch*)sender;
//-(void) abSwitchDidMove:(ABSwitch*)sender;
@end

@interface ABSwitch : ABView

//Initializer
-(id) initWithBackgroundImage:(UIImage*)bgImage switchImage:(UIImage*)switchImage shadowImage:(UIImage*)shadowImage;


//Current selected Index (Either 0 or 1)
@property (nonatomic, assign) NSInteger currentIndex;

//Block that is called everytime index changes
@property (nonatomic, assign) ABBlockInteger block;
@property (nonatomic, copy) ABBlockInteger block;

//Delegate as alternative to using Blocks
@property (nonatomic, assign) id <ABSwitchDelegate> delegate;
@property (nonatomic, weak) id <ABViewDelegate, ABSwitchDelegate> delegate;

//If your background image uses rounded corners adjust this value to make the left/right color views fit with the background
@property (nonatomic, assign) CGFloat cornerRadius;

//Adjust vertical offset of switch image to make it fit with switch background
@property (nonatomic, assign) CGFloat switchOffsetY;

//Adjust horizontal offset of switch image to make it fit with the LEFT corner of the switch background
@property (nonatomic, assign) CGFloat switchOffsetXLeft;

//Adjust horizontal offset of switch image to make it fit with the RIGHT corner of the switch background
@property (nonatomic, assign) CGFloat switchOffsetXRight;

//Adjust
@property (nonatomic, assign) CGPoint backgroundShadowOffset;

//Show shadow below switch
@property (nonatomic, assign) BOOL showShadow;

@property(nonatomic, strong) UIColor *backgroundColor;

@property(nonatomic, assign, readonly) NSInteger currentSwitchPercent;

@end
