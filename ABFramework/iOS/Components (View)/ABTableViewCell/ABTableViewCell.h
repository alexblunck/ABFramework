//
//  ABTableViewCell.h
//  ABFramework
//
//  Created by Alexander Blunck on 7/15/13.
//  Copyright (c) 2013 Ablfx. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ABTableViewCell;

//ABTableViewCellDelegate
@protocol ABTableViewCellDelegate <NSObject>

@optional

/**
 * Called when Cell is touched for a longer amount of time
 */
-(void) cellDidRecieveLongTouch:(ABTableViewCell*)cell;

@end

@protocol ABTableViewCellProtocol <NSObject>
@optional
/**
 * Called once before view moves to new superView
 * Override for custom view setup
 */
-(void) abLayout;
@end




//ABTableViewCell
@interface ABTableViewCell : UITableViewCell <ABTableViewCellProtocol>

/**
 * selectedBackgroundColor
 * Background color when cell is touched
 */
@property (nonatomic, copy) UIColor *backgroundColorSelected;

/**
 * indexPath
 * Set indexPath of cell to automatically determine if cell is an odd / even one
 */
@property (nonatomic, weak) NSIndexPath *indexPath;

/**
 * oddCell
 * Set to use specific backgroundColorOdd or backgroundColorEven color
 */
@property (nonatomic, assign) BOOL oddCell;

/**
 * backgroundColorOdd | backgroundColorEven
 * Background color for odd / even cells
 */
@property (nonatomic, copy) UIColor *backgroundColorOdd;
@property (nonatomic, copy) UIColor *backgroundColorEven;

@property (nonatomic, weak) id <ABTableViewCellDelegate> delegate;

@end
