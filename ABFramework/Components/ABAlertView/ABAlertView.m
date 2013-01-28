//
//  ABAlertView.m
//  ABFramework
//
//  Created by Alexander Blunck on 11/11/12.
//  Copyright (c) 2012 Ablfx. All rights reserved.
//

#import "ABAlertView.h"


@interface ABAlertView () {
    void (^completionBlock) (NSInteger selectedIndex);
}
@end


@implementation ABAlertView

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code
    }
    return self;
}

-(id) initAlertWithTitle:(NSString *)title
                 message:(NSString *)message
                   block:( void (^) (NSInteger selectedIndex) )block
       cancelButtonTitle:(NSString *)cancelButtonTitle
       otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION
{
    self = [super initWithTitle:title message:message delegate:self cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles, nil];
    if (self) {
        
        completionBlock = block;
        
        //Show Alert
        [self show];
        
    } return self;
}

#pragma mark - Utility Methods
+(id) showAlertWithTitle:(NSString *)title
                 message:(NSString *)message
                   block:( void (^) (NSInteger selectedIndex) )block
       cancelButtonTitle:(NSString *)cancelButtonTitle
       otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION
{
    return [[self alloc] initAlertWithTitle:title message:message block:block cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles, nil];
}

#pragma mark - UIAlertViewDelegate
-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //Execute Block
    if (completionBlock) {
        completionBlock(buttonIndex);
    }
}

@end
