//
//  NSMutableAttributedString+ABFramework.h
//  
//
//  Created by Alexander Blunck on 17/03/14.
//
//

#import <Foundation/Foundation.h>

@interface NSMutableAttributedString (ABFramework)

// Helpers
-(void) appendAttributedStrings:(NSArray*)strings;
-(void) appendAttributedStrings:(NSArray*)strings lineBreaks:(BOOL)lineBreaks;
-(void) appendLineBreak;


@end
