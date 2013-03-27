//
//  ABAlertView.m
//  ABFramework
//
//  Created by Alexander Blunck on 11/11/12.
//  Copyright (c) 2012 Ablfx. All rights reserved.
//

#import "ABAlertView.h"

@interface ABAlertView () {
    ABBlockInteger _completionBlock;
}
@end

@implementation ABAlertView

#pragma mark - Utility
+(id) showAlertWithTitle:(NSString*) title
                 message:(NSString*) message
                   block:(ABBlockInteger) block
       cancelButtonTitle:(NSString*) cancelButtonTitle
       otherButtonTitles:(NSArray*) otherButtonTitles
{
    return [[self alloc] initAlertWithTitle:title message:message block:block cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles];
}



#pragma mark - Initializer
-(id) initAlertWithTitle:(NSString*) title
                 message:(NSString*) message
                   block:(ABBlockInteger) block
       cancelButtonTitle:(NSString*) cancelButtonTitle
       otherButtonTitles:(NSArray*) otherButtonTitles
{
    self = [super initWithTitle:title message:message delegate:self cancelButtonTitle:cancelButtonTitle otherButtonTitles:nil];
    if (self)
    {
        for (NSString* buttonTitle in otherButtonTitles)
        {
            [self addButtonWithTitle:buttonTitle];
        }
        
        _completionBlock = block;
        
        //Show Alert
        [self show];
        
    }
    return self;
}



#pragma mark - UIAlertViewDelegate
-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //Execute Block
    if (_completionBlock) {
        _completionBlock(buttonIndex);
    }
}

@end
