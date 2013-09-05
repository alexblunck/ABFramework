//
//  ABButton.m
//  ABFramework
//
//  Created by Alexander Blunck on 2/4/13.
//  Copyright (c) 2013 Ablfx. All rights reserved.
//

#import "ABButton.h"

@interface ABButton ()
{
    ABBlockVoid _actionBlock;
}
@end

@implementation ABButton

#pragma mark - Utility
#pragma mark - Utility - Simple
+(id) buttonWithTarget:(id)target action:(SEL)selector
{
    return [[self alloc] initWithImageName:nil target:target action:selector block:nil];
}

+(id) buttonWithActionBlock:(ABBlockVoid)block
{
    return [[self alloc] initWithImageName:nil target:nil action:nil block:block];
}

#pragma mark - Utility - Image
+(id) buttonWithImageName:(NSString*)imageName target:(id)target action:(SEL)selector
{
    return [[self alloc] initWithImageName:imageName target:target action:selector block:nil];
}

+(id) buttonWithImageName:(NSString*)imageName actionBlock:(ABBlockVoid)block
{
    return [[self alloc] initWithImageName:imageName target:nil action:nil block:block];
}

#pragma mark - Utility - Text
+(id) buttonWithText:(NSString*)text target:(id)target action:(SEL)selector
{
    return [[self alloc] initWithText:text target:target action:selector actionBlock:nil];
}

+(id) buttonWithText:(NSString*)text actionBlock:(ABBlockVoid)block
{
    return [[self alloc] initWithText:text target:nil action:nil actionBlock:block];
}



#pragma mark - Initializer
#pragma mark - Initializer - Image
-(id) initWithImageName:(NSString*)imageName target:(id)target action:(SEL)selector block:(ABBlockVoid)block
{
    self = [super init];
    if (self)
    {
        [self setupImages:imageName];
        [self setupTouchDown];
        
        //Target / Selector Specific
        if (target && selector)
        {
            [self addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
        }
        
        //Block specific
        if (block)
        {
            _actionBlock = [block copy];
            [self addTarget:self action:@selector(selectedButton) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    return self;
}

#pragma mark - Initializer - Text
-(id) initWithText:(NSString*)text target:(id)target action:(SEL)selector actionBlock:(ABBlockVoid)block
{
    self = [super init];
    if (self)
    {
        //Create UIButton with default styling
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        
        //Adjust button frame to fit text + padding
        CGSize buttonSize = [button.titleLabel sizeForText:text];
        buttonSize = CGSizeOffset(buttonSize, 20, 20);
        button.frame = CGRectChangingCGSize(button.frame, buttonSize);
        
        [button setTitle:text forState:UIControlStateNormal];
        
        //Target / Selector specific
        if (target && selector)
        {
            [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
        }
        
        //Block speicfic
        if (block)
        {
            _actionBlock = [block copy];
            [button addTarget:self action:@selector(selectedButton) forControlEvents:UIControlEventTouchUpInside];
        }
        
        self.frame = button.bounds;
        [self addSubview:button];
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
            [self setImage:imageSel forState:UIControlStateHighlighted];
        }
        
        UIImage *imageDisabled = [UIImage imageNamed:[NSString stringWithFormat:@"%@-disabled", imageName]];
        if (imageDisabled)
        {
            [self setImage:imageDisabled forState:UIControlStateDisabled];
        }
    }
}

-(void) setupTouchDown
{
    [self addTarget:self action:@selector(dimAllSubViews) forControlEvents:UIControlEventTouchDown|UIControlEventTouchDragInside];
    [self addTarget:self action:@selector(unDimAllSubViews) forControlEvents:UIControlEventTouchUpInside|UIControlEventTouchUpOutside|UIControlEventTouchCancel|UIControlEventTouchDragOutside];
}



#pragma mark - Button
-(void) selectedButton
{
    if (_actionBlock)
    {
        _actionBlock();
    }
}

-(void) dimAllSubViews
{
    if (!self.dimSubViews) return;
    
    self.alpha = 0.5f;
}
-(void) unDimAllSubViews
{
    if (!self.dimSubViews) return;
    
    self.alpha = 1.0f;
}



#pragma mark - Accessors
#pragma mark - imageName
-(void) setImageName:(NSString *)imageName
{
    _imageName = imageName;
    
    UIImage *image = [UIImage imageNamed:_imageName];
    if (image)
    {
        [self setImage:image forState:UIControlStateNormal];
    }
}

#pragma mark - selectedImageName
-(void) setSelectedImageName:(NSString *)selectedImageName
{
    _selectedImageName = selectedImageName;
    
    UIImage *imageSel = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAutomatic];
    if (imageSel)
    {
        [self setImage:imageSel forState:UIControlStateHighlighted];
    }
}

-(void) setSelectedImage:(UIImage *)selectedImage
{
    _selectedImage = selectedImage;
    
    [self setImage:_selectedImage forState:UIControlStateHighlighted];
}

@end
