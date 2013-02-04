//
//  ABSelectViewItem.h
//  ABFramework
//
//  Created by Alexander Blunck on 10/18/12.
//  Copyright (c) 2012 Ablfx. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ABSelectViewItemDelegate <NSObject>
@optional
-(void) selectedIndex:(int)index;
@end

@interface ABSelectViewItem : UIView

//Utility
+(id) itemWithString:(NSString*)string image:(UIImage*)image index:(int)index;

//Helper
-(void) labelWhite;

@property (nonatomic, assign) id <ABSelectViewItemDelegate> delegate;

@end
