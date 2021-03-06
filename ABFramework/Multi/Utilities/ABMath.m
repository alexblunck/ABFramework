//
//  ABMath.m
//  ABFramework
//
//  Created by Alexander Blunck on 3/17/13.
//  Copyright (c) 2013 Ablfx. All rights reserved.
//

#import "ABMath.h"

@implementation ABMath

#pragma mark - Basic
NSInteger ABMathPercent(long long part, long long total)
{
    long long percent = (100 / (long double)total) * (long double)part;
    
    return (NSInteger)percent;
}

CGFloat ABMathDistance(CGPoint pointA, CGPoint pointB)
{
    CGFloat xDistance = (pointB.x - pointA.x);
    CGFloat yDistance = (pointB.y - pointA.y);
    return sqrt((xDistance * xDistance) + (yDistance * yDistance));
}



#pragma mark - Degrees / Radians
CGFloat ABMathRadians(CGFloat degrees)
{
    return degrees * M_PI / 180;
}

CGFloat ABMathDegrees(CGFloat radians)
{
    return radians * 180 / M_PI;
}

@end
