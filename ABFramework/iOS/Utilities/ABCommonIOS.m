//
//  ABCommonIOS.m
//  
//
//  Created by Alexander Blunck on 16/03/14.
//
//

#import "ABCommonIOS.h"

@implementation ABCommonIOS



#pragma mark - NSIndexPath Fast Creation
NSIndexPath* NSIndexPathMake(NSInteger section, NSInteger row)
{
    return [NSIndexPath indexPathForRow:row inSection:section];
}



@end
