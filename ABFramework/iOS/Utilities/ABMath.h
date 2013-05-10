//
//  ABMath.h
//  ABFramework
//
//  Created by Alexander Blunck on 3/17/13.
//  Copyright (c) 2013 Ablfx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ABMath : NSObject

//Basic
/**
 * Calculate the percentage of a "part" of a "total"
 * Returns Integer between 0 - 100
 */
NSInteger ABMathPercent(long long part, long long total);



//Radians / Degrees
CGFloat ABMathRadians(CGFloat degrees);
CGFloat ABMathDegrees(CGFloat radians);

@end
