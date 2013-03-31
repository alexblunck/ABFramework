//
//  ABSeperator.m
//  Serrano iOS
//
//  Created by Alexander Blunck on 3/30/13.
//  Copyright (c) 2013 Serrano - Ablfx. All rights reserved.
//

#import "ABSeperator.h"

@interface ABSeperator ()
{
    ABSeperatorType _type;
}
@end

@implementation ABSeperator

#pragma mark - Utility
+(id) seperatorWithType:(ABSeperatorType)type length:(CGFloat)length top:(NSString*)topColorHex bottom:(NSString*)bottomColorHex
{
    return [[self alloc] initWithType:type length:length top:[UIColor colorWithHexString:topColorHex] bottom:[UIColor colorWithHexString:bottomColorHex]];
}



#pragma mark - Initializer
-(id) initWithType:(ABSeperatorType)type length:(CGFloat)length top:(UIColor*)topColor bottom:(UIColor*)bottomColor
{
    self = [super init];
    if (self)
    {
        _type = type;
        
        //Set frame
        CGFloat width = ([self isVertical]) ? 1.5f : length;
        CGFloat height = ([self isVertical]) ? length : 1.5f;
        self.frame = CGRectMake(0, 0, width, height);
        
        //Top seperator
        CGFloat topSepWidth = ([self isVertical]) ? 1.0f : self.bounds.size.width;
        CGFloat topSepHeight = ([self isVertical]) ? self.bounds.size.height : 1.0f;
        UIView *topSep = [UIView new];
        topSep.frame = CGRectMake(0, 0, topSepWidth, topSepHeight);
        topSep.backgroundColor = topColor;
        [self addSubview:topSep];
        
        //Bottom seperator
        CGFloat bottomSepX = ([self isVertical]) ? 1.0f : 0.0f;
        CGFloat bottomSepY = ([self isVertical]) ? 0.0f : 1.0f;
        CGFloat bottomSepWidth = ([self isVertical]) ? 0.5f : self.bounds.size.width;
        CGFloat bottomSepHeight = ([self isVertical]) ? self.bounds.size.height : 0.5f;
        UIView *bottomSep = [UIView new];
        bottomSep.frame = CGRectMake(bottomSepX, bottomSepY, bottomSepWidth, bottomSepHeight);
        bottomSep.backgroundColor = bottomColor;
        [self addSubview:bottomSep];
    }
    return self;
}


#pragma mark - Helper
-(BOOL) isVertical
{
    if (_type == ABSeperatorTypeEtchedVertical)
    {
        return YES;
    }
    return NO;
}

@end
