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
#pragma mark - Selectors
+(id) buttonWithTarget:(id)target selector:(SEL)selector
{
    return [[self alloc] initWithImageName:nil target:target selector:selector];
}

+(id) buttonWithImageName:(NSString*)imageName target:(id)target selector:(SEL)selector
{
    return [[self alloc] initWithImageName:imageName target:target selector:selector];
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

+(id) buttonBasicWithText:(NSString*)text actionBlock:(ABBlockVoid)actionBlock
{
    return [[self alloc] initBasicWithText:text actionBlock:actionBlock];
}


#pragma mark - Initializer
-(id) init
{
    self = [super init];
    if (self)
    {
        //Config
        self.dimSubViews = NO;
    }
    return self;
}

#pragma mark - Selectors
-(id) initWithImageName:(NSString*)imageName target:(id)target selector:(SEL)selector
{
    self = [super init];
    if (self)
    {
        [self setupImages:imageName];
        
        [self setupTouchDown];
        
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
        _actionBlock = [actionBlock copy];
        
        [self setupImages:imageName];
        
        [self setupTouchDown];
        
        [self addTarget:self action:@selector(selectedButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

-(id) initBasicWithText:(NSString*)text actionBlock:(ABBlockVoid)actionBlock
{
    self = [super init];
    if (self)
    {
        _actionBlock = [actionBlock copy];
        
        //Create UIButton with default styling
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        
        //Adjust button frame to fit text + padding
        CGSize buttonSize = [button.titleLabel sizeForText:text];
        buttonSize = CGSizeOffset(buttonSize, 20, 20);
        button.frame = CGRectChangingCGSize(button.frame, buttonSize);
        
        [button setTitle:text forState:UIControlStateNormal];
        
        [button addTarget:self action:@selector(selectedButton) forControlEvents:UIControlEventTouchUpInside];
        
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
    if (_actionBlock) {
        _actionBlock();
    }
}

-(void) dimAllSubViews
{
    if (!self.dimSubViews) return;
    
    for (UIView* subView in self.subviews)
    {
        subView.alpha = 0.3f;
    }
}
-(void) unDimAllSubViews
{
    if (!self.dimSubViews) return;
    
    for (UIView* subView in self.subviews)
    {
        subView.alpha = 1.0f;
    }
}



#pragma mark - Conversion
-(UIBarButtonItem*) barButtonItem
{
    return [[UIBarButtonItem alloc] initWithCustomView:self];
}



#pragma mark - Accessors
#pragma mark - imageNamr
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
    
    UIImage *imageSel = [UIImage imageNamed:selectedImageName];
    if (imageSel)
    {
        [self setImage:imageSel forState:UIControlStateHighlighted];
    }
}

@end
