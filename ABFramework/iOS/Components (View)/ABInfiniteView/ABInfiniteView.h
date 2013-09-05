//
//  ABInfiniteView.h
//  ABFramework
//
//  Created by Alexander Blunck on 4/21/13.
//  Copyright (c) 2013 Ablfx. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ABInfiniteView;

/**
 * ABInfiniteViewDataSource
 */
@protocol ABInfiniteViewDataSource <NSObject>
@required
-(NSUInteger) abInfiniteViewCount:(ABInfiniteView*)infiniteView;
-(ABView*) abInfiniteView:(ABInfiniteView*)infiniteView viewForIndex:(NSUInteger)index;
@end



/**
 * ABInfiniteViewDelegate
 */
@protocol ABInfiniteViewDelegate <NSObject>
@optional
-(void) abInfiniteView:(ABInfiniteView*)infiniteView didSelectViewAtIndex:(NSUInteger)index;
@end



/**
 * ABInfiniteView
 */
@interface ABInfiniteView : UIView

//Reload
-(void) reloadData;

//Automatic Scrolling
-(void) scrollWithTimeInterval:(NSTimeInterval)timeInterval;
-(void) stopScrolling;

//Access
-(NSArray*) allViews;
-(ABView*) viewAtIndex:(NSUInteger)index;

/**
 * Data Source / Delegate
 */
@property (nonatomic, weak) id <ABInfiniteViewDataSource> dataSource;
@property (nonatomic, weak) id <ABInfiniteViewDelegate> delegate;

@end
