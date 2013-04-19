//
//  ABAlertView.m
//  ABFramework
//
//  Created by Alexander Blunck on 11/11/12.
//  Copyright (c) 2012 Ablfx. All rights reserved.
//

#import "ABAlertView.h"

@interface ABAlertView ()
{
    ABBlockInteger _completionBlock;
    ABBlockVoid _voidCompletionBlock;
}
@end

@implementation ABAlertView

#pragma mark - Utility
+(id) showAlertWithMessage:(NSString*)message
{
    return [self showAlertWithMessage:message block:nil];
}

+(id) showAlertWithMessage:(NSString*)message block:(ABBlockVoid) block
{
    return [self showAlertWithTitle:@"" message:message block:block];
}

+(id) showAlertWithTitle:(NSString*) title
                 message:(NSString*) message
                   block:(ABBlockVoid) block
{
    return [[self alloc] initAlertWithTitle:title message:message block:nil voidBlock:block cancelButtonTitle:@"Ok" otherButtonTitles:nil];
}

+(id) showAlertWithTitle:(NSString*) title
                 message:(NSString*) message
                   block:(ABBlockInteger) block
       cancelButtonTitle:(NSString*) cancelButtonTitle
       otherButtonTitles:(NSArray*) otherButtonTitles
{
    return [[self alloc] initAlertWithTitle:title message:message block:block voidBlock:nil cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles];
}



#pragma mark - Initializer
-(id) initAlertWithTitle:(NSString*) title
                 message:(NSString*) message
                   block:(ABBlockInteger) block
               voidBlock:(ABBlockVoid) voidBlock
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
        
        _completionBlock = [block copy];
        _voidCompletionBlock = [voidBlock copy];
        
        //Show Alert
        [self show];
        
    }
    return self;
}



#pragma mark - UIAlertViewDelegate
-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //Execute Block
    if (_completionBlock)
    {
        _completionBlock(buttonIndex);
    }
    
    if (_voidCompletionBlock) {
        _voidCompletionBlock();
    }
}

@end
