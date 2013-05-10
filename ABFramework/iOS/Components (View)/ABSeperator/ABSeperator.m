//
//  ABSeperator.m
//  ABFramework
//
//  Created by Alexander Blunck on 3/30/13.
//  Copyright (c) 2013 Ablfx. All rights reserved.
//

#import "ABSeperator.h"

@interface ABSeperator ()
{
    ABSeperatorType _type;
}
@end

@implementation ABSeperator

#pragma mark - Utility
+(id) seperatorWithType:(ABSeperatorType)type length:(CGFloat)length topHex:(NSString*)topColorHex bottomHex:(NSString*)bottomColorHex
{
    return [[self alloc] initWithType:type length:length top:[UIColor colorWithHexString:topColorHex] bottom:[UIColor colorWithHexString:bottomColorHex]];
}

+(id) seperatorWithType:(ABSeperatorType)type length:(CGFloat)length top:(UIColor*)topColor bottom:(UIColor*)bottomColor
{
    return [[self alloc] initWithType:type length:length top:topColor bottom:bottomColor];
}



#pragma mark - Initializer
-(id) initWithType:(ABSeperatorType)type length:(CGFloat)length top:(UIColor*)topColor bottom:(UIColor*)bottomColor
{
    self = [super init];
    if (self)
    {
        _type = type;
        
        CGFloat topWith = 1.0f;
        CGFloat bottomWidth = (IS_RETINA_DISPLAY) ? 0.5f : 1.0f;
        
        //Set frame
        CGFloat width = ([self isVertical]) ? topWith+bottomWidth : length;
        CGFloat height = ([self isVertical]) ? length : topWith+bottomWidth;
        self.frame = CGRectMake(0, 0, width, height);
        
        //Top seperator
        CGFloat topSepWidth = ([self isVertical]) ? topWith : self.bounds.size.width;
        CGFloat topSepHeight = ([self isVertical]) ? self.bounds.size.height : topWith;
        UIView *topSep = [UIView new];
        topSep.frame = CGRectMake(0, 0, topSepWidth, topSepHeight);
        topSep.backgroundColor = topColor;
        [self addSubview:topSep];
        
        //Bottom seperator
        CGFloat bottomSepX = ([self isVertical]) ? topWith : 0.0f;
        CGFloat bottomSepY = ([self isVertical]) ? 0.0f : topWith;
        CGFloat bottomSepWidth = ([self isVertical]) ? bottomWidth : self.bounds.size.width;
        CGFloat bottomSepHeight = ([self isVertical]) ? self.bounds.size.height : bottomWidth;
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
