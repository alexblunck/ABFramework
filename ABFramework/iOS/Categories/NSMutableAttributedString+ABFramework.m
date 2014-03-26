//
//  NSMutableAttributedString+ABFramework.m
//  
//
//  Created by Alexander Blunck on 17/03/14.
//
//

#import "NSMutableAttributedString+ABFramework.h"

@implementation NSMutableAttributedString (ABFramework)



#pragma mark - Helpers
-(void) appendAttributedStrings:(NSArray*)strings
{
    [self appendAttributedStrings:strings lineBreaks:NO];
}

-(void) appendAttributedStrings:(NSArray*)strings lineBreaks:(BOOL)lineBreaks
{
    for (NSAttributedString *string in strings)
    {
        [self appendAttributedString:string];
        
        if (lineBreaks && [strings lastObject] != string)
        {
            [self appendLineBreak];
        }
    }
}

-(void) appendLineBreak
{
    [self appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n"]];
}



@end
