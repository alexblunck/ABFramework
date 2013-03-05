//
//  ABSelectViewItem.m
//  ABFramework
//
//  Created by Alexander Blunck on 10/18/12.
//  Copyright (c) 2012 Ablfx. All rights reserved.
//

#import "ABSelectViewItem.h"

@interface ABSelectViewItem () {
    int _itemIndex;
    UILabel *_label;
}
@end

@implementation ABSelectViewItem

#pragma mark - Utility
+(id) itemWithString:(NSString*)string image:(UIImage*)image index:(int)index
{
    return [[self alloc] initWithString:string image:image index:index];
}



#pragma mark - Initializer
- (id)initWithString:(NSString*)string image:(UIImage*)image index:(int)index
{
    self = [super init];
    if (self) {
        
        _itemIndex = index;
        
        //Cell Background
        UIImageView *cellBg = [UIImageView new];
        cellBg.image = image;
        cellBg.frame = CGRectMake(0, 0, image.size.width, image.size.height);
        [self addSubview:cellBg];
        
        //Label
        _label = [UILabel new];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.backgroundColor = [UIColor clearColor];
        _label.textColor = [UIColor colorWithWhite:0.089 alpha:1.000];
        _label.shadowColor = [UIColor colorWithWhite:0.428 alpha:1.000];
        _label.shadowOffset = CGSizeMake(1.0f, 1.0f);
        _label.font = [UIFont fontWithName:@"SourceSansPro-Semibold" size:21.0f];
        _label.text = string;
        //[label sizeToFit];
        //label.center = cellBg.center;
        [self addSubview:_label];
        
        //label.backgroundColor = [UIColor redColor];
        
        //label.frame = CGRectMake((cellBg.frame.size.width-(cellBg.frame.size.width-18))/2, 0, cellBg.frame.size.width-18, cellBg.frame.size.height);
        
        [_label sizeToFit];
        _label.frame = CGRectMake((cellBg.frame.size.width-(cellBg.frame.size.width-18))/2, 4, cellBg.frame.size.width-18, _label.frame.size.height);
        
        _label.adjustsFontSizeToFitWidth = YES;
        //_label.minimumFontSize = 10.0f;
        
        //Button
        UIButton *button = [UIButton new];
        button.frame = cellBg.frame;
        //[button addTarget:self action:@selector(buttonSelected) forControlEvents:UIControlEventTouchUpInside];
        [button addTarget:self action:@selector(labelWhite) forControlEvents:UIControlEventTouchDown|UIControlEventTouchDragInside];
        [button addTarget:self action:@selector(labelBlack) forControlEvents:UIControlEventTouchCancel|UIControlEventTouchUpOutside|UIControlEventTouchDragOutside];
        [self addSubview:button];
        
        //Use Gesture Recognizer to catch valid selection (odd iOS 5 issue keeps UIButton from called selector)
        if (IS_IOS6) {
            [button addTarget:self action:@selector(buttonSelected) forControlEvents:UIControlEventTouchUpInside];
        }
        else {
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(buttonSelected)];
            [self addGestureRecognizer:tapGesture];
        }
        
        
    }
    return self;
}



#pragma mark - Buttons
-(void) buttonSelected
{
    [self.delegate selectedIndex:_itemIndex];
}



#pragma mark - Helper
-(void) labelWhite
{
    _label.textColor = [UIColor colorWithWhite:0.910 alpha:1.000];
    _label.shadowColor = [UIColor blackColor];
    _label.shadowOffset = CGSizeMake(0.0f, 1.0f);
}

-(void) labelBlack
{
    _label.textColor = [UIColor colorWithWhite:0.089 alpha:1.000];
    _label.shadowColor = [UIColor colorWithWhite:0.428 alpha:1.000];
    _label.shadowOffset = CGSizeMake(1.0f, 1.0f);
}

@end
