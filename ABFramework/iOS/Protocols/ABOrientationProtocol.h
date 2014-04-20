//
//  ABOrientationProtocol.h
//  
//
//  Created by Alexander Blunck on 15/04/14.
//
//

#import <UIKit/UIKit.h>

@protocol ABOrientationProtocol <NSObject>
@optional
-(BOOL) abShouldAutorotate;
-(NSUInteger) abSupportedInterfaceOrientations;
-(void) abWillRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration;
@end
