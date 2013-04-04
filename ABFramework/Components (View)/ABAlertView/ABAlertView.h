//
//  ABAlertView.h
//  ABFramework
//
//  Created by Alexander Blunck on 11/11/12.
//  Copyright (c) 2012 Ablfx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ABAlertView : UIAlertView <UIAlertViewDelegate>

//Utility
+(id) showAlertWithTitle:(NSString*) title
                 message:(NSString*) message
                   block:(ABBlockVoid) block;

+(id) showAlertWithTitle:(NSString*) title
                 message:(NSString*) message
                   block:(ABBlockInteger) block
       cancelButtonTitle:(NSString*) cancelButtonTitle
       otherButtonTitles:(NSArray*) otherButtonTitles;

@end
