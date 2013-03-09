//
//  ABButton.m
//  ABFramework
//
//  Created by Alexander Blunck on 2/4/13.
//  Copyright (c) 2013 Ablfx. All rights reserved.
//

#import "ABButton.h"

@interface ABButton () {
    ABBlockVoid _actionBlock;
}
@end

@implementation ABButton

#pragma mark - Utility
#pragma mark - Selectors
+(id) buttonWithtTarget:(id)target selected:(SEL)selector
{
    return [[self alloc] initWithImageName:nil target:target selected:selector];
}

+(id) buttonWithImageName:(NSString*)imageName target:(id)target selected:(SEL)selector
{
    return [[self alloc] initWithImageName:imageName target:target selected:selector];
}



#pragma mark - Blocks
+(id) buttonWithActionBlock:(ABBlockVoid)actionBlock
{
    return [self buttonWithImageName:nil actionBlock:actionBlock];
}

+(id) buttonWithImageName:(NSString*)imageName actionBlock:(ABBlockVoid)actionBlock
{
    return [[self alloc] initWithImageName:imageName actionBlock:actionBlock];
}



#pragma mark - Initializer
#pragma mark - Selectors
-(id) initWithImageName:(NSString*)imageName target:(id)target selected:(SEL)selector
{
    self = [super init];
    if (self)
    {
        [self setupImages:imageName];
        
        [self addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}


#pragma mark - Blocks
-(id) initWithActionBlock:(ABBlockVoid)actionBlock
{
    return [self initWithImageName:nil actionBlock:actionBlock];
}

-(id) initWithImageName:(NSString*)imageName actionBlock:(ABBlockVoid)actionBlock
{
    self = [super init];
    if (self)
    {
        _actionBlock = actionBlock;
        
        [self setupImages:imageName];
        
        [self addTarget:self action:@selector(selectedButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}



#pragma mark - Setup
-(void) setupImages:(NSString*)imageName
{
    if (imageName)
    {
        UIImage *image = [UIImage imageNamed:imageName];
        [self setImage:image forState:UIControlStateNormal];
        
        //Set own frame to fit image
        self.frame = CGRectChangingCGSize(CGRectZero, image.size);
        
        UIImage *imageSel = [UIImage imageNamed:[NSString stringWithFormat:@"%@-sel", imageName]];
        if (imageSel)
        {
            [self setImage:imageSel forState:UIControlStateSelected];
        }
    }
}



#pragma mark - Button
-(void) selectedButton
{
    if (_actionBlock) {
        _actionBlock();
    }
}

@end
