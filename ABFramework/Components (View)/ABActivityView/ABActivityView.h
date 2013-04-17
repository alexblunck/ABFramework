//
//  ABActivityView.h
//  ABFramework
//
//  Created by Alexander Blunck on 2/12/13.
//  Copyright (c) 2013 Ablfx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ABActivityView : UIView

//Initializer
- (id)initWithViewController:(UIViewController*)viewController;

//Display
-(void) show;

/*Set value for following keys
    'text'      => NSString for initial text
    'url'       => NSURL to share
    'image'     => UIImage to share
*/
@property (nonatomic, copy) NSDictionary *twitterDef;
@property (nonatomic, copy) NSDictionary *facebookDef;

@end
